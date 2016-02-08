import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.0

Component {
    id: appDelegate
    Rectangle {
        id: appDelegateRect
        width: 90//84 + 6
        height: 90 //84 + 6px for text area
        color: "transparent"      
        x:0
        Column {
            width: parent.width
            height: parent.height
            spacing: 6 //vertical space btw icon and text

            Rectangle{
                id: overlay
                width: 84
                height: 84//111
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
                        horizontalRadius: 84//130
                        verticalRadius: 84//130
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
                width: parent.width + 6// 16
                elide: Text.ElideRight

                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 12//14
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
             propagateComposedEvents: true

            onPressed: {
                mouse.accepted = false
            }

            onClicked: {
                appDelegate.GridView.view.currentIndex = index
               // msg.visible = true  //opens an alert box
                console.log(app_id + " page:" + AppsModel.get_page_index()) //appDelegate.GridView.view.currentIndex
                AppsModel.query_runapp(app_id)
            }
        }

    }
}
