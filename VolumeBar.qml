import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Rectangle {
    id: volumeBar
    implicitWidth: 400
    implicitHeight: 100
    radius: height / 2
    color: '#803b6d74'

    Component.onCompleted: {
        Pipewire.defaultAudioSink.audio.volume = 0.4;
    }

    RowLayout {
        anchors {
            left: parent.left
            right: parent.right
        }

        anchors.verticalCenter: volumeBar.verticalCenter
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        spacing: 10

        implicitHeight: 60

        IconImage {
            id: volumeIcon
            implicitSize: 75
            // source: Quickshell.iconPath("audio-volume-high-symbolic")
            // source: "image://theme/audio-volume-high-symbolic"
            source: "file:///usr/share/icons/Adwaita/symbolic/status/audio-volume-high-symbolic.svg"

            MouseArea {
                anchors.fill: parent
                property bool muted: false
                onClicked:
                // Pipewire.defaultAudioSink.audio.mute = !Pipewire.defaultAudioSink.audio.mute;
                {
                    muted = !muted;
                    if (muted === true) {
                        volumeIcon.source = "file:///usr/share/icons/Adwaita/symbolic/status/audio-volume-muted-symbolic.svg";
                        volumeLevelBar.visible = false;
                        volumeBarBackground.enabled = false;
                        Pipewire.defaultAudioSink.audio.mute = true;
                    } else {
                        volumeIcon.source = "file:///usr/share/icons/Adwaita/symbolic/status/audio-volume-high-symbolic.svg";
                        volumeLevelBar.visible = true;
                        volumeBarBackground.enabled = true;
                        Pipewire.defaultAudioSink.audio.mute = false;
                    }

                    console.log("Clicked volume icon - ismuted: " + muted);
                }
            }
        }

        Rectangle {
            // Stretches to fill all left-over space
            id: volumeBarBackground
            Layout.fillWidth: true
            implicitHeight: 50
            implicitWidth: x_pos

            radius: 25
            color: "#50ffffff"

            property real x_pos

            MouseArea {
                anchors.fill: parent
                drag.target: null
                hoverEnabled: true
                onPositionChanged: mouse => {
                    if (parent.enabled) {
                        parent.x_pos = Math.max(50, Math.min(mouse.x, volumeBarBackground.width));
                        volumeLevelBar.width = parent.x_pos;
                    }
                }

                onReleased: {
                    var newVolume = parent.x_pos / volumeBarBackground.width;
                    Pipewire.defaultAudioSink.audio.volume = newVolume;

                    play_volume_change_sound.running = true;
                }
            }

            Rectangle {
                id: volumeLevelBar
                anchors {
                    left: parent.left
                }
                anchors.verticalCenter: parent.verticalCenter

                implicitWidth: volumeBarBackground.width * Pipewire.defaultAudioSink.audio.volume
                implicitHeight: volumeBarBackground.height

                radius: parent.radius
            }
        }
    }
}
