import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.2


ApplicationWindow {
    title: qsTr("LoginScreen")
    width: 800
    height: 480
    visible: true
    id: root
    property bool _isActive: true
    property date date

    Rectangle{
        anchors.top: parent.top
        width: parent.width
        height: 18
        color: "black"
        opacity: 0.3
        z:1
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
        anchors.fill: parent
        property int counter: 0
        property var password: ""
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
                               text:  "shamir"
                               font.family: "Helvetica"
                               scale: 1.4
                               x: 15
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
