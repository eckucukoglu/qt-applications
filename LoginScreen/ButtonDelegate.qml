import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.0

Component {
    id: buttonDelegate
    Rectangle {
        id: buttonDelegateRect
        width: 60//84 + 6
        height: 60 //84 + 6px for text area
        color: "transparent"
    //  border.width: 1
        x:0
        Column {
            width: parent.width
            height: parent.height

            Rectangle{
                id: overlay
                width: parent.width
                height: parent.height
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
                    opacity: 0.3

                    RadialGradient {
                        anchors.fill: parent
                        horizontalRadius: 60//130
                        verticalRadius: 60//130
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: borderColor }
                            GradientStop { position: 0.5; color: "transparent" }
                        }
                    }
                }

                Text {
                    id: buttonName
                    text: name
                    width: parent.width + 6// 16
                    elide: Text.ElideRight
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter:  parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: textsize//14
                    font.family: "Helvetica"
                    color: "white"
                }
            }


        }

      MessageDialog {
                id: msg
                title: "Title"
                text: "index:" + buttonDelegate.GridView.view.currentIndex
                onAccepted: visible = false
      }

      MouseArea{
            anchors.fill: parent
             propagateComposedEvents: true

            onPressed: {
                mouse.accepted = true
                _gradient.opacity = 1
            }
            onPressAndHold: {
                _gradient.opacity = 1
            }

            onReleased: {
                 _gradient.opacity = 0.3
            }

            onClicked: {
               buttonDelegate.GridView.view.currentIndex = index
               // msg.visible = true  //opens an alert box
                console.log("counter: "+numbersContent.counter)
                if(index == 9)
                {
                    infoTextArea.textvalue  = qsTr("Sifrenizi Giriniz..")
                    numbersContent.counter = 0
                    numbersContent.password = qsTr("")
                }
                else if(index == 11)
                {
                    messageDialog.show(qsTr("Sifre: ") + numbersContent.password + qsTr("\nShamir:") + numbersContent.isShamir)
                    loginHelper.set_password(qsTr(numbersContent.password), numbersContent.isShamir)
                    console.log("pwd: " + qsTr(loginHelper.test_method()))
                }
                else
                {
                    if(numbersContent.counter == 0)
                    {
                        infoTextArea.textvalue = qsTr("")
                    }
                    if(numbersContent.counter < 10)
                    {
                        infoTextArea.textvalue = qsTr(infoTextArea.textvalue) + qsTr("*")
                        numbersContent.counter++
                        numbersContent.password = numbersContent.password + qsTr(name)
                    }
                    else
                    {
                        // messageDialog.show(qsTr("Uyarı: Sifre maksimum 10 haneli olmalidir."))
                    }
                }
            }
        }

    }



}

