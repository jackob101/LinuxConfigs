/**
 * @param {{ [x: string]: {shortcut_key: string, name: string, command: function}; }} operations
 */
function ShortcutsLegend(operations) {
    return Widget.Box({
        vertical: true,
        class_name: "shortcuts",
        children: Object.keys(operations)
            .map((key, _index) => {
                let operationDetails = operations[key]
                return Widget.Label({
                    hpack: "start",
                    label: `${operationDetails.shortcut_key.substring(0, 3)}\t${operationDetails.name}`
                })
            })

    })
}

export default ShortcutsLegend
