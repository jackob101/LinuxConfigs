const hyprland = await Service.import("hyprland")

/**
 * @param {number} monitorId
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

export { Workspaces }
