#!/usr/bin/env bash

#Path to style
theme="style.rasi"
dir="$HOME/.config/rofi/launcher/"

#exec command
rofi  -no-lazy-grab -show drun -show-icons -icon-theme "Papirus-Light" -theme $dir/"$theme"
