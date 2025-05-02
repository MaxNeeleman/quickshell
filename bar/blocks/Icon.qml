import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import "../"
import "root:/"

BarBlock {
  id: root
  Layout.preferredWidth: 40

  content: BarText {
    text: "󰣇"
    pointSize: 17
    anchors.horizontalCenterOffset: -2
  }
  Image {
    anchors.fill: parent
    source: mouseArea.containsMouse
        ? "../images/" + Theme.get.iconPressedColor + ".png"
        : "../images/" + Theme.get.iconColor + ".png";
    visible: true
    z: -1
  }

  color: "transparent"

  Process {
    id: neofetch
    running: false
    command: [ "sh", "-c", "hyprctl dispatch exec [float] \
              \"foot -W 95x22 -e zsh -c 'neofetch; while true; do; done'\"" ]
    stdout: SplitParser {
      onRead: data => console.log(`line read: ${data}`)
    }
  }

  onClicked: function() {
    neofetch.running = true
  }
}

