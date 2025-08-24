import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "blocks" as Blocks
import "root:/"

Scope {
  IpcHandler {
    target: "bar"

    function toggleVis(): void {
      // Toggle visibility of all bar instances
      for (let i = 0; i < Quickshell.screens.length; i++) {
        barInstances[i].visible = !barInstances[i].visible;
      }
    }
    
    function toggleActionCenter(): void {
      // Toggle action center on primary monitor
      if (actionCenterWindow) {
        actionCenterWindow.toggle();
      }
    }
  }

  property var barInstances: []
  
  // Action Center as a separate window
  ActionCenter {
    id: actionCenterWindow
    implicitWidth: 500
    panelHeight: 350
  }

  Variants {
    model: Quickshell.screens.length > 0 ? [Quickshell.screens[1]] : []  // Only primary monitor
  
    PanelWindow {
      id: bar
      property var modelData
      screen: modelData
      property var actionCenter: actionCenterWindow

      Component.onCompleted: {
        barInstances.push(bar);
      }

      color: "transparent"

      Rectangle {
        id: highlight
        anchors.fill: parent
        color: Theme.get.barBgColor
      }

      height: 30

      visible: true

      anchors {
        top: Theme.get.onTop
        bottom: !Theme.get.onTop
        left: true
        right: true
      }
    
      // Left Zone
      RowLayout {
        id: leftZone
        spacing: 20
        anchors {
          left: parent.left
          verticalCenter: parent.verticalCenter
          leftMargin: 10
        }

        // Blocks.Icon {}
        Blocks.Workspaces {}
        
        Blocks.ActiveWorkspace {
          id: activeWorkspace
          Layout.leftMargin: 150

          chopLength: {
            var space = Math.floor(bar.width / 3)  // Use 1/3 of bar width for left content
            return space * 0.08;
          }

          text: {
            var str = activeWindowTitle
            return str.length > chopLength ? str.slice(0, chopLength) + '...' : str;
          }

          color: {
            return Hyprland.focusedMonitor == Hyprland.monitorFor(screen)
              ? "#FFFFFF" : "#CCCCCC"
          }
        }
      }

      // Center Zone - Invisible hover area for action center
      Item {
        id: centerZone
        width: 200
        height: parent.height
        anchors.centerIn: parent
        
        // Invisible mouse area that triggers action center
        MouseArea {
          id: centerHoverArea
          anchors.fill: parent
          hoverEnabled: true
          
          onEntered: {
            if (actionCenterWindow) {
              actionCenterWindow.show()
            }
          }
          
          // Optional: Visual indicator when hovering (remove if you want it completely invisible)
          // Rectangle {
          //   anchors.fill: parent
          //   color: parent.containsMouse ? "#20FFFFFF" : "transparent"  // Very subtle highlight
          //   Behavior on color { ColorAnimation { duration: 150 } }
          // }
        }
      }

      // Right Zone
      RowLayout {
        id: rightZone
        spacing: 10
        anchors {
          right: parent.right
          verticalCenter: parent.verticalCenter
          rightMargin: 10
        }

        Blocks.SystemTray {}
        Blocks.Memory {}
        Blocks.Sound {}
        // Blocks.Date {}
        Blocks.Time {}
      }
      
    }
  }
}