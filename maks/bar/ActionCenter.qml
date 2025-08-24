import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Mpris

PanelWindow {
    id: root
    
    // Properties that can be set from parent
    property int panelHeight: 350
    property bool expanded: false
    property string backgroundColor: "#cc000000"
    property string borderColor: '#cc000000'
    property int cornerRadius: 0
    
    implicitHeight: expanded ? panelHeight : 0
    visible: expanded
    color: backgroundColor
    
    // Position at top of screen with margin for the bar
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.exclusiveZone: 0
    WlrLayershell.margins.top: 0
    
    anchors {
        top: true
        left: false
        right: false
        bottom: false
    }
    
    Behavior on implicitHeight {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
    
    // Main content area with mouse tracking
    MouseArea {
        id: mainMouseArea
        anchors.fill: parent
        hoverEnabled: true
        
        onExited: {
            hideTimer.start()
        }
        
        onEntered: {
            hideTimer.stop()
        }
        
        // Timer to hide the action center when mouse leaves
        Timer {
            id: hideTimer
            interval: 150  // Small delay before hiding
            onTriggered: {
                root.hide()
            }
        }
        
        // Background with rounded corners at bottom only
        Rectangle {
            anchors.fill: parent
            color: root.backgroundColor
            radius: root.cornerRadius
            
            // Square overlay to clip top rounded corners
            Rectangle {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: root.cornerRadius
                color: root.backgroundColor
                visible: root.cornerRadius > 0
            }
        }
        
        // Border overlay with same shape
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.color: root.borderColor
            border.width: 1
            radius: root.cornerRadius
            
            // Square overlay to clip top rounded border corners
            Rectangle {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: root.cornerRadius + 1
                color: "transparent"
                border.color: root.borderColor
                border.width: 1
                visible: root.cornerRadius > 0
            }
            
            // Clean top border line
            Rectangle {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: 1
                color: root.borderColor
            }
        }
        
        ColumnLayout {
            id: contentLayout
            anchors {
                fill: parent
                margins: 15
                    topMargin: 20
                }
                spacing: 10
                
                // Horizontal menu tabs
                Row {
                    id: tabRow
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 30
                    
                    property string activeTab: "Dashboard"
                    
                    Item {
                        width: 80
                        height: 40
                        
                        Text {
                            anchors.centerIn: parent
                            text: "Dashboard"
                            color: tabRow.activeTab === "Dashboard" ? "#5E81AC" : "#D8DEE9"
                            font.pixelSize: 14
                            font.family: "Inter, sans-serif"
                            font.weight: tabRow.activeTab === "Dashboard" ? Font.Medium : Font.Normal
                        }
                        
                        Rectangle {
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width - 10
                            height: 2
                            color: "#5E81AC"
                            visible: tabRow.activeTab === "Dashboard"
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: tabRow.activeTab = "Dashboard"
                        }
                    }
                    
                    Item {
                        width: 80
                        height: 40
                        
                        Text {
                            anchors.centerIn: parent
                            text: "Media"
                            color: tabRow.activeTab === "Media" ? "#5E81AC" : "#D8DEE9"
                            font.pixelSize: 14
                            font.family: "Inter, sans-serif"
                            font.weight: tabRow.activeTab === "Media" ? Font.Medium : Font.Normal
                        }
                        
                        Rectangle {
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width - 10
                            height: 2
                            color: "#5E81AC"
                            visible: tabRow.activeTab === "Media"
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: tabRow.activeTab = "Media"
                        }
                    }
                    
                    Item {
                        width: 80
                        height: 40
                        
                        Text {
                            anchors.centerIn: parent
                            text: "Performance"
                            color: tabRow.activeTab === "Performance" ? "#5E81AC" : "#D8DEE9"
                            font.pixelSize: 14
                            font.family: "Inter, sans-serif"
                            font.weight: tabRow.activeTab === "Performance" ? Font.Medium : Font.Normal
                        }
                        
                        Rectangle {
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width - 10
                            height: 2
                            color: "#5E81AC"
                            visible: tabRow.activeTab === "Performance"
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: tabRow.activeTab = "Performance"
                        }
                    }
                    
                    Item {
                        width: 100
                        height: 40
                        
                        Text {
                            anchors.centerIn: parent
                            text: "Quick Settings"
                            color: tabRow.activeTab === "Quick Settings" ? "#5E81AC" : "#D8DEE9"
                            font.pixelSize: 14
                            font.family: "Inter, sans-serif"
                            font.weight: tabRow.activeTab === "Quick Settings" ? Font.Medium : Font.Normal
                        }
                        
                        Rectangle {
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width - 10
                            height: 2
                            color: "#5E81AC"
                            visible: tabRow.activeTab === "Quick Settings"
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: tabRow.activeTab = "Quick Settings"
                        }
                    }
                }
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                    border.color: root.borderColor
                    border.width: 1
                    radius: 4
                    
                    // Content based on active tab
                    StackLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        currentIndex: {
                            switch(tabRow.activeTab) {
                                case "Dashboard": return 0
                                case "Media": return 1
                                case "Performance": return 2
                                case "Quick Settings": return 3
                                default: return 0
                            }
                        }
                        
                        // Dashboard content
                        Item {
                            Text {
                                anchors.centerIn: parent
                                text: "dashboard"
                                color: "#D8DEE9"
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        
                        // Media content with MPRIS controls
                        MediaControls {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.margins: 5
                        }
                        
                        // Performance content
                        Item {
                            Text {
                                anchors.centerIn: parent
                                text: "performance"
                                color: "#D8DEE9"
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        
                        // Quick Settings content
                        Item {
                            Text {
                                anchors.centerIn: parent
                                text: "quick settings"
                                color: "#D8DEE9"
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                    }
                }
                
                // Rectangle {
                //     Layout.alignment: Qt.AlignHCenter
                //     Layout.preferredWidth: 100
                //     Layout.preferredHeight: 30
                //     color: closeMouseArea.containsMouse ? "#5E81AC" : "#4C566A"
                //     radius: 4
                    
                //     Text {
                //         anchors.centerIn: parent
                //         text: "Close"
                //         color: "white"
                //         font.pixelSize: 12
                //     }
                    
                //     MouseArea {
                //         id: closeMouseArea
                //         anchors.fill: parent
                //         hoverEnabled: true
                //         onClicked: root.hide()
                //     }
                    
                //     Behavior on color {
                //         ColorAnimation { duration: 150 }
                //     }
                // }
            }
        }
    
    // Public functions to control the action center
    function toggle() {
        console.log("ActionCenter toggle called, current expanded:", expanded)
        expanded = !expanded
    }
    
    function show() {
        console.log("ActionCenter show called")
        expanded = true
    }
    
    function hide() {
        console.log("ActionCenter hide called")
        expanded = false
        hideTimer.stop()  // Stop any pending hide timer
    }
}