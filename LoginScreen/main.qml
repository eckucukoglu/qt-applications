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
            anchors.topMargin:20
            anchors.fill: parent
            CheckBox {
                    checked: false
                    style: CheckBoxStyle {
                          label: Text{
                               color: "white"
                               text:  "shamir"
                               font.family: "Helvetica"
                               scale: 1.4
                               x: 15
                          }

                           indicator: Rectangle {
                                   implicitWidth: 26
                                   implicitHeight: 26
                                   radius: 6
                                   border.color: control.activeFocus ? "darkblue" : "gray"
                                   border.width: 2

                                   Rectangle {
                                       visible: control.checked
                                       color: "green"
                                       border.color: "#333"
                                       radius: 1
                                       anchors.margins: 4
                                       anchors.fill: parent
                                   }
                           }
                     }
                    onClicked: {
                        numbersContent.isShamir = checked
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
