#!/bin/sh
jq_get_windows='
     # descend to workspace or scratchpad
     .nodes[].nodes[]
     # save workspace name as .w
     | {"w": .name} + (
       if (.nodes|length) > 0 then # workspace
         [recurse(.nodes[])]
       else # scratchpad
         []
       end
       + .floating_nodes
       | .[]
       # select nodes with no children (windows)
       | select(.nodes==[])
     )'

jq_windows_to_tsv='
    [
      (.id | tostring),
      # remove markup and index from workspace name, replace scratch with "[S]"
      (.w | gsub("<[^>]*>|:$"; "") | sub("__i3_scratch"; "[S]")),
      # get app name (or window class if xwayland)
      (.app_id // .window_properties.class),
      (.name)
    ]
    | @tsv'

get_fs_win_in_ws() {
  id="${1:?}"

  swaymsg -t get_tree |
    jq -e -r --argjson id "$id" "
    [ $jq_get_windows  ]
    | (.[]|select(.id == \$id)) as \$selected_workspace
    | .[]
    | select( .w == \$selected_workspace.w and .fullscreen_mode == 1 )
    | $jq_windows_to_tsv
    "
}

focus_window() {
  id="${1:?}"
  ws_name="${2:?}"
  app_name="${3:?}"
  win_title="${4:?}"

  printf 'focusing window (in workspace %s): [%s] (%s) `%s`\n' "$ws_name" "$win_id" "$app_name" "$win_title" >&2

  # look for fullscreen among other windows in selected window's workspace
  if fs_win_tsv="$( get_fs_win_in_ws "$id" )" ; then
    read -r win_id ws_name app_name win_title <<<"$fs_win_tsv"
    if [ "$win_id" != "$id" ] ; then
      printf 'found fullscreen window in target workspace (%s): [%s] (%s) "%s"\n' "$ws_name" "$win_id" "$app_name" "$win_title" >&2
      swaymsg "[con_id=$win_id] fullscreen disable"
    fi
  fi

  swaymsg "[con_id=$id]" focus
}

id_fmt='<span stretch="ultracondensed" size="xx-small">%s</span>'
ws_fmt='<span size="small">%s</span>'
app_fmt='<span weight="bold">%s</span>'
title_fmt='<span style="italic">%s</span>'

swaymsg -t get_tree |
  # get list of windows as tab-separated columns
  jq -r "$jq_get_windows | $jq_windows_to_tsv" |
  # align columns w/ spaces (keep tab as separator)
  column -s $'\t' -o $'\t' -t |
  # pango format the window list
  while IFS=$'\t' read -r win_id ws_name app_name win_title ; do
    printf \
      "${id_fmt}\t${ws_fmt}\t${app_fmt}\t${title_fmt}\n" \
      "$win_id" \
      "$ws_name" \
      "$app_name" \
      "$win_title"
  done |
  wofi -m --insensitive --show dmenu --prompt='Focus a window' |
  {
    IFS=$'\t' read -r win_id ws_name app_name win_title
    focus_window "$win_id" "$ws_name" "$app_name" "$win_title"
  }
