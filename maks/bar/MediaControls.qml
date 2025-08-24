import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire

Item {
    id: mediaControls
    property var currentPlayer: null
    property var sink: Pipewire.defaultAudioSink
    
    // Better player detection and selection
    function updateCurrentPlayer() {
        const players = Mpris.players.values
        console.log("Available players:", players.length)
        
        if (players.length === 0) {
            currentPlayer = null
            return
        }
        
        // Prefer playing players, then paused, then any
        let playingPlayer = null
        let pausedPlayer = null
        let anyPlayer = null
        
        for (let i = 0; i < players.length; i++) {
            const player = players[i]
            console.log("Player", i, ":", player.identity, "status:", player.playbackStatus)
            
            anyPlayer = player
            if (player.playbackStatus === "Playing") {
                playingPlayer = player
                break
            } else if (player.playbackStatus === "Paused") {
                pausedPlayer = player
            }
        }
        
        currentPlayer = playingPlayer || pausedPlayer || anyPlayer
        if (currentPlayer) {
            console.log("Selected player:", currentPlayer.identity)
        }
    }
    
    // Watch for player changes
    Connections {
        target: Mpris.players
        function onValuesChanged() {
            mediaControls.updateCurrentPlayer()
        }
    }
    
    Component.onCompleted: {
        mediaControls.updateCurrentPlayer()
    }
    
    PwObjectTracker { 
        objects: [Pipewire.defaultAudioSink]
        onObjectsChanged: {
            mediaControls.sink = Pipewire.defaultAudioSink
        }
    }
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 12
        
        // Main media player layout - matching the reference image
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 280
            color: "#2E3440"
            radius: 12
            border.color: "#4C566A"
            border.width: 1
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20
                
                // Left side: Circular album art with progress ring
                Item {
                    Layout.preferredWidth: 180
                    Layout.preferredHeight: 180
                    Layout.alignment: Qt.AlignVCenter
                    
                    // Outer progress ring
                    Rectangle {
                        anchors.centerIn: parent
                        width: 180
                        height: 180
                        radius: 90
                        color: "transparent"
                        border.color: "#4C566A"
                        border.width: 2
                    }
                    
                    // Progress ring (animated segments like in the image)
                    Canvas {
                        id: progressRing
                        anchors.centerIn: parent
                        width: 180
                        height: 180
                        
                        property real progress: {
                            if (!mediaControls.currentPlayer) return 0
                            const pos = mediaControls.currentPlayer.position || 0
                            const len = mediaControls.currentPlayer.length || 1
                            return Math.max(0, Math.min(1, pos / len))
                        }
                        
                        onProgressChanged: requestPaint()
                        
                        onPaint: {
                            var ctx = getContext("2d")
                            ctx.clearRect(0, 0, width, height)
                            
                            // Draw segmented progress ring like in the reference image
                            const segments = 60
                            const segmentAngle = 2 * Math.PI / segments
                            const filledSegments = Math.floor(progress * segments)
                            
                            for (let i = 0; i < segments; i++) {
                                const angle = -Math.PI/2 + i * segmentAngle
                                const startAngle = angle - segmentAngle/4
                                const endAngle = angle + segmentAngle/4
                                
                                ctx.beginPath()
                                ctx.arc(width/2, height/2, 85, startAngle, endAngle)
                                ctx.strokeStyle = i < filledSegments ? "#BF616A" : "#4C566A"
                                ctx.lineWidth = 4
                                ctx.stroke()
                            }
                        }
                    }
                    
                    // Album art (circular)
                    Rectangle {
                        anchors.centerIn: parent
                        width: 140
                        height: 140
                        radius: 70
                        color: "#3B4252"
                        border.color: "#5E81AC"
                        border.width: 2
                        clip: true
                        
                        Image {
                            anchors.fill: parent
                            source: {
                                const artUrl = mediaControls.currentPlayer?.metadata.artUrl || ""
                                return artUrl
                            }
                            fillMode: Image.PreserveAspectCrop
                            visible: source != ""
                        }
                        
                        // Placeholder when no art
                        Text {
                            anchors.centerIn: parent
                            text: "♫"
                            color: "#5E81AC"
                            font.pixelSize: 40
                            visible: parent.children[0].source == ""
                        }
                    }
                }
                
                // Right side: Track info and controls
                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 8
                    
                    // Track information
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 4
                        
                        Text {
                            Layout.fillWidth: true
                            text: {
                                if (!mediaControls.currentPlayer) return "No media playing"
                                const title = mediaControls.currentPlayer.metadata.title
                                return title || "Unknown Track"
                            }
                            color: "#ECEFF4"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                            elide: Text.ElideRight
                            maximumLineCount: 2
                            wrapMode: Text.Wrap
                        }
                        
                        Text {
                            Layout.fillWidth: true
                            text: {
                                if (!mediaControls.currentPlayer) return "No artist"
                                const artist = mediaControls.currentPlayer.metadata.artist
                                return artist || "Unknown Artist"
                            }
                            color: "#D8DEE9"
                            font.pixelSize: 14
                            elide: Text.ElideRight
                        }
                        
                        Text {
                            Layout.fillWidth: true
                            text: {
                                if (!mediaControls.currentPlayer) return ""
                                const album = mediaControls.currentPlayer.metadata.album
                                return album || ""
                            }
                            color: "#88C0D0"
                            font.pixelSize: 12
                            elide: Text.ElideRight
                            visible: text !== ""
                        }
                    }
                    
                    // Media controls - minimal design
                    RowLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 25
                        
                        // Previous button - minimal
                        Text {
                            text: "◀"
                            color: mediaControls.currentPlayer?.canGoPrevious ? "#ECEFF4" : "#5E81AC"
                            font.pixelSize: 18
                            
                            MouseArea {
                                anchors.fill: parent
                                anchors.margins: -8
                                enabled: mediaControls.currentPlayer?.canGoPrevious || false
                                onClicked: {
                                    console.log("Previous clicked")
                                    if (mediaControls.currentPlayer) {
                                        mediaControls.currentPlayer.previous()
                                    }
                                }
                            }
                        }
                        
                        // Play/Pause button - fixed with correct properties
                        Rectangle {
                            Layout.preferredWidth: 50
                            Layout.preferredHeight: 50
                            color: "#BF616A"
                            radius: 25
                            
                            Text {
                                anchors.centerIn: parent
                                anchors.horizontalCenterOffset: text === "▶" ? 1 : 0  // Slightly offset play icon for visual centering
                                text: {
                                    if (!mediaControls.currentPlayer) return "▶"
                                    // Use isPlaying boolean property with minimal pause icon
                                    const isPlaying = mediaControls.currentPlayer.isPlaying
                                    console.log("isPlaying:", isPlaying)
                                    return isPlaying ?  "▶" : "||"
                                }
                                color: "#ECEFF4"
                                font.pixelSize: 20
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    console.log("Play/Pause clicked")
                                    if (mediaControls.currentPlayer) {
                                        const isPlaying = mediaControls.currentPlayer.isPlaying
                                        console.log("Current isPlaying:", isPlaying)
                                        
                                        if (isPlaying) {
                                            console.log("Calling pause()")
                                            mediaControls.currentPlayer.pause()
                                        } else {
                                            console.log("Calling play()")
                                            mediaControls.currentPlayer.play()
                                        }
                                    }
                                }
                            }
                        }
                        
                        // Next button - minimal
                        Text {
                            text: "▶"
                            color: mediaControls.currentPlayer?.canGoNext ? "#ECEFF4" : "#5E81AC"
                            font.pixelSize: 18
                            
                            MouseArea {
                                anchors.fill: parent
                                anchors.margins: -8
                                enabled: mediaControls.currentPlayer?.canGoNext || false
                                onClicked: {
                                    console.log("Next clicked")
                                    if (mediaControls.currentPlayer) {
                                        mediaControls.currentPlayer.next()
                                    }
                                }
                            }
                        }
                    }
                    
                    // Volume control - clean without icon
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 8
                        
                        Slider {
                            id: volumeSlider
                            Layout.fillWidth: true
                            from: 0
                            to: 1
                            value: mediaControls.sink?.audio?.volume || 0
                            
                            onValueChanged: {
                                if (mediaControls.sink?.audio) {
                                    mediaControls.sink.audio.volume = value
                                }
                            }
                        }
                        
                        Text {
                            text: Math.round((mediaControls.sink?.audio?.volume || 0) * 100) + "%"
                            color: "#D8DEE9"
                            font.pixelSize: 10
                            font.weight: Font.Medium
                        }
                    }
                }
            }
        }
    }
}
