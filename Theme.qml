pragma Singleton

import QtQuick
import Quickshell

Singleton {
  property Item get: catppuccin
  
  Item {
    id: windowsXP

    property string barBgColor: "#235EDC"
    property string buttonBorderColor: "#99000000"
    property bool buttonBorderShadow: false
    property string buttonBackgroundColor: "#1111CC"
    property bool onTop: false
    property string iconColor: "green"
    property string iconPressedColor: "green"
    property Gradient barGradient: black.barGradient
    property Gradient buttonInactiveGradientV: Gradient {
      GradientStop { position: 0.0; color: "#55FFFFFF" }
      GradientStop { position: 0.3; color: "#22FFFFFF" }
    }
    property Gradient buttonInactiveGradientH: Gradient {
      orientation: Gradient.Horizontal
      GradientStop { position: 0.0; color: "#55FFFFFF" }
      GradientStop { position: 0.1; color: "#00000000" }
    }
    property Gradient buttonActiveGradient: Gradient {
      GradientStop { position: 0.0; color: "#99000000" }
      GradientStop { position: 0.3; color: "#55000000" }
      GradientStop { position: 1.0; color: "#55000000" }
    }
  }

  Item {
    id: black

    property string barBgColor: "#cc000000" 
    property string buttonBorderColor: "#BBBBBB"
    property string buttonBackgroundColor: "#222222"
    property bool buttonBorderShadow: true
    property bool onTop: true
    property string iconColor: "blue"
    property string iconPressedColor: "dark_blue"
    property Gradient barGradient: Gradient {
      GradientStop { position: 0.0; color: "#55FFFFFF" }
      GradientStop { position: 0.4; color: "#00FFFFFF" }
      GradientStop { position: 0.8; color: "#00FFFFFF" }
      GradientStop { position: 1.0; color: "#AA000000" }
    }
    property Gradient buttonInactiveGradientV: Gradient {
      GradientStop { position: 0.0; color: "#33FFFFFF" }
      GradientStop { position: 0.3; color: "#55000000" }
    }
    property Gradient buttonInactiveGradientH: Gradient {
      orientation: Gradient.Horizontal
      GradientStop { position: 0.0; color: "#55FFFFFF" }
      GradientStop { position: 0.1; color: "#00000000" }
    }
    property Gradient buttonActiveGradient: Gradient {
      GradientStop { position: 0.92; color: "#FF000000" }
      GradientStop { position: 0.93; color: "#FFFFFFFF" }
      GradientStop { position: 1.0; color: "#FFFFFFFF" }
    }
  }

  Item {
    id: black_flat

    property string barBgColor: "#cc000000" 
    property string buttonBorderColor: "#BBBBBB"
    property string buttonBackgroundColor: "#222222"
    property bool buttonBorderShadow: false
    property bool onTop: true
    property string iconColor: ""
    property string iconPressedColor: ""
    property Gradient barGradient: Gradient {
      GradientStop { position: 0.0; color: "transparent" }
    }
    property Gradient buttonInactiveGradientV: Gradient {
      GradientStop { position: 0.0; color: "transparent" }
    }
    property Gradient buttonInactiveGradientH: Gradient {
      orientation: Gradient.Horizontal
      GradientStop { position: 0.0; color: "transparent" }
    }
    property Gradient buttonActiveGradient: black.buttonActiveGradient
  }

  Item {
    id: nordic

    // Nord color palette
    property string barBgColor: "#2E3440"  // Nord0 - Polar Night
    property string buttonBorderColor: "#4C566A"  // Nord3 - Polar Night
    property string buttonBackgroundColor: "#3D4550"
    property bool buttonBorderShadow: true
    property bool onTop: true
    property string iconColor: "#88C0D0"  // Nord7 - Frost
    property string iconPressedColor: "#81A1C1"  // Nord9 - Frost
    property Gradient barGradient: Gradient {
      GradientStop { position: 0.0; color: "#3B4252" }  // Nord1 - Polar Night
      GradientStop { position: 0.4; color: "#2E3440" }  // Nord0 - Polar Night
      GradientStop { position: 0.8; color: "#2E3440" }  // Nord0 - Polar Night
      GradientStop { position: 1.0; color: "#3B4252" }  // Nord1 - Polar Night
    }
    property Gradient buttonInactiveGradientV: Gradient {
      GradientStop { position: 0.0; color: "#434C5E" }  // Nord2 - Polar Night
      GradientStop { position: 0.3; color: "#2E3440" }  // Nord0 - Polar Night
    }
    property Gradient buttonInactiveGradientH: Gradient {
      orientation: Gradient.Horizontal
      GradientStop { position: 0.0; color: "#434C5E" }  // Nord2 - Polar Night
      GradientStop { position: 0.1; color: "#2E3440" }  // Nord0 - Polar Night
    }
    property Gradient buttonActiveGradient: Gradient {
      GradientStop { position: 0.92; color: "#5E81AC" }  // Nord10 - Frost
      GradientStop { position: 0.93; color: "#88C0D0" }  // Nord7 - Frost
      GradientStop { position: 1.0; color: "#88C0D0" }  // Nord7 - Frost
    }
  }

  Item {
    id: cyberpunk

    // Tokyo Neon color palette
    property string barBgColor: "#1A0B2E"  // Deep purple-black
    property string buttonBorderColor: "#FF2A6D"  // Neon pink
    property string buttonBackgroundColor: "#1A1A2E"  // Dark blue-black
    property bool buttonBorderShadow: true
    property bool onTop: true
    property string iconColor: "#05D9E8"  // Electric blue
    property string iconPressedColor: "#FF2A6D"  // Neon pink
    property Gradient barGradient: Gradient {
      GradientStop { position: 0.0; color: "#FF2A6D" }  // Neon pink
      GradientStop { position: 0.4; color: "#1A0B2E" }  // Deep purple-black
      GradientStop { position: 0.8; color: "#1A0B2E" }  // Deep purple-black
      GradientStop { position: 1.0; color: "#1A0B2E" }  // Electric blue
    }
    property Gradient buttonInactiveGradientV: Gradient {
      GradientStop { position: 0.0; color: "#05D9E8" }  // Electric blue
      GradientStop { position: 0.3; color: "#1A0B2E" }  // Deep purple-black
    }
    property Gradient buttonInactiveGradientH: Gradient {
      orientation: Gradient.Horizontal
      GradientStop { position: 0.0; color: "#05D9E8" }  // Electric blue
      GradientStop { position: 0.1; color: "#1A0B2E" }  // Deep purple-black
    }
    property Gradient buttonActiveGradient: Gradient {
      GradientStop { position: 0.92; color: "#FF2A6D" }  // Neon pink
      GradientStop { position: 0.93; color: "#D1F7FF" }  // Bright cyan
      GradientStop { position: 1.0; color: "#D1F7FF" }  // Bright cyan
    }
  }

  Item {
    id: material

    // Material Design 3 color palette
    property string barBgColor: "#1F1F1F"  // Surface dark
    property string buttonBorderColor: "#2D2D2D"  // Surface variant
    property string buttonBackgroundColor: "#2D2D2D"  // Surface variant
    property bool buttonBorderShadow: true
    property bool onTop: true
    property string iconColor: "#90CAF9"  // Primary light
    property string iconPressedColor: "#64B5F6"  // Primary medium
    property Gradient barGradient: Gradient {
      GradientStop { position: 0.0; color: "#2D2D2D" }  // Surface variant
      GradientStop { position: 0.4; color: "#1F1F1F" }  // Surface dark
      GradientStop { position: 0.8; color: "#1F1F1F" }  // Surface dark
      GradientStop { position: 1.0; color: "#121212" }  // Background
    }
    property Gradient buttonInactiveGradientV: Gradient {
      GradientStop { position: 0.0; color: "#424242" }  // Surface light
      GradientStop { position: 0.3; color: "#2D2D2D" }  // Surface variant
    }
    property Gradient buttonInactiveGradientH: Gradient {
      orientation: Gradient.Horizontal
      GradientStop { position: 0.0; color: "#424242" }  // Surface light
      GradientStop { position: 0.1; color: "#2D2D2D" }  // Surface variant
    }
    property Gradient buttonActiveGradient: Gradient {
      GradientStop { position: 0.92; color: "#90CAF9" }  // Primary light
      GradientStop { position: 0.93; color: "#E3F2FD" }  // Primary lightest
      GradientStop { position: 1.0; color: "#E3F2FD" }  // Primary lightest
    }
  }

  Item {
    id: catppuccin

    // Catppuccin Mocha color palette
    property string barBgColor: "#1E1E2E"  // Base
    property string buttonBorderColor: "#313244"  // Surface0
    property string buttonBackgroundColor: "#313244"  // Surface0
    property bool buttonBorderShadow: true
    property bool onTop: true
    property string iconColor: "#89B4FA"  // Blue
    property string iconPressedColor: "#74C7EC"  // Sapphire
    property Gradient barGradient: Gradient {
      GradientStop { position: 0.0; color: "#313244" }  // Surface0
      GradientStop { position: 0.4; color: "#1E1E2E" }  // Base
      GradientStop { position: 0.8; color: "#1E1E2E" }  // Base
      GradientStop { position: 1.0; color: "#181825" }  // Crust
    }
    property Gradient buttonInactiveGradientV: Gradient {
      GradientStop { position: 0.0; color: "#45475A" }  // Surface1
      GradientStop { position: 0.3; color: "#313244" }  // Surface0
    }
    property Gradient buttonInactiveGradientH: Gradient {
      orientation: Gradient.Horizontal
      GradientStop { position: 0.0; color: "#45475A" }  // Surface1
      GradientStop { position: 0.1; color: "#313244" }  // Surface0
    }
    property Gradient buttonActiveGradient: Gradient {
      GradientStop { position: 0.92; color: "#89B4FA" }  // Blue
      GradientStop { position: 0.93; color: "#CDD6F4" }  // Text
      GradientStop { position: 1.0; color: "#CDD6F4" }  // Text
    }
  }

}

