#!/bin/sh

/bin/find $HOME/wallsync/walls/ -maxdepth 1 -type f | /bin/grep -v -E "index.json" | /bin/shuf -n 1| xargs /bin/swww img --transition-type wipe --transition-angle 50 --transition-step 90
