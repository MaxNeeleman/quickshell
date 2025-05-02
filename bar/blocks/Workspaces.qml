import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import "../utils" as Utils
import "../Theme.qml" as Theme

RowLayout {
    spacing: 5
    property HyprlandMonitor monitor: Hyprland.monitorFor(screen)

    Repeater {
            id: repeater

            model: Utils.HyprlandUtils.maxWorkspace || 1

            Rectangle {
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
                Layout.preferredHeight: 20

                radius: 6
                opacity: mouseArea.containsMouse ? 0.9 : 1.0

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        Utils.HyprlandUtils.switchWorkspace(index + 1);
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    radius: parent.radius
                    border.width: focused ? 2 : 0
                    border.color: "black"
                }

                // Workspace number
                Text {
                    id: workspaceText
                    anchors.centerIn: parent
                    text: (index + 1).toString()
                    color: "black"
                    font.pixelSize: 12
                    font.bold: focused
                }
                
                // Hover effect
                Rectangle {
                    anchors.fill: parent
                    color: "grey"
                    radius: parent.radius
                    opacity: mouseArea.containsMouse ? 0.2 : 0
                    Behavior on opacity { NumberAnimation { duration: 150 } }
                }
            }
        }
}

