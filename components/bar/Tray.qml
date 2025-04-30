import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

Rectangle {
    Layout.fillHeight: true
    color: "transparent"
    implicitWidth: 0
    visible: false  // Will be made visible when there are tray items
}
