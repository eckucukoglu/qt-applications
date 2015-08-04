import QtQuick 2.0
import QtGraphicalEffects 1.0

Component {
    id: appDelegate
    Rectangle {
        id: appDelegateRect
        width: 111
        height: 134
        color: "transparent"

        Column {
            width: parent.width
            height: parent.height
            spacing: 8

            Rectangle{
                id: overlay
                width: parent.width
                height: 111
                radius: width * 0.5
                border.width: 2
                border.color: borderColor
                color: "transparent"

                Rectangle{
                    width: parent.width
                    height: parent.height
                    radius: parent.radius
                    color: "transparent"
                    opacity: 0.50

                    RadialGradient {
                        anchors.fill: parent
                        //OpacityMask
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: borderColor }
                            GradientStop { position: 0.5; color: "transparent" }
                        }
                    }
                }

                Image {
                    id: appIcon
                    source: portrait
                    anchors.centerIn: parent
                    anchors.horizontalCenter: parent.horizontalCenter
                }

            }

            Text {
                id: appName
                text: name
                width: parent.width + 16
                elide: Text.ElideRight

                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 15
                color: "white"
            }
        }

        MouseArea{
            anchors.fill: parent
            propagateComposedEvents: true

            onPressed: {
                mouse.accepted = false
            }

            onClicked: {
                if(containsMouse){
                    console.log("clicked")
                    console.log(appDelegate.GridView.view.currentIndex)
                }

                mouse.accepted = false
            }

        }

    }
}
