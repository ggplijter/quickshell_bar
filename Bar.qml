import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import Quickshell.Services.Pipewire

PanelWindow {
    implicitHeight: 100
    implicitWidth: 850
    anchors {
        top: true
        right: true
    }

    Row {
        // anchors.fill: parent
        spacing: 25

        Button {
            id: btn1

            background: Rectangle {
                anchors.fill: parent
                radius: 20
                color: btn1.pressed ? "#007ACC" : '#ffbe33'  // pressed vs normal
                border.color: "#004C80"
            }

            height: 100
            width: 100
            text: "Button 1"
        }

        Rectangle {
            color: '#d34b31c0'
            width: 120
            height: 120
            radius: 40

            anchors.verticalCenter: btn1.verticalCenter

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
            width: 120
            height: width
            anchors.verticalCenter: btn1.verticalCenter

            AbortAppGenerated {
                anchors.fill: parent

                function on_clicked_action() {
                    bar.visible = false;
                }
            }
        }
    }
}
