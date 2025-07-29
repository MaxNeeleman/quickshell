// TopBar.qml - Main bar component with dashboard integration
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import "../widgets"

Scope {
    id: root

    // Dashboard instance
    Dashboard {
        id: dashboard
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 32
            color: "#1a1a1a"
            
            Component.onCompleted: {
                dashboard.parentWindow = this
            }

            // Main container with padding
            Rectangle {
                anchors.fill: parent
                color: "#1a1a1a"
                border.width: 0

                // Left section - Workspaces/Activities with dashboard button
                Rectangle {
                    id: leftSection
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: 140 // Increased width for dashboard button
                    color: "transparent"

                    Row {
                        anchors.centerIn: parent
                        spacing: 12

                        // Dashboard toggle button
                        Rectangle {
                            width: 20
                            height: 20
                            radius: 4
                            color: dashboard.isVisible ? "#a6e3a1" : "#313244"
                            border.width: 1
                            border.color: dashboard.isVisible ? "#a6e3a1" : "#45475a"
                            anchors.verticalCenter: parent.verticalCenter

                            Text {
                                anchors.centerIn: parent
                                text: "⊞"
                                color: dashboard.isVisible ? "#1a1a1a" : "#cdd6f4"
                                font.pixelSize: 10
                                font.weight: Font.Bold
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                
                                onClicked: {
                                    dashboard.toggle()
                                }
                                
                                onEntered: {
                                    parent.color = dashboard.isVisible ? "#a6e3a1" : "#45475a"
                                }
                                
                                onExited: {
                                    parent.color = dashboard.isVisible ? "#a6e3a1" : "#313244"
                                }
                            }
                        }

                        // Workspaces
                        Repeater {
                            model: Hyprland.workspaces

                            Rectangle {
                                required property HyprlandWorkspace modelData
                                
                                width: 12
                                height: 12
                                radius: 6
                                color: modelData.focused ? "#a6e3a1" : "#313244"
                                border.width: 1
                                border.color: modelData.focused ? "#a6e3a1" : "#45475a"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }

                // Center section - Window title
                Item {
                    anchors.centerIn: parent
                    width: 200 // Fixed width or use implicitWidth
                    id: waylandToplevel
    
                    Text {
                        anchors.centerIn: parent
                        text: Hyprland.activeToplevel?.title ?? qsTr("Desktop")
                        color: "#cdd6f4"
                        font.family: "Inter, sans-serif"
                        font.pixelSize: 13
                        font.weight: Font.Medium
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                // Right section - System info
                Row {
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 12
                    spacing: 16

                    // System Tray
                    Row {
                        spacing: 8
                        height: parent.height

                        Repeater {
                            model: SystemTray.items

                            Rectangle {
                                required property SystemTrayItem modelData
                                
                                width: 20
                                height: 20
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"

                                Image {
                                    anchors.fill: parent
                                    source: modelData.icon
                                    fillMode: Image.PreserveAspectFit
                                    smooth: true
                                }

                                MouseArea {
                                    id: trayMouseArea
                                    anchors.fill: parent
                                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor

                                    onClicked: {
                                        if (mouse.button === Qt.LeftButton) {
                                            modelData.activate()
                                        } else if (mouse.button === Qt.RightButton) {
                                            if (modelData.menu) {
                                                // Try creating a popup window for the menu
                                                console.log("Right-click menu - creating popup")
                                                menuLoader.active = true
                                            }
                                        }
                                    }
                                }

                                Loader {
                                    id: menuLoader
                                    active: false
                                    
                                    sourceComponent: PopupWindow {
                                        id: menuPopup
                                        
                                        width: menuContent.implicitWidth
                                        height: menuContent.implicitHeight
                                        
                                        color: "#1a1a1a"
                                        
                                        Rectangle {
                                            id: menuContent
                                            anchors.fill: parent
                                            color: "#1a1a1a"
                                            border.color: "#45475a"
                                            border.width: 1
                                            radius: 6
                                            
                                            QsMenuOpener {
                                                id: menuOpener
                                                menu: modelData.menu
                                            }
                                            
                                            // Style the menu items
                                            Column {
                                                anchors.fill: parent
                                                anchors.margins: 4
                                                
                                                Repeater {
                                                    model: menuOpener.menu ? menuOpener.menu.items : []
                                                    
                                                    Rectangle {
                                                        width: parent.width
                                                        height: 24
                                                        color: hoverArea.containsMouse ? "#313244" : "transparent"
                                                        
                                                        Text {
                                                            anchors.centerIn: parent
                                                            text: modelData.text || "Menu Item"
                                                            color: "#cdd6f4"
                                                            font.pixelSize: 12
                                                        }
                                                        
                                                        MouseArea {
                                                            id: hoverArea
                                                            anchors.fill: parent
                                                            hoverEnabled: true
                                                            onClicked: {
                                                                if (modelData.triggered) {
                                                                    modelData.triggered()
                                                                }
                                                                menuLoader.active = false
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        
                                        // Close menu when clicking outside or losing focus
                                        onVisibleChanged: {
                                            if (!visible) {
                                                menuLoader.active = false
                                            }
                                        }
                                        
                                        Component.onCompleted: {
                                            visible = true
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Clock widget (clickable to toggle dashboard)
                    Rectangle {
                        width: 80
                        height: parent.height
                        color: "transparent"
                        
                        ClockWidget {
                            anchors.fill: parent
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                dashboard.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
}