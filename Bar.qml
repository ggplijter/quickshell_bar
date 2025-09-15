import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import Quickshell.Services.Pipewire

PanelWindow {
    implicitHeight: 100
    implicitWidth: 650
    anchors {
        top: true
        right: true
    }

    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 40
        color: '#8d969c'

        Row {
            anchors.left: parent.left
            anchors.leftMargin: 20

            spacing: 25

            Rectangle {
                color: '#d34b31c0'
                width: 80
                height: 80
                radius: 15

                anchors.verticalCenter: parent.verticalCenter

                Text {
                    anchors.centerIn: parent
                    text: "Apps"
                    color: '#d3021516'
                    font.pixelSize: 30
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: proc_wofi.running = true
                }
            }

            VolumeBar {

                anchors.top: parent.top
            }
            Item {
                width: 80
                height: width
                anchors.verticalCenter: parent.verticalCenter

                AbortAppGenerated {
                    anchors.fill: parent

                    function on_clicked_action() {
                        bar.visible = false;
                    }
                }
            }
        }
    }
}
