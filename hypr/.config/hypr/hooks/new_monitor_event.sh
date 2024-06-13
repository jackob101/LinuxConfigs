#!/usr/bin/env bash

function restart_ags {
      killall ags
      ags &
}

function restart_swww {
  if [[ ${1:0:14} == "monitoraddedv2" ]]; then
    line=$(ps aux | grep swww-daemon | grep -v grep) 
    if [ -z "$line" ]
    then
      swww-daemon &
    fi
  fi
}

function handle {
  if [[ ${1:0:14} == "monitoraddedv2" ]]; then
    restart_ags $1
    restart_swww $1
  fi
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
