import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: bat

    Layout.preferredWidth: batText.width
    Layout.fillHeight: true
    color: 'transparent'

    readonly property var battery: UPower.displayDevice
    readonly property int percentage: Math.round(battery.percentage * 100)

    visible: battery.isLaptopBattery

    Text {
        id: batText
        anchors.centerIn: parent
        text: bat.percentage + "%"
        color: "white"
        font.pixelSize: parent.height * 0.4
    }
}
