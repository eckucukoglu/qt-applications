import QtQuick 2.5
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
                    opacity: 0.45

                    RadialGradient {
                        anchors.fill: parent
                        horizontalRadius: 130
                        verticalRadius: 130
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
                font.pixelSize: 14
                font.family: "Helvetica"
                color: "white"
            }
        }

        MouseArea{
            anchors.fill: parent
             propagateComposedEvents: true

            onPressed: {
                console.log("mouse area on pressed")
                mouse.accepted = false
            }

            onClicked: {
                console.log("mouse area on clicked")
                appDelegate.GridView.view.currentIndex = index
                if(containsMouse){
                    console.log("clicked")
                    console.log(appDelegate.GridView.view.currentIndex)

                    //  DO ANY CLICK ACTION HERE
                }

            }


        }

    }
}
