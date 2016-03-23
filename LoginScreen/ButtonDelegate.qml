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
                    if(initMode === false)
                    {
                        var result = loginHelper.check_password(qsTr(numbersContent.password), numbersContent.isShamir)
                        if(result){
                            numbersContent.trialRemaining=5
                            loginHelper.set_tryCount(0)
                            numbersContent.stime = 10
                            waitTime=10
                            console.log("loading desktop")
                            loginHelper.query_login(0)
                            console.log("loaded desktop")
                        }
                       else{
                            numbersContent.trialRemaining = 5 - (loginHelper.get_tryCount()%5)
                            console.log("remaining: "+numbersContent.trialRemaining)
                            console.log("count: "+loginHelper.get_tryCount())
                            if( loginHelper.get_tryCount()!= 0 && (loginHelper.get_tryCount()%5) === 0)
                            {
                                   numbersContent.enabled=false
                                   chckBoxArea.enabled=false
                                   numbersContent.trialRemaining=5
                                   numbersContent.stime = numbersContent.stime + 10
                                   deviceLockArea.visible=true
                            }
                            else{
                                  numbersContent.enabled=false
                                  chckBoxArea.enabled=false
                                  errorMsg.visible=true
                            }
                            loginHelper.set_tryCount(loginHelper.get_tryCount() + 1)
                        }
                    }
                    else{ //initialize mode              

                        //TODO: additions to security.cpp->SECURITY_RETURN_TYPE enum has to be added here

                        var SECURITY_RETURN_TYPE = {
                            SECURITY_RETURN_OK : 0,
                            ERR_SECURITY_RETURN_NOK : 1,
                            ERR_SECURITY_SHAMIR_NUMB_OF_THRESHOLD_NOT_REACHED : 2,
                            ERR_SECURITY_SHAMIR_SERVER_NOT_REACHABLE : 3,
                            ERR_SECURITY_DISC_ENC_SALT_FILE_NOT_EXIST : 4,
                            ERR_SECURITY_DISC_ENC_SALT_LENGTH_ERROR : 5,
                            ERR_HTTP_REQUEST_ERROR : 6
                        };
                        //move to js

                        var res =loginHelper.initDisc(qsTr(numbersContent.password), numbersContent.isShamir)
                        console.log("return: "+ res)

                        if(res === SECURITY_RETURN_TYPE.SECURITY_RETURN_OK)
                        {
                            //set initmode 0
                            //set shamir 0 ->hide shamir
                            initMode=false
                            console.log("init mode: "+initMode)
                            infoTextArea.textvalue  = qsTr("Enter Password..")
                            numbersContent.counter = 0
                            numbersContent.password = qsTr("")
                            console.log("loading desktop")
                            loginHelper.query_login(0)
                            console.log("loaded desktop")

                        }
                        else if(res === SECURITY_RETURN_TYPE.ERR_SECURITY_RETURN_NOK)
                        {

                        }
                        else if(res === SECURITY_RETURN_TYPE.ERR_SECURITY_SHAMIR_NUMB_OF_THRESHOLD_NOT_REACHED)
                        {

                        }
                        else if(res === SECURITY_RETURN_TYPE.ERR_SECURITY_SHAMIR_SERVER_NOT_REACHABLE)
                        {

                        }
                        else if(res === SECURITY_RETURN_TYPE.ERR_SECURITY_DISC_ENC_SALT_FILE_NOT_EXIST)
                        {

                        }
                        else if(res === SECURITY_RETURN_TYPE.ERR_SECURITY_DISC_ENC_SALT_LENGTH_ERROR)
                        {

                        }
                        else if(res === SECURITY_RETURN_TYPE.ERR_HTTP_REQUEST_ERROR)
                        {

                        }
                        else
                        {
                            messageDialog.text = "initialize failed!"
                        }
                    }
                    infoTextArea.textvalue  = qsTr("Enter Password")
                    numbersContent.counter = 0
                    numbersContent.password = qsTr("")
                }
                else //DIGIT
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

