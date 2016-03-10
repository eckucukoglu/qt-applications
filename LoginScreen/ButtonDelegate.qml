import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.0

Component {
    id: buttonDelegate
    Rectangle {
        id: buttonDelegateRect
        width: 60
        height: 60
        color: "transparent"
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
                        horizontalRadius: 60
                        verticalRadius: 60
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: borderColor }
                            GradientStop { position: 0.5; color: "transparent" }
                        }
                    }
                }

                Text {
                    id: buttonName
                    text: name
                    width: parent.width + 6
                    elide: Text.ElideRight
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter:  parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: textsize
                    font.family: "Helvetica"
                    color: "white"
                }
            }


        }



      MouseArea{
            anchors.fill: parent
            propagateComposedEvents: true

            onPressed: {
                mouse.accepted = true
                _gradient.opacity = 1
            }
            onReleased: {
                 _gradient.opacity = 0.3
            }

            onClicked: {

               buttonDelegate.GridView.view.currentIndex = index
               // msg.visible = true  //opens an alert box
                console.log("counter: "+numbersContent.counter)
                if(index == 9) //Cancel Button
                {
                    infoTextArea.textvalue  = qsTr("Enter Password")
                    numbersContent.counter = 0
                    numbersContent.password = qsTr("")
                }
                else if(index == 11) //OK Button
                {
                    var result = loginHelper.check_password(qsTr(numbersContent.password), numbersContent.isShamir)
                    if(result){

                        numbersContent.trialRemaining=3
                        loginHelper.set_tryCount(0)
                        numbersContent.ftime = 0
                        numbersContent.stime = 5
                        waitTime=0
                        loginHelper.query_access(0)

                    }
                    else{
                        numbersContent.trialRemaining = 3- (loginHelper.get_tryCount()%3)
                        console.log("remaining: "+numbersContent.trialRemaining)
                        console.log("count: "+loginHelper.get_tryCount())
                        if( loginHelper.get_tryCount()!=0 && (loginHelper.get_tryCount()%3) === 0)
                        {
                               numbersContent.enabled=false
                               chckBoxArea.enabled=false
                               numbersContent.trialRemaining=3
                               numbersContent.ftime = numbersContent.stime
                               numbersContent.stime = numbersContent.stime + numbersContent.ftime
                               waitTime=numbersContent.stime
                               deviceLockArea.visible=true
                        }
                        else{
                              numbersContent.enabled=false
                              chckBoxArea.enabled=false
                              errorMsg.visible=true
                        }
                        loginHelper.set_tryCount(loginHelper.get_tryCount() + 1)
                    }
                    infoTextArea.textvalue  = qsTr("Enter Password")
                    numbersContent.counter = 0
                    numbersContent.password = qsTr("")
                }
                else // DIGIT
                {
                    if(numbersContent.counter == 0)
                    {
                        infoTextArea.textvalue = qsTr("")
                    }
                    if(numbersContent.counter < 10) //pwd must be less than 10 digits
                    {
                        infoTextArea.textvalue = qsTr(infoTextArea.textvalue) + qsTr("*")
                        numbersContent.counter++
                        numbersContent.password = numbersContent.password + qsTr(name)
                    }
                    else // warning
                    {
                        // messageDialog.show(qsTr("Uyarı: Sifre maksimum 10 haneli olmalidir."))
                    }
                }

            }
        }

    }



}

