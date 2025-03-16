#! /bin/sh

path_to_wallpaper=$(find "$WALLHEAVEN_SYNC_STORAGE_PATH/walls/" -maxdepth 1 -type f | grep -v -E "index.json" | shuf -n 1)

hyprctl hyprpaper preload $path_to_wallpaper
hyprctl hyprpaper wallpaper ",$path_to_wallpaper"
sleep 1
hyprctl hyprpaper unload all

