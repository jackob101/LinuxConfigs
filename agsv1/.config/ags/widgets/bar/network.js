const network = await Service.import("network")

function Network() {
    let icons = {
        unknown: "network-wired-offline-symbolic",
        none: "network-wired-offline-symbolic",
        portal: "network-wired-offline-symbolic",
        limited: "network-wired-offline-symbolic",
        full: "network-wired-symbolic",
    }

    return Widget.Icon({
        class_name: "smaller-icon",
        icon: network.bind("connectivity").as(value => icons[value]),
        tooltip_text: network.bind("connectivity").as(value => `Connection: ${value}`)
    })
}

export { Network }
