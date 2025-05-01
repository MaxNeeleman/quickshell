pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import "../../utils"

RowLayout {
    spacing: 3
    
    Repeater {
        id: repeater
        required property PanelWindow toplevel

        model: SystemTray.items

        Rectangle {
            required property SystemTrayItem modelData

            Layout.preferredWidth: height
            Layout.fillHeight: true
            onHeightChanged: {
                width = height
            }

            color: "transparent"

            Image {
                anchors.fill: parent
                anchors.margins: 3
                source: parent.modelData.icon
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                onClicked: (ev) => {
                    switch (ev.button) {
                        case Qt.LeftButton:
                            parent.modelData.activate();
                            break;
                        case Qt.MiddleButton:
                            parent.modelData.secondaryActivate();
                            break;
                        case Qt.RightButton:
                            console.log(parent.modelData.menu);
                            menuAnchor.menu = parent.modelData.menu;
                            menuAnchor.open();
                            break;
                    }
                }
                cursorShape: Qt.PointingHandCursor
            }

            QsMenuAnchor {
                id: menuAnchor

                anchor.window: repeater.toplevel
                anchor.onAnchoring: {
                    this.anchor.rect.x = parent.mapToItem(toplevel.contentItem, 0, 0).x
                    this.anchor.rect.y = parent.mapToItem(toplevel.contentItem, 0, 0).y
                }
                anchor.rect.width: parent.width
                anchor.rect.height: parent.height
                anchor.edges: Edges.Top
                anchor.gravity: Edges.Top
            }
        }
    }
}