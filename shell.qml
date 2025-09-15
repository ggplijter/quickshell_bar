import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import Quickshell.Services.Pipewire

import "."

// import QtQuick.Controls 2.15
ShellRoot {
    id: root

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    property bool shouldShowOsd: false
    property double volume: Pipewire.defaultAudioSink.audio.volume

    onVolumeChanged: {
        console.log("Volume changed to " + volume);
    }

    Process {
        id: proc_wofi
        running: false
        command: ["wofi", "--show", "drun"]
    }

    Process {
        id: play_volume_change_sound
        running: false
        command: ["ffplay", "-nodisp", "-autoexit", "/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"]
    }

    PanelWindow {
        id: window
        // FloatingWindow {

        anchors {
            top: true
            right: true
        }

        color: "transparent"

        implicitHeight: 20
        implicitWidth: 20

        MouseArea {
            anchors.fill: parent
            onClicked: bar.visible = true
        }

        Bar {
            id: bar
            visible: false
        }
    }
}
