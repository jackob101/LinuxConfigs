#!/bin/bash
inotifywait -mr . --exclude @girs -e close_write -e create -e delete -e move --format '%w %e %T' --timefmt '%H%M%S' | while read file event tm; do
    current=$(date +'%H%M%S')
    delta=$(expr $current - $tm)
    if [ $delta -lt 2 -a $delta -gt -2 ]; then
        ags quit -i bar
        ags run &
    fi
done
