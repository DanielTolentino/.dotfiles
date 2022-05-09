#!/bin/bash
sink=
pactl load-module module-remap-sink \
  sink_name=remapper \
  master=$sink channels=2 \
  master_channel_map=front-left,front-right \
  channel_map=front-right,front-left
