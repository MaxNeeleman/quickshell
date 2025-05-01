pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import "../../../utils"
import Quickshell.Hyprland

Rectangle {
    id: workspaces

    color: 'transparent'

    Layout.fillHeight: true
    Layout.preferredWidth: 100

    RowLayout {
        id: workspacesRow

        height: parent.height
        width: parent.width
        anchors.centerIn: parent

        spacing: 10

        Repeater {
            id: repeater

            model: HyprlandUtils.maxWorkspace || 1

            Workspace {
                id: ws
                required property int index
                property HyprlandWorkspace currWorkspace: Hyprland.workspaces.values.find(e => e.id == index + 1) || null
                property bool nonexistent: currWorkspace === null
                property bool focused: {
                    if (!Hyprland.focusedMonitor || !Hyprland.focusedMonitor.activeWorkspace) {
                        return false;
                    }
                    return index + 1 === Hyprland.focusedMonitor.activeWorkspace.id;
                }

                Layout.preferredWidth: {
                    if (focused) {
                        return 30;
                    } else {
                        return 20;
                    }
                }

                color: {
                    //if (nonexistent || !Hyprland.monitors.values || !Hyprland.workspaces.values) {
                    //    return Colors.bgBlur;
                    //}
                    const workspace = Hyprland.workspaces.values.find(e => e.id === index + 1);
                    if (!workspace || !workspace.monitor) {
                        return Colors.bgBlur;
                    }
                    const monitorIndex = Hyprland.monitors.values.indexOf(workspace.monitor);
                    if (monitorIndex < 0 || monitorIndex >= Colors.monitorColors.length) {
                        return Colors.bgBlur;
                    }
                    return Colors.monitorColors[monitorIndex];
                }
            }
        }
    }
}
