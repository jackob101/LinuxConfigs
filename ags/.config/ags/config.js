import GLib from "gi://GLib"
import Gdk from "gi://Gdk"
const network = await Service.import("network")
const hyprland = await Service.import("hyprland")
const notifications = await Service.import("notifications")
const audio = await Service.import("audio")
const systemtray = await Service.import("systemtray")
const display = Gdk.Display.get_default();


const date = Variable("", {
    poll: [1000, 'date "+%H:%M  %a %b %d"'],
})

const day = Variable("", {
    poll: [10000, 'date "+%D"']
})

// so to make a reuseable widget, make it a function
// then you can simply instantiate one by calling it

/**
 * @param {number} [monitorId]
 */
function Workspaces(monitorId) {
    const activeId = hyprland.active.workspace.bind("id")

    const createWorkspaceButton = (/** @type {number} */ id) => Widget.Button({
        cursor: "pointer",
        on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
        child: Widget.Label(`${id}`),
        class_name: activeId.as(i => `${i === id ? "focused" : ""}`),
        attribute: id
    })

    const workspaces = hyprland.bind("workspaces")
        .as(ws => ws.filter(e => {
            return e.monitorID == monitorId
        })
            .sort((a, b) => a.id - b.id)
            .map(({ id }) => createWorkspaceButton(id))
        )

    return Widget.Box({
        class_name: "workspaces",
        children: workspaces,
    })
}

function Clock() {
    return Widget.Label({
        class_name: "clock",
        label: date.bind(),
        tooltip_text: day.bind(),
    })
}


// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
function Notification() {
    const popups = notifications.bind("popups")
    return Widget.Box({
        class_name: "notification",
        visible: popups.as(p => p.length > 0),
        children: [
            Widget.Icon({
                icon: "preferences-system-notifications-symbolic",
            }),
            Widget.Label({
                label: popups.as(p => p[0]?.summary || ""),
            }),
        ],
    })
}

function Powermenu() {
    return Widget.Button({
        cursor: "pointer",
        class_name: "powerbutton",
        on_clicked: () => Utils.execAsync("/home/jackob/.config/rofi/powermenu/script.sh"),
        child: Widget.Label(""),
    })
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

/**
 * @param {number} bottom
 * @param {number} top
 * @param {number} value
 * @returns {number}
 */
function limitWithRange(bottom, top, value) {
    if (value >= top) {
        return top
    } else if (value <= bottom) {
        return bottom
    } else {
        return value
    }
}

function SysTray() {
    const items = systemtray.bind("items")
        .as(items => items.map(item => Widget.Button({
            child: Widget.Icon({ icon: item.bind("icon") }),
            on_primary_click: (_, event) => item.activate(event),
            on_secondary_click: (_, event) => item.openMenu(event),
            tooltip_markup: item.bind("tooltip_markup"),
        })))

    return Widget.Box({
        children: items,
        class_name: "systray"
    })
}

function Network() {
    let icons = {
        unknown: "network-wired-unavailable-symbolic",
        none: "network-wired-unavailable-symbolic",
        portal: "network-wired-unavailable-symbolic",
        limited: "network-wired-unavailable-symbolic",
        full: "network-wired-activated-symbolic",
    }

    return Widget.Icon({
        icon: network.bind("connectivity").as(value => icons[value]),
        tooltip_text: network.bind("connectivity").as(value => `Connection: ${value}`)
    })
}

function Launcher() {
    return Widget.Button({
        on_primary_click: () => Utils.execAsync("anyrun"),
        child: Widget.Icon({
            class_name: "launcher",
            icon: GLib.get_os_info("LOGO"),
            tooltip_text: "Launcher",
        })
    })
}


// layout of the bar
/**
 * @param {number} monitor
 */
function Left(monitor) {
    return Widget.Box({
        spacing: 8,
        hpack: "start",
        class_name: "widgets_container",
        children: [
            Launcher(),
            Workspaces(monitor),
        ],
    })
}

function Center() {
    return Widget.Box({
        spacing: 8,
        class_name: "widgets_container",
        children: [
            Clock(),
        ],
    })
}

function Right() {
    return Widget.Box({
        hpack: "end",
        spacing: 20,
        class_name: "widgets_container",
        children: [
            Network(),
            Volume(),
            SysTray(),
            Powermenu(),
        ],
    })
}


/**
 * @param {string | null} connectorName
 */
function getGdkMonitorId(connectorName) {

    if (display == null)
        return null

    const screen = display.get_default_screen();
    for (let i = 0; i < display.get_n_monitors(); ++i) {
        let name = screen.get_monitor_plug_name(i)
        if (connectorName === name) {
            return i
        }
    }
}

/**
 * @param {string} connectorName
 */
function Bar(connectorName, monitor = 0) {
    let gdkMonitorId = getGdkMonitorId(connectorName)
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: "bar",
        monitor: gdkMonitorId == null ? monitor : gdkMonitorId,
        anchor: ["bottom", "left", "right"],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
            class_name: "bar_content",
            start_widget: Left(monitor),
            center_widget: Center(),
            end_widget: Right(),
        }),
    })
}

// const scss = `${App.configDir}/style.scss`

// // target css file
// const css = `./style.css`
//
// // make sure sassc is installed on your system
// Utils.exec(`sassc ${scss} ${css}`)

App.config({
    style: "./style.css",
    windows: hyprland.monitors.map(e => Bar(e.name, e.id)),
})

export { }
