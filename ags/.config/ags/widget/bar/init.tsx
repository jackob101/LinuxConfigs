import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { bind, Variable } from "astal";
import Hyprland from "gi://AstalHyprland";
import utils from "../../utils";
import Workspaces from "./modules/workspaces";
import Clock from "./modules/clock";
import { SysTray } from "./modules/systray";
import { Volume } from "./modules/volume";
import { Network } from "./modules/network";

export default function Bar(hyprlandMonitor: Hyprland.Monitor) {
    const gdkMonitor = utils.getGdkMonitorId(hyprlandMonitor.get_name());
    if (gdkMonitor == null) {
        throw "Failed to get gdkMonitor id";
    }
    return (
        <window
            className="bar"
            gdkmonitor={gdkMonitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={
                Astal.WindowAnchor.BOTTOM |
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.RIGHT
            }
            application={App}
        >
            <centerbox>
                <Workspaces hyprlandMonitor={hyprlandMonitor} />
                <Clock />
                <box spacing={10} halign={Gtk.Align.END}>
                    <Network />
                    <Volume />
                    <SysTray />
                </box>
            </centerbox>
        </window>
    );
}
