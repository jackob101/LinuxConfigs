import variables from '../../variables.js'

const time = Variable('', {
    poll: [1000, 'date "+%H:%M  -  %a %d"'],
})

const date = Variable('', {
    poll: [1000, 'date "+%D"'],
})

const fullTimeDate = Variable('', {
    poll: [1000, 'date "+%T %A %B %y"'],
})

function Clock() {
    return Widget.Box({
        vertical: false,
        spacing: variables.bar_spacing,
        children: [
            Widget.Label({
                class_name: 'time',
                label: time.bind(),
            }),
        ],
        class_name: 'clock',
        tooltip_text: fullTimeDate.bind(),
    })
}

export { Clock }
