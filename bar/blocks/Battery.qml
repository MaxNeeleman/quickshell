import QtQuick
import Quickshell.Io
import "../"

BarBlock {
  property string battery
  property bool hasBattery: false
  visible: hasBattery
  
  content: BarText {
    symbolText: battery
  }

  Process {
    id: batteryCheck
    command: ["sh", "-c", "test -d /sys/class/power_supply/BAT*"]
    running: true
    onExited: function(exitCode) { hasBattery = exitCode === 0 }
  }

  Process {
    id: batteryProc
    command: ["block_battery"]
    running: hasBattery

    stdout: SplitParser {
      onRead: data => battery = data
    }
  }

  Timer {
    interval: 1000
    running: hasBattery
    repeat: true
    onTriggered: batteryProc.running = true
  }
}