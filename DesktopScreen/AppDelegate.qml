import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.0

Component {
    id: appDelegate
    Rectangle {
        id: appDelegateRect
        width: 90
        height: 90
        color: "transparent"      
        x:0
        Column {
            width: parent.width
            height: parent.height
            spacing: 6

            Rectangle{
                id: overlay
                width: 84
                height: 84
                radius: width * 0.5
                border.width: 2
                border.color: borderColor
                color: "transparent"

                Rectangle{
                    id: _gradient
                    width: parent.width
                    height: parent.height
                    radius: parent.radius
                    color: "transparent"
                    opacity: 0.45

                    RadialGradient {
                        anchors.fill: parent
                        horizontalRadius: 84
                        verticalRadius: 84
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
                    scale: 0.7
                }
            }

            Text {
                id: appName
                text: name
                width: parent.width + 6
                elide: Text.ElideRight

                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 12
                font.family: "Helvetica"
                color: "white"
            }
        }

      MessageDialog {
                id: msg
                title: "Title"
                text: "index:" + appDelegate.GridView.view.currentIndex
                onAccepted: visible = false
      }

      MouseArea{
            anchors.fill: parent
            //propagateComposedEvents: true
            enabled: true

            onClicked: {
                root.t1 = new Date().valueOf()
                console.log("t1: "+ root.t1)
                appDelegate.GridView.view.currentIndex = index
                console.log("t1-t2: "+ (root.t1 - root.t2))
                if ((t1-t2) > 500)
                    AppsModel.query_runapp(app_id)
                root.t2 = new Date().valueOf()
                console.log("t2: "+ root.t2)

            }

        }

    }
}
