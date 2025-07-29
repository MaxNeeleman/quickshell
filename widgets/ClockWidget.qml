// ClockWidget.qml - Clock component
import Quickshell
import QtQuick
import "../services"

Rectangle {
    color: "transparent"
    
    Text {
        anchors.centerIn: parent
        text: Time.time
        color: "#cdd6f4"
        font.family: "Inter, sans-serif"
        font.pixelSize: 13
        font.weight: Font.Medium
    }
}