import Gdk from "gi://Gdk"
const display = Gdk.Display.get_default();

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

export default { getGdkMonitorId }
