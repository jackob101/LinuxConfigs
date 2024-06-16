import Gdk from "gi://Gdk"
import { Launcher } from "./launcher.js"
import { Separator } from "./separator.js"
import { Network } from "./network.js"
import { SysTray } from "./systray.js"
import { Volume } from "./volume.js"
import { Workspaces } from "./workspaces.js"
import { Clock } from "./clock.js"
import { ExitScreen } from "./exit_screen.js"
import { Wallpaper } from "./wallpaper.js"
import { getGdkMonitorId } from "../../utils.js"

const spacing = 20

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
            ExitScreen(),
        ],
    })
}

/**
 * @param {string | null} connectorName
 */


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
