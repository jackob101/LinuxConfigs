const hyprland = await Service.import('hyprland')

//TODO: should match based on connection. And then if connection is missing put it on another monitor
const definedWorkspaces = [
    {
        monitorId: 0,
        label: '1',
        id: 1,
    },
    {
        monitorId: 0,
        label: '2',
        id: 2,
    },
    {
        monitorId: 0,
        label: '3',
        id: 3,
    },
    {
        monitorId: 0,
        label: '4',
        id: 4,
    },
    {
        monitorId: 0,
        label: '5',
        id: 5,
    },
    {
        monitorId: 1,
        label: '6',
        id: 6,
    },
    {
        monitorId: 1,
        label: '7',
        id: 7,
    },
    {
        monitorId: 1,
        label: '8',
        id: 8,
    },
    {
        monitorId: 1,
        label: '9',
        id: 9,
    },
    {
        monitorId: 1,
        label: '10',
        id: 10,
    },
]

/**
 * @param {number} id
 */
function createWorkspaceButton(id, binds, monitorId) {
    let emptyBinding = hyprland.bind('workspaces').as((workspaces) => {
        let matchingWorkspace = workspaces.find((e) => e.id == id)
        if (
            matchingWorkspace?.windows == undefined ||
            matchingWorkspace.windows == 0
        ) {
            return ''
        }
        return 'occupied'
    })
    let activeWorkspaceBinding = binds.as((monitors) => {
        const matching = monitors.find(
            (e) => e.id == monitorId && e.activeWorkspaceId === id
        )
        return matching != null ? 'focused' : ''
    })
    let classNames = Utils.merge(
        [emptyBinding, activeWorkspaceBinding],
        (a, b) => a + ' ' + b
    )

    return Widget.Button({
        cursor: 'pointer',
        on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
        child: Widget.Label(`${id}`),
        class_name: classNames,
        attribute: id,
    })
}

/**
 * @param {number} monitorId
 */
function Workspaces(monitorId) {
    const activeWorkspace = hyprland.bind('monitors').as((monitors) => {
        return monitors.map((e) => {
            return {
                id: e.id,
                activeWorkspaceId: e.activeWorkspace.id,
            }
        })
    })

    const workspaces = definedWorkspaces
        .filter((e) => {
            return e.monitorId == monitorId
        })
        .sort((a, b) => a.id - b.id)
        .map(({ id }) => createWorkspaceButton(id, activeWorkspace, monitorId))

    return Widget.Box({
        vpack: 'center',
        class_name: 'workspaces',
        children: workspaces,
    })
}

export { Workspaces }
