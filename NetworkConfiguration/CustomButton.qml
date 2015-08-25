import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4

Item{
    property alias text: button.text
    signal clicked()
    width: 96
    height: 44
    Button{
        id: button
        style: customButtonStyle

        onClicked: parent.clicked()
    }

    Component{
        id: customButtonStyle
        ButtonStyle{
            background: Rectangle {
                implicitWidth: 96
                implicitHeight: 44
                border.width: control.activeFocus ? 2 : 1
                border.color: "#0b988b"
                color: control.pressed ? "#666569" : "#444347"

                Rectangle{
                    anchors.fill: parent
                    color:"#0b988b"
                    opacity: 0.1
                }
            }

            label:Text{
                text: control.text
                font.family: "Helvetica"
                font.pixelSize: 20
                color: "#d5d1d1"

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

    }

}


