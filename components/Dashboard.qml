// Dashboard.qml - Popout dashboard component
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import "../widgets"

QtObject {
    id: root
    
    property bool isVisible: false
    property var parentWindow: null
    
    // Single popup window that will be positioned by the parent
    property PopupWindow dashboardWindow: PopupWindow {
        id: dashboardWindow
        visible: root.isVisible
        
        anchor {
            window: root.parentWindow
            rect.x: 0
            rect.y: 32  // Below the top bar
            rect.width: root.parentWindow ? root.parentWindow.width : 400
            rect.height: 300
            edges: Quickshell.Anchor.Top | Quickshell.Anchor.Left | Quickshell.Anchor.Right
        }
        
        implicitWidth: root.parentWindow ? root.parentWindow.width : 400
        implicitHeight: 300
        color: "transparent"
        
        // Main dashboard container
        Rectangle {
            anchors.fill: parent
            color: "#1a1a1a"
            border.color: "#45475a"
            border.width: 1
            radius: 8
            
            // Dashboard content
            Column {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 16
                
                // Header
                Text {
                    text: "Dashboard"
                    color: "#cdd6f4"
                    font.family: "Inter, sans-serif"
                    font.pixelSize: 18
                    font.weight: Font.Bold
                }
                
                // Quick stats row
                Row {
                    width: parent.width
                    height: 80
                    spacing: 16
                    
                    // System info card
                    Rectangle {
                        width: (parent.width - 32) / 3
                        height: parent.height
                        color: "#313244"
                        radius: 8
                        border.color: "#45475a"
                        border.width: 1
                        
                        Column {
                            anchors.centerIn: parent
                            spacing: 4
                            
                            Text {
                                text: "System"
                                color: "#a6e3a1"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            
                            Text {
                                text: "CPU: 45%"
                                color: "#cdd6f4"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 11
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            
                            Text {
                                text: "RAM: 8.2GB"
                                color: "#cdd6f4"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 11
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                    
                    // Network card
                    Rectangle {
                        width: (parent.width - 32) / 3
                        height: parent.height
                        color: "#313244"
                        radius: 8
                        border.color: "#45475a"
                        border.width: 1
                        
                        Column {
                            anchors.centerIn: parent
                            spacing: 4
                            
                            Text {
                                text: "Network"
                                color: "#74c7ec"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            
                            Text {
                                text: "WiFi Connected"
                                color: "#cdd6f4"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 11
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            
                            Text {
                                text: "192.168.1.100"
                                color: "#cdd6f4"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 11
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                    
                    // Audio card
                    Rectangle {
                        width: (parent.width - 32) / 3
                        height: parent.height
                        color: "#313244"
                        radius: 8
                        border.color: "#45475a"
                        border.width: 1
                        
                        Column {
                            anchors.centerIn: parent
                            spacing: 4
                            
                            Text {
                                text: "Audio"
                                color: "#f9e2af"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            
                            Text {
                                text: "Volume: 75%"
                                color: "#cdd6f4"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 11
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            
                            Text {
                                text: "Speakers"
                                color: "#cdd6f4"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 11
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                }
                
                // Quick actions
                Column {
                    width: parent.width
                    spacing: 8
                    
                    Text {
                        text: "Quick Actions"
                        color: "#cdd6f4"
                        font.family: "Inter, sans-serif"
                        font.pixelSize: 14
                        font.weight: Font.Medium
                    }
                    
                    Row {
                        width: parent.width
                        height: 40
                        spacing: 12
                        
                        // WiFi toggle
                        Rectangle {
                            width: 100
                            height: parent.height
                            color: "#a6e3a1"
                            radius: 6
                            
                            Text {
                                anchors.centerIn: parent
                                text: "WiFi"
                                color: "#1a1a1a"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    console.log("WiFi toggle clicked")
                                }
                            }
                        }
                        
                        // Bluetooth toggle
                        Rectangle {
                            width: 100
                            height: parent.height
                            color: "#74c7ec"
                            radius: 6
                            
                            Text {
                                anchors.centerIn: parent
                                text: "Bluetooth"
                                color: "#1a1a1a"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    console.log("Bluetooth toggle clicked")
                                }
                            }
                        }
                        
                        // Settings button
                        Rectangle {
                            width: 100
                            height: parent.height
                            color: "#313244"
                            radius: 6
                            border.color: "#45475a"
                            border.width: 1
                            
                            Text {
                                anchors.centerIn: parent
                                text: "Settings"
                                color: "#cdd6f4"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    console.log("Settings clicked")
                                }
                            }
                        }
                    }
                }
            }
            
            // Close button
            Rectangle {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.margins: 12
                width: 24
                height: 24
                color: "#f38ba8"
                radius: 12
                
                Text {
                    anchors.centerIn: parent
                    text: "×"
                    color: "#1a1a1a"
                    font.pixelSize: 16
                    font.weight: Font.Bold
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        root.isVisible = false
                    }
                }
            }
        }
    }
    
    // Function to toggle dashboard
    function toggle() {
        root.isVisible = !root.isVisible
    }
    
    function show() {
        root.isVisible = true
    }
    
    function hide() {
        root.isVisible = false
    }
}