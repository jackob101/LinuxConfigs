#!/bin/sh

path_to_wallpaper=$(find "$WALLHEAVEN_SYNC_STORAGE_PATH/walls/" -maxdepth 1 -type f | grep -v -E "index.json" | shuf -n 1)
swww img --transition-type simple --transition-step 2 --transition-duration 2 --transition-fps 144 "$path_to_wallpaper" --resize crop
