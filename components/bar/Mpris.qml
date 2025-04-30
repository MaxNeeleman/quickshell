import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Rectangle {
    Layout.fillHeight: true
    color: "transparent"
    Layout.preferredWidth: 300

    property string activeWindowTitle: {
        if (Hyprland.focusedMonitor?.activeWorkspace?.focusedWindow) {
            return Hyprland.focusedMonitor.activeWorkspace.focusedWindow.title;
        }
        return "";
    }

    Text {
        id: windowTitle
        anchors.centerIn: parent
        text: parent.activeWindowTitle
        color: "white"
        font.pixelSize: parent.height * 0.4
        elide: Text.ElideMiddle
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name === "windowtitle" || event.name === "focusedmon") {
                const title = Hyprland.focusedMonitor?.activeWorkspace?.focusedWindow?.title;
                console.log("Window event:", event.name, "Title:", title);
            }
        }
    }
}
