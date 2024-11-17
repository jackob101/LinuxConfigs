import { bind, Variable } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import Hyprland from "gi://AstalHyprland?version=0.1";
import utils from "../../utils";

import Notifd from "gi://AstalNotifd";

function generateListOfNotifications(notifications: Notifd.Notification[]) {
    const widgets = [];

    notifications.sort((a, b) => b.get_id() - a.get_id());
    for (const entry of notifications) {
        widgets.push(
            <centerbox>
                <box></box>
                <box></box>
                <button
                    className={"notification"}
                    hexpand={false}
                    onClick={(_) => entry.dismiss()}
                >
                    <box hexpand={false} vertical={true} spacing={10}>
                        <box className={"header"}>
                            <label
                                hexpand={true}
                                halign={Gtk.Align.CENTER}
                                label={entry.get_summary()}
                            />
                        </box>
                        <box
                            className={"body"}
                            vexpand={true}
                            valign={Gtk.Align.CENTER}
                        >
                            <label
                                hexpand={true}
                                halign={Gtk.Align.CENTER}
                                label={entry.get_body()}
                            />
                        </box>
                    </box>
                </button>
            </centerbox>,
        );
    }
    return widgets;
}

export default function Notification() {
    const hypr = Hyprland.get_default();
    const notifd = Notifd.get_default();

    const gdkMonitorBind = bind(hypr, "focusedMonitor").as((e) => {
        let gdkMonitor = utils.getGdkMonitorId(e.get_name());
        if (gdkMonitor == null) {
            throw "Failed to get gdk Monitor";
        }
        return gdkMonitor;
    });

    return (
        <window
            gdkmonitor={gdkMonitorBind}
            className="notification-container"
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
            application={App}
            exclusivity={Astal.Exclusivity.NORMAL}
            margin={10}
        >
            <box
                spacing={10}
                vertical={true}
                halign={Gtk.Align.END}
                valign={Gtk.Align.END}
            >
                {bind(notifd, "notifications").as(generateListOfNotifications)}
            </box>
        </window>
    );
}
