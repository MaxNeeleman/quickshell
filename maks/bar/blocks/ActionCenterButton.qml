import QtQuick
import "../"

BarBlock {
    id: root
    
    // Reference to the action center instance
    property var actionCenter: null
    
    content: BarText {
        symbolText: actionCenter && actionCenter.expanded ? "󰍉" : "󰍉"  // Control center icon
        dim: !(actionCenter && actionCenter.expanded)
    }
    
    // Highlight when action center is open
    color: {
        if (actionCenter && actionCenter.expanded) {
            return "#5E81AC"  // Nord blue when active
        }
        if (mouseArea.containsMouse) {
            return hoveredBgColor
        }
        return "transparent"
    }
    
    onClicked: function() {
        console.log("ActionCenterButton clicked, actionCenter:", actionCenter)
        if (actionCenter) {
            console.log("ActionCenter found, calling toggle")
            actionCenter.toggle()
        } else {
            console.warn("ActionCenter reference not set on ActionCenterButton")
        }
    }
    
    // Visual feedback animation
    Behavior on color {
        ColorAnimation { duration: 200 }
    }
}