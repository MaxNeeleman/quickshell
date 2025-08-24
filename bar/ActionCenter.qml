import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root
    
    // Properties that can be set from parent
    property int panelHeight: 350
    property bool expanded: false
    property string backgroundColor: "#cc000000"
    property string borderColor: "#cc000000"
    
    implicitWidth: 500
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
        
        Rectangle {
            anchors.fill: parent
            color: root.backgroundColor
            border.color: root.borderColor
            border.width: 1
            
            // Rounded corners only on the bottom
            radius: 12
            
            // Clip the top corners to make them square
            Rectangle {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: 12  // Same as radius to cover the rounded top
                color: root.backgroundColor
                border.color: root.borderColor
                border.width: 1
            }
            
            Rectangle {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: 2
                color: root.borderColor
            }
            
            ColumnLayout {
                id: contentLayout
                anchors {
                    fill: parent
                    margins: 15
                    topMargin: 20
                }
                spacing: 10
                
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Action Center"
                    color: "white"
                    font.pixelSize: 16
                    font.bold: true
                }
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                    border.color: root.borderColor
                    border.width: 1
                    radius: 4
                    
                    Text {
                        anchors.centerIn: parent
                        text: "Future controls will go here:\n• Volume Control\n• Media Controls\n• System Toggles\n• System Monitoring"
                        color: "#D8DEE9"
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignHCenter
                        lineHeight: 1.2
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