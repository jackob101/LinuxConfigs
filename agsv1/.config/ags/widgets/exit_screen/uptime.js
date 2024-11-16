const uptime = Variable("", {
    poll: [10000, `uptime -p`, out => out.substring(3)],
})

function Uptime() {
    return Widget.Box({
        class_name: "uptime",
        hpack: "center",
        children: [
            Widget.Label("Uptime: "),
            Widget.Label({
                label: uptime.bind()
            })
        ]
    })
}

export default Uptime
