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
            rect.x: root.parentWindow ? (root.parentWindow.width - 400) / 2 : 0  // Center horizontally
            rect.y: 32  // Below the top bar
            rect.width: 400  // Fixed width instead of full screen
            rect.height: 350  // Slightly taller
            edges: Quickshell.Anchor.Top
        }
        
        implicitWidth: 400
        implicitHeight: 350
        color: "transparent"
        
        // Add subtle drop shadow effect
        Rectangle {
            anchors.fill: parent
            anchors.margins: -2
            color: "transparent"
            border.color: "#00000040"
            border.width: 1
            radius: 10
            z: -1
        }
        
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
                anchors.margins: 20
                spacing: 20
                
                // Header with better spacing
                Row {
                    width: parent.width
                    
                    Text {
                        text: "Dashboard"
                        color: "#cdd6f4"
                        font.family: "Inter, sans-serif"
                        font.pixelSize: 20
                        font.weight: Font.Bold
                    }
                    
                    Item { Layout.fillWidth: true }
                    
                    // Close button moved to header
                    Rectangle {
                        width: 28
                        height: 28
                        color: "#f38ba8"
                        radius: 14
                        
                        Text {
                            anchors.centerIn: parent
                            text: "×"
                            color: "#1a1a1a"
                            font.pixelSize: 18
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
                
                // Quick stats row - more compact
                Row {
                    width: parent.width
                    height: 70
                    spacing: 12
                    
                    // System info card
                    Rectangle {
                        width: (parent.width - 24) / 3
                        height: parent.height
                        color: "#313244"
                        radius: 8
                        border.color: "#45475a"
                        border.width: 1
                        
                        Column {
                            anchors.centerIn: parent
                            spacing: 6
                            
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
                                font.pixelSize: 10
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            
                            Text {
                                text: "RAM: 8.2GB"
                                color: "#cdd6f4"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 10
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                    
                    // Network card
                    Rectangle {
                        width: (parent.width - 24) / 3
                        height: parent.height
                        color: "#313244"
                        radius: 8
                        border.color: "#45475a"
                        border.width: 1
                        
                        Column {
                            anchors.centerIn: parent
                            spacing: 6
                            
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
                                font.pixelSize: 10
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            
                            Text {
                                text: "192.168.1.100"
                                color: "#cdd6f4"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 10
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                    
                    // Audio card
                    Rectangle {
                        width: (parent.width - 24) / 3
                        height: parent.height
                        color: "#313244"
                        radius: 8
                        border.color: "#45475a"
                        border.width: 1
                        
                        Column {
                            anchors.centerIn: parent
                            spacing: 6
                            
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
                                font.pixelSize: 10
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            
                            Text {
                                text: "Speakers"
                                color: "#cdd6f4"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 10
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                }
                
                // Quick actions
                Column {
                    width: parent.width
                    spacing: 12
                    
                    Text {
                        text: "Quick Actions"
                        color: "#cdd6f4"
                        font.family: "Inter, sans-serif"
                        font.pixelSize: 16
                        font.weight: Font.Medium
                    }
                    
                    Row {
                        width: parent.width
                        height: 45
                        spacing: 12
                        
                        // WiFi toggle
                        Rectangle {
                            width: (parent.width - 24) / 3
                            height: parent.height
                            color: "#a6e3a1"
                            radius: 8
                            
                            Text {
                                anchors.centerIn: parent
                                text: "WiFi"
                                color: "#1a1a1a"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 13
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
                            width: (parent.width - 24) / 3
                            height: parent.height
                            color: "#74c7ec"
                            radius: 8
                            
                            Text {
                                anchors.centerIn: parent
                                text: "Bluetooth"
                                color: "#1a1a1a"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 13
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
                            width: (parent.width - 24) / 3
                            height: parent.height
                            color: "#313244"
                            radius: 8
                            border.color: "#45475a"
                            border.width: 1
                            
                            Text {
                                anchors.centerIn: parent
                                text: "Settings"
                                color: "#cdd6f4"
                                font.family: "Inter, sans-serif"
                                font.pixelSize: 13
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
                
                // Recent applications - more compact
                Column {
                    width: parent.width
                    spacing: 12
                    
                    Text {
                        text: "Recent Applications"
                        color: "#cdd6f4"
                        font.family: "Inter, sans-serif"
                        font.pixelSize: 16
                        font.weight: Font.Medium
                    }
                    
                    Row {
                        width: parent.width
                        height: 60
                        spacing: 12
                        
                        Repeater {
                            model: ["Firefox", "Terminal", "Files", "Code"]
                            
                            Rectangle {
                                width: (parent.width - 36) / 4
                                height: parent.height
                                color: "#313244"
                                radius: 8
                                border.color: "#45475a"
                                border.width: 1
                                
                                Column {
                                    anchors.centerIn: parent
                                    spacing: 6
                                    
                                    Rectangle {
                                        width: 28
                                        height: 28
                                        color: "#a6e3a1"
                                        radius: 6
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }
                                    
                                    Text {
                                        text: modelData
                                        color: "#cdd6f4"
                                        font.family: "Inter, sans-serif"
                                        font.pixelSize: 10
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }
                                }
                                
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        console.log("Launch " + modelData)
                                    }
                                }
                            }
                        }
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