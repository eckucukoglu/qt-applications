import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.2

ApplicationWindow {
    title: qsTr("Memory Tester")
    width: 800
    height: 480
    visible: true
    property int size: 100

  Text{
      id: titleTxt
      color: "black"
      font.family: "Helvetica"
      text: "Memory Tester"
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      font.pixelSize: 24
      anchors.topMargin: 40
  }

   Rectangle{
       id: infoArea
       border.width: 1
       border.color: "black"
       color: "white"
       width: 300
       height: 40
       anchors.horizontalCenter: parent.horizontalCenter
       anchors.bottom: btn.top
       anchors.bottomMargin: 40
       radius: 4

       Text{
           id: infoTxt
           color: "black"
           font.family: "Helvetica"
           text: ""
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.verticalCenter: parent.verticalCenter
       }
   }

   Button{
       id: btn
       anchors.horizontalCenter: parent.horizontalCenter
       anchors.verticalCenter: parent.verticalCenter
       width: 300
       height: 40
       text: "Allocate " + size + " KB"
       onClicked: {
           var ret = helper.allocate()
           if(ret)
           {
              infoTxt.text = (size*1024) + " bytes allocated"
              size = helper.get_size()
           }
           else
           {
              infoTxt.text = "error"
           }
       }
       style: ButtonStyle {
               background: Rectangle {
                   implicitWidth: 100
                   implicitHeight: 25
                   border.width: control.activeFocus ? 2 : 1
                   border.color: "black"
                   radius: 4
                   gradient: Gradient {
                       GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                       GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                   }
               }
           }
   }

   Button{
       id: freebtn
       anchors.horizontalCenter: parent.horizontalCenter
       anchors.top: btn.bottom
       anchors.topMargin: 40
       width: 300
       height: 40
       text: "Free"
       onClicked: {
           var ret = helper.free_buffer()
           if(ret)
           {
               infoTxt.text = "Memory freed."
           }
           else
           {
               infoTxt.text = ""
           }
      }
       style: ButtonStyle {
               background: Rectangle {
                   implicitWidth: 100
                   implicitHeight: 25
                   border.width: control.activeFocus ? 2 : 1
                   border.color: "black"
                   radius: 4
                   gradient: Gradient {
                       GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                       GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                   }
               }
           }
   }

   Item{
       width: 800
       height:36
       id: navigationBar
       //color: "transparent"
       anchors.bottom: parent.bottom
    //   anchors.top: row.bottom
       Rectangle{
           anchors.fill: parent
           Image {
               id: home_icon
               source: "home_icon.png"
               x: (parent.width/2)-16
               z:1
               anchors.horizontalCenter: parent.horizontalCenter
               scale: 1.2
           }
           Button{
               x: (parent.width/2)-18
               width: 36
               height: 36
               opacity: 0
               z: 1
               anchors.horizontalCenter: parent.horizontalCenter
               onClicked: {
                   Qt.quit()
               }
           }

           Rectangle{
               color: "black"
               opacity: 0.6
               anchors.fill: parent
           }
       }

   }

}
