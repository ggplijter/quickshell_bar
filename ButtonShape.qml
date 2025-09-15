import QtQuick
import QtQuick.Shapes

Shape {
    id: btnShape
    property string svg_id
    containsMode: Shape.FillContains
    opacity: .8

    Behavior on scale {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutQuad
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        property double mouseX
        property double mouseY

        onPressed: {
            parent.scale = 1.1;
        }
        onReleased: mouse => {
            parent.scale = 1;

            let p = btnShape.mapFromItem(mouseArea, mouse.x, mouse.y);
            if (btnShape.contains(p)) {
                on_clicked_action();
            }
        }

        onPositionChanged: mouse => {
            let p = btnShape.mapFromItem(mouseArea, mouse.x, mouse.y);
            if (btnShape.contains(p)) {
                parent.opacity = 1.0;
            } else {
                parent.opacity = 0.8;
            }
        }
        onExited: {
            btnShape.opacity = 0.8;
        }
    }
}
