import QtQuick
import QtQuick.Layouts

Rectangle {
    id: ws

    property bool hovered: false

    Layout.preferredWidth: 5
    Layout.preferredHeight: 10
    Layout.minimumWidth: 5
    Layout.minimumHeight: 10
    Layout.alignment: Qt.AlignHCenter
    radius: height / 2

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: () => {
            ws.hovered = true;
        }
        onExited: () => {
            ws.hovered = false;
        }
        onClicked: () => console.log(`workspace ?`)
    }
}
