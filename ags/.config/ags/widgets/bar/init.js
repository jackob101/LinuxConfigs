import Gdk from "gi://Gdk"
import { Launcher } from "./launcher.js"
import { Separator } from "./separator.js"
import { Network } from "./network.js"
import { SysTray } from "./systray.js"
import { Volume } from "./volume.js"
import { Workspaces } from "./workspaces.js"
import { Clock } from "./clock.js"
import { Powermenu } from "./powermenu.js"
import { Wallpaper } from "./wallpaper.js"

const spacing = 20
const display = Gdk.Display.get_default();

// layout of the bar
/**
 * @param {number} monitor
 */
function Left(monitor) {
    return Widget.Box({
        spacing: spacing,
        hpack: "start",
        class_name: "widgets_container widgets_container_left",
        children: [
            Launcher(),
            Separator(),
            Workspaces(monitor),
        ],
    })
}


function Right() {
    return Widget.Box({
        hpack: "end",
        spacing: spacing,
        class_name: "widgets_container widgets_container_right",
        children: [
            Wallpaper(),
            Network(),
            Volume(),
            SysTray(),
            Separator(),
            Clock(),
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
            // center_widget: Center(),
            end_widget: Right(),
        }),
    })
}

export { Bar }
