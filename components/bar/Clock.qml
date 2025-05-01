import QtQuick
import QtQuick.Layouts
import "../../utils"

Rectangle {
    Layout.fillHeight: true
    Layout.preferredWidth: 150
    color: "transparent"

    Text {
        id: clockText
        text: Time.time
        color: Colors.fg
        anchors.centerIn: parent
        font.pixelSize: parent.height * 0.5
    }
}
