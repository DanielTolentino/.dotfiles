#  ____ _____
# |  _ \_   _|  Daniel Tolentino
# | | | || |    http://www.github.com/DanielTolentino
# | |_| || |
# |____/ |_|
#
# My fish config. Not much to see here; just some pretty standard stuff.

### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_features qmark-noglob
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths
set -U fish_user_paths $HOME/.local/share $HOME/Applications $fish_user_paths
#test $TERM != "screen"; and exec tmux

# Adapted from https://github.com/fish-shell/fish-shell/issues/4434#issuecomment-332626369
# only run in interactive (not automated SSH for example)
#if status is-interactive
# don't nest inside another tmux
#and not set -q TMUX
  # Adapted from https://unix.stackexchange.com/a/176885/347104
  # Create session 'main' or attach to 'main' if already exists.
  #tmux new-session -A -s main
#end

### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set TERM "xterm-256color"                         # Sets the terminal type
set EDITOR "emacsclient -t -a ''"                 # $EDITOR use Emacs in terminal
set VISUAL "emacsclient -c -a emacs"              # $VISUAL use Emacs in GUI mode

### SET MANPAGER
### Uncomment only one of these!

### "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

### "vim" as manpager
# set -x MANPAGER '/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

### "nvim" as manpager
# set -x MANPAGER "nvim -c 'set ft=man' -"

# Function for mkdir-cd#
function mkdir-cd
    mkdir -p -- $argv && cd -- $argv
end

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
# The bindings for !! and !$
if [ $fish_key_bindings = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | trim-right /)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Function for printing a column (splits input on whitespace)
# ex: echo 1 2 3 | coln 3
# output: 3
function coln
    while read -l input
        echo $input | awk '{print $'$argv[1]'}'
    end
end

# Function for printing a row
# ex: seq 3 | rown 3
# output: 3
function rown --argument index
    sed -n "$index p"
end

# Function for ignoring the first 'n' lines
# ex: seq 10 | skip 5
# results: prints everything but the first 5 lines
function skip --argument n
    tail +(math 1 + $n)
end

# Function for taking the first 'n' lines
# ex: seq 10 | take 5
# results: prints only the first 5 lines
function take --argument number
    head -$number
end

### END OF FUNCTIONS ###




# Meta
complete -c alacritty \
  -s "v" \
  -l "version" \
  -d "Prints version information"
complete -c alacritty \
  -s "h" \
  -l "help" \
  -d "Prints help information"
# Config
complete -c alacritty \
  -f \
  -l "config-file" \
  -d "Specify an alternative config file"
complete -c alacritty \
  -s "t" \
  -l "title" \
  -d "Defines the window title"
complete -c alacritty \
  -l "class" \
  -d "Defines the window class"
complete -c alacritty \
  -l "embed" \
  -d "Defines the X11 window ID (as a decimal integer) to embed Alacritty within"
complete -c alacritty \
  -x \
  -a '(__fish_complete_directories (commandline -ct))' \
  -l "working-directory" \
  -d "Start shell in specified directory"
complete -c alacritty \
  -l "hold" \
  -d "Remain open after child process exits"
complete -c alacritty \
  -s "o" \
  -l "option" \
  -d "Override config file options"

# Output
complete \
  -c alacritty \
  -l "print-events" \
  -d "Print all events to stdout"
complete \
  -c alacritty \
  -s "q" \
  -d "Reduces the level of verbosity (min is -qq)"
complete \
  -c alacritty \
  -s "qq" \
  -d "Reduces the level of verbosity"
complete \
  -c alacritty \
  -s "v" \
  -d "Increases the level of verbosity"
complete \
  -c alacritty \
  -s "vv" \
  -d "Increases the level of verbosity"
complete \
  -c alacritty \
  -s "vvv" \
  -d "Increases the level of verbosity"

complete \
  -c alacritty \
  -l "ref-test" \
  -d "Generates ref test"

complete \
  -c alacritty \
  -s "e" \
  -l "command" \
  -d "Execute command (must be last arg)"


### ALIASES ###
#alias clear='/bin/clear; echo; echo; seq 1 (tput cols) | sort -R | spark | lolcat; echo; echo'

# root privileges
alias doas="doas --"

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# vim and emacs
alias vim='nvim'
alias em='/usr/bin/emacs -nw'
alias emacs="emacsclient -c -a 'emacs'"
alias doomsync="~/.emacs.d/bin/doom sync"
alias doomdoctor="~/.emacs.d/bin/doom doctor"
alias doomupgrade="~/.emacs.d/bin/doom upgrade"
alias doompurge="~/.emacs.d/bin/doom purge"

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'

# pacman and yay
alias pacy='sudo pacman -S'			 #install standard pkgs
alias pacs='pacman -Ss'				 #search standard pkgs
alias pacsyu='sudo pacman -Syyu' 		 # update only standard pkgs
alias yayy='yay -S'                		 #install AUR pkgs
alias yays='yay -Ss'                		 #search AUR pkgs
alias yaysua='yay -Sua --noconfirm'              # update only AUR pkgs (yay)
alias yaysyu='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs (yay)
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'  # remove orphaned packages

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# switch between shells
# I do not recommend switching default SHELL from bash.
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

alias yt="mpv --ytdl-format=mp4"

alias btr="sudo .dotfiles/bt_restart.sh"

if status is-interactive
    # Commands to run in interactive sessions can go here


end

### SETTING THE STARSHIP PROMPT ###
starship init fish | source
