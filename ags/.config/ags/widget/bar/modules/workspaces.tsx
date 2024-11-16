import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { bind, Variable } from "astal";
import Hyprland from "gi://AstalHyprland";
import utils from "../../../utils";

export default function Workspaces(props: {
    hyprlandMonitor: Hyprland.Monitor;
}): JSX.Element {
    const hyprland = Hyprland.get_default();
    function workspaceClicked(id: number) {
        hyprland.dispatch("workspace", id.toString());
    }
    function toWidget(workspaceId: number, activeWorkspace: Variable<number>) {
        const isOccupied = bind(hyprland, "clients").as((workspaces) =>
            workspaces.some((e) => {
                return workspaceId === e.get_workspace().get_id();
            }),
        );
        const isActive = activeWorkspace((e) => {
            return workspaceId == e;
        });

        const cssClass = Variable.derive(
            [isActive, isOccupied],
            (active, workspaces) => {
                let cssClass = [];
                if (active) {
                    cssClass.push("active");
                }
                if (workspaces) {
                    cssClass.push("occupied");
                }
                return cssClass.join(" ");
            },
        );
        return (
            <button
                cursor="pointer"
                className={bind(cssClass)}
                onClick={(_) => workspaceClicked(workspaceId)}
            ></button>
        );
    }

    let workspaces: number[] =
        utils.getWorkspaceRules()[props.hyprlandMonitor.get_name()];
    print(
        "workspaces " +
            workspaces +
            "for monitor: " +
            props.hyprlandMonitor.get_name(),
    );
    if (workspaces === undefined) {
        return <box></box>;
    }
    workspaces.sort((a: number, b: number) => a - b);

    let activeWorkspace = Variable(workspaces[0]);

    bind(hyprland, "focusedWorkspace").subscribe((e) => {
        let isUpdateOnCurrentMonitor = workspaces.some(
            (id) => e != null && id === e.get_id(),
        );

        if (isUpdateOnCurrentMonitor) {
            activeWorkspace.set(e.get_id());
        }
    });

    return (
        <box className="workspaces">
            {workspaces.map((e) => toWidget(e, activeWorkspace))}
        </box>
    );
}
