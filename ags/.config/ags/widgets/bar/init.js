import { Launcher } from "./launcher.js"
import { Separator } from "./separator.js"
import { Network } from "./network.js"
import { SysTray } from "./systray.js"
import { Volume } from "./volume.js"
import { Workspaces } from "./workspaces.js"
import { Clock } from "./clock.js"
import { ExitScreen } from "./exit_screen.js"
import { Wallpaper } from "./wallpaper.js"
import ConfigUtils from "../../utils.js"
import variables from "../../variables.js"

/**
 * @param {number} monitor
 */
function Left(monitor) {
    return Widget.Box({
        spacing: variables.bar_spacing,
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
        spacing: variables.bar_spacing,
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
 * @param {string} connectorName
 */
function Bar(connectorName, monitor = 0) {
    let gdkMonitorId = ConfigUtils.getGdkMonitorId(connectorName)
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: "bar",
        monitor: gdkMonitorId == null ? monitor : gdkMonitorId,
        anchor: ["bottom", "left", "right"],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
            class_name: "bar_content",
            start_widget: Left(monitor),
            end_widget: Right(),
        }),
    })
}

export { Bar }
