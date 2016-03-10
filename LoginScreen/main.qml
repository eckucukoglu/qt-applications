import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0


ApplicationWindow {
    title: qsTr("LoginScreen")
    width: 800
    height: 480
    visible: true
    id: root
    property bool _isActive: true
    property date date
    property int waitTime : 0
    Rectangle{
        anchors.top: parent.top
        width: parent.width
        height: 18
        color: "black"
        opacity: 0.3
        z:1
    }

    Rectangle{
          id: errorMsg
          visible: false
          anchors.centerIn:parent
          width: 360
          height: 180
          border.width: 4
          border.color: "steelblue"
          radius: width * 0.5
          z:1

          Rectangle{
              anchors.fill: parent
              color:"steelblue"
              radius: parent.radius
              opacity: 0.2
          }

          Image{
              anchors.top: parent.top
              anchors.left: parent.left
              source: "pics/sober_newspecs/icon/error.png"
              scale: 0.4

          }
          Text{
              id: textcontent
              x: parent.width/4 + 30
              y: parent.height/4 - 20
              text: "Incorrect Password!"
              font.family: "Helvetica"
              color: "black"
              font.pixelSize: 22
          }
          Text{
              id: textcontent2
              x: parent.width/4 + 30
              y: parent.height/4 + 20
              text: "Remaining: " + numbersContent.trialRemaining
              font.family: "Helvetica"
              color: "black"
              font.pixelSize: 20
          }
          Button{
              id: btnOk
              anchors.horizontalCenter: parent.horizontalCenter
              anchors.top: parent.top
              anchors.topMargin: 120
              text: "okay"
              style: ButtonStyle {
                      label: Text {
                              renderType: Text.NativeRendering
                              verticalAlignment: Text.AlignVCenter
                              horizontalAlignment: Text.AlignHCenter
                              font.family: "Helvetica"
                              font.pointSize: 14
                              font.bold: true
                              color: "black"
                              text: control.text
                            }
                  }
              onClicked: {
                 errorMsg.visible=false
                 chckBoxArea.enabled=true
                 numbersContent.enabled=true
              }
          }

    }


    Rectangle{
        id: deviceLockArea
        visible: false
        anchors.centerIn:parent
        width: 320
        height: 140
        Image {
            id: background3
            anchors.fill: parent
            source: "pics/sober_newspecs/bg.png"
            fillMode: Image.PreserveAspectCrop
            opacity: 0.7
        }
        border.width: 4
        border.color: "darkred"
        radius: 7
        z:1
        Image{
            anchors.top: parent.top
            anchors.left: parent.left
            source: "pics/sober_newspecs/icon/error.png"
            scale: 0.4

        }
        Text{
            x: parent.width/4 + 30
            y: parent.height/4
            text: "Device is Locked!"
            font.family: "Helvetica"
            color: "black"
            font.pixelSize: 22
        }
        Text{
            id: txtWaitTime
            x: parent.width/4 + 30
            y: parent.height/4 + 30
            text: "wait "+ waitTime +" seconds.."
            font.family: "Helvetica"
            color: "black"
            font.pixelSize: 20
        }
        Timer {
                interval: 1000;
                running: true;
                repeat: true
                onTriggered: {
                    waitTime = waitTime-1
                    if(waitTime === 0)
                    {
                           deviceLockArea.visible=false
                           numbersContent.enabled=true
                           chckBoxArea.enabled=true
                    }
                }
            }
    }
    Image {
        id: background
        anchors.fill: parent
        source: "pics/sober_newspecs/bg.png"
        fillMode: Image.PreserveAspectCrop
    }

    InfoTextArea{
        id: infoTextArea
        anchors.fill: parent
        anchors.topMargin: 30
        anchors.bottomMargin: 400
        anchors.leftMargin: 280
        anchors.rightMargin: 280
    }


    Text{
        id: hourAndDate
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 20
        text: date.toLocaleTimeString(Qt.locale("en_EN"), "hh:mm:ss") + "  |  " +
              date.toLocaleDateString(Qt.locale("en_EN"), "dd MMM yyyy")
        font.pixelSize: 12
        color: "white"
    }

    Timer{
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            date = new Date();
            hourAndDate.text = date.toLocaleTimeString(Qt.locale("tr_TR"), "hh:mm:ss") + "  |  " +
                      date.toLocaleDateString(Qt.locale("tr_TR"), "dd MMM yyyy")
        }
    }

    Item{
        id: numbersContent
        anchors.topMargin: 100
        anchors.leftMargin: 250
        anchors.rightMargin: 250
        enabled: true
        anchors.fill: parent
        property int counter: 0
        property int trialRemaining: 3
        property var password: ""
        property int ftime: 0
        property int stime: 1 //5
        property bool isShamir: false
        Rectangle {
              width: 300
              height:320

            //  border.width: 2
              color: "transparent"
              GridView{
                 anchors.leftMargin: 40
                 anchors.fill: parent
                 cellHeight: 80
                 cellWidth: 80
                 interactive: false
                 focus: true
                 clip:true
                 boundsBehavior: Flickable.StopAtBounds
                 model: NumbersModel{
                     id: numbersModel
                 }
                delegate: ButtonDelegate{

                 }
              }
        }
    }

    Rectangle{
        id: chckBoxArea
        width: 300
        height:60
      //  border.width: 2
        anchors.leftMargin: 250
        anchors.rightMargin: 250
        anchors.bottomMargin: 20
        anchors.topMargin:400
        anchors.fill: parent
        color: "transparent"
        Row{
            anchors.leftMargin: 100
            anchors.topMargin:30
            anchors.fill: parent
            CheckBox {
                    id: checkbox
                    checked: false
                    scale: 1.4
                    style: CheckBoxStyle {
                          label: Text{
                               color: "white"
                               text:  "unlock with hash"
                               font.family: "Helvetica"
                               scale: 1

                          }

                     }
                    onClicked: {
                        numbersContent.isShamir = checked
                        console.log(checked)
                    }
                }


        }
    }

    MessageDialog {
        id: messageDialog
        title: qsTr("")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }

}
