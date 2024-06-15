const audio = await Service.import("audio")

function limitWithRange(bottom, top, value) {
    if (value >= top) {
        return top
    } else if (value <= bottom) {
        return bottom
    } else {
        return value
    }
}

function Volume() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    }

    function getIcon() {
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
            threshold => threshold <= audio.speaker.volume * 100)

        return `audio-volume-${icons[icon]}-symbolic`
    }

    const icon = Widget.Icon({
        class_name: "smaller-icon",
        icon: Utils.watch(getIcon(), audio.speaker, getIcon),
        tooltip_text: audio.speaker.bind("volume").as(newValue => Math.trunc(newValue * 100).toString() + "%")
    })

    return Widget.EventBox({
        child: Widget.Box({
            class_name: "volume",
            children: [icon],
        }),
        cursor: "pointer",
        on_secondary_click: _ => Utils.execAsync("pavucontrol"),
        on_primary_click: _ => Utils.execAsync("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
        on_scroll_up: _ =>
            audio.speaker.volume = limitWithRange(0, 150, audio.speaker.volume + 0.05),
        on_scroll_down: _ =>
            audio.speaker.volume = limitWithRange(0, 150, audio.speaker.volume - 0.05)
    })
}


export { Volume }
