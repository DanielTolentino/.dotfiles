#!/bin/bash

DIM_TIMEOUT=300 # one minute
#let LOCK_TIMEOUT=$DIM_TIMEOUT+120
#let DPMS_TIMEOUT=$LOCK_TIMEOUT+60
let SUSPEND_TIMEOUT=$DIM_TIMEOUT+600

IDLE=~/.config/sway/idle


swayidle -w \
    timeout $SUSPEND_TIMEOUT "$IDLE/suspend.sh"
    before-sleep 'swaylock -f -c 000000'
