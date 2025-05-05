import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import "../utils" as Utils
import "root:/"

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
                        return 25;
                    } else {
                        return 20;
                    }
                }
                Layout.preferredHeight: {
                    if (focused) {
                        return 25;
                    } else {
                        return 20;
                    }
                }

                radius: 2
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
                    color: mouseArea.containsMouse ? "grey" : Theme.get.buttonBackgroundColor
                    radius: parent.radius
                    border.width: focused ? 3 : 2
                    border.color: Theme.get.buttonBorderColor
                }

                Text {
                    id: workspaceText
                    anchors.centerIn: parent
                    text: (index + 1).toString()
                    color: "white"
                    font.pixelSize: 15
                    font.bold: focused
                }
            }
        }
}

