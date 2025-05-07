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
    command: ["sh", "-c", "cat /sys/class/power_supply/BAT0/capacity"]
    running: hasBattery

    stdout: SplitParser {
      onRead: function(data) {
        const capacity = parseInt(data.trim())
        statusProc.running = true
        let batteryIcon = "󰂂"
        if (capacity <= 20) batteryIcon = "󰁺"
        else if (capacity <= 40) batteryIcon = "󰁽"
        else if (capacity <= 60) batteryIcon = "󰁿"
        else if (capacity <= 80) batteryIcon = "󰂁"
        else batteryIcon = "󰂂"
        battery = `${batteryIcon} ${capacity}%`
      }
    }
  }

  Process {
    id: statusProc
    command: ["sh", "-c", "cat /sys/class/power_supply/BAT0/status"]
    running: false

    stdout: SplitParser {
      onRead: function(data) {
        const status = data.trim()
        const symbol = status === "Charging" ? "🔌" : battery.split(" ")[0]
        battery = `${symbol} ${battery.split(" ")[1]}`
      }
    }
  }

  Timer {
    interval: 1000
    running: hasBattery
    repeat: true
    onTriggered: batteryProc.running = true
  }
}