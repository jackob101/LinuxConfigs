const time = Variable("", {
    poll: [1000, 'date "+%H:%M"'],
})

const date = Variable("", {
    poll: [1000, 'date "+%D"'],
})

const fullTimeDate = Variable("", {
    poll: [1000, 'date "+%T %A %B %y"'],
})

function Clock() {
    return Widget.Box({
        vertical: true,
        spacing: 0,
        children: [
            Widget.Label({
                class_name: "time",
                label: time.bind(),
            }),
            Widget.Label({
                class_name: "date",
                label: date.bind(),
            }),
        ],
        class_name: "clock",
        tooltip_text: fullTimeDate.bind(),
    })
}

export { Clock }
