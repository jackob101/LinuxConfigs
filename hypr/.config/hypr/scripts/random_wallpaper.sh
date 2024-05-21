#!/bin/sh

SWWW_TRANSITION_STEP=60
SWWW_TRANSITION_FPS=144

path_to_wallpaper=$(find "$WALLHEAVEN_SYNC_STORAGE_PATH/walls/" -maxdepth 1 -type f | grep -v -E "index.json" | shuf -n 1)
swww img --transition-type wipe --transition-angle 0 "$path_to_wallpaper"
