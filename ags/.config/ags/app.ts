import { App, Gtk } from "astal/gtk3";
import { exec } from "astal";
import Bar from "./widget/bar/init";
import Hyprland from "gi://AstalHyprland";
import Notification from "./widget/notifications/init";

exec("sass ./style.scss /tmp/style.css");

function main() {
    const hypr = Hyprland.get_default();
    let bars = new Map();

    for (const entry of hypr.get_monitors()) {
        bars.set(entry, Bar(entry));
    }

    hypr.connect("monitor-added", (_, monitor) => {
        print("Added new monitor");
        bars.set(monitor, Bar(monitor));
    });

    hypr.connect("monitor-removed", (_, monitor) => {
        print("monitor-removed");
        bars.delete(monitor);
    });

    Notification();
}

App.start({
    icons: `${SRC}/icons/`,
    instanceName: "bar",
    css: "/tmp/style.css",
    main: main,
    requestHandler(request, res) {},
});
