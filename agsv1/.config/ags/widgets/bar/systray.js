import variables from '../../variables.js'
const systemtray = await Service.import('systemtray')

let showTray = Variable(false)

function SysTray() {
    const items = Utils.merge(
        [systemtray.bind('items'), showTray.bind()],
        (items, showTray) => {
            if (showTray) {
                return items.map((item) =>
                    Widget.Button({
                        child: Widget.Icon({ icon: item.bind('icon') }),
                        class_name: 'smaller-icon',
                        on_primary_click: (_, event) => item.activate(event),
                        on_secondary_click: (_, event) => item.openMenu(event),
                        tooltip_markup: item.bind('tooltip_markup'),
                    })
                )
            } else {
                return []
            }
        }
    )

    const toggleButton = Widget.Button({
        cursor: 'pointer',
        child: Widget.Icon({
            icon: showTray
                .bind()
                .as((value) =>
                    value ? 'pan-end-symbolic' : 'pan-start-symbolic'
                ),
            class_name: 'bigger-icon',
            tooltipText: showTray
                .bind()
                .as((value) => (value ? 'Close tray' : 'Show tray')),
        }),
        on_primary_click_release: (_) => (showTray.value = !showTray.value),
    })

    const content = Widget.Box({
        children: items,
        spacing: variables.bar_spacing,
        class_name: 'systray',
    })

    return Widget.Box({
        children: [content, toggleButton],
        spacing: showTray
            .bind()
            .as((value) => (value ? variables.bar_spacing : 0)),
        class_name: 'systray',
    })
}

export { SysTray }
