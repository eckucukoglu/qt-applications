import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.4

Rectangle{
  width: 500
  height: 250
  visible: false
  enabled: true
  radius: 10
  property string app_name_str
  property string border_color
  property string dev_name
  property string icon_path
  property string color
  property int app_id
  property bool is_installed:true

  Rectangle
  {
       anchors.fill: parent
       border.width: 2
       border.color: "lightsteelblue"
       id: installWin
       radius: parent.radius
       width: parent.width
       Image{
           anchors.fill: parent
           source: 'pics/sober_newspecs/bg2.jpg'
           opacity: 0.4
       }
       Rectangle{
           id: appIcon
           x:20
           y:20
           width: 100
           color: 'transparent'
           height: 100
           Rectangle{
               id: app_overlay
               width: 100
               height: 100
               radius: width * 0.5
               border.width: 2
               border.color: border_color
               color: "transparent"
               Rectangle{
                   id: app_gradient
                   width: parent.width
                   height: parent.height
                   radius: parent.radius
                   color: "transparent"
                   opacity: 0.9

                   RadialGradient {
                       anchors.fill: parent
                       horizontalRadius: 84
                       verticalRadius: 84
                       gradient: Gradient {
                           GradientStop { position: 0.0; color: border_color}
                           GradientStop { position: 0.5; color: "transparent" }
                       }
                   }
               }
              Image {
                   id: app_icon
                   source: icon_path
                   anchors.centerIn: parent
                   anchors.horizontalCenter: parent.horizontalCenter
               }
           }
       }
       Text{
           id: appName
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.top: parent.top
           anchors.topMargin: 20
           text: app_name_str
           font.bold: true
       }
       Text{
           id: devName
           anchors.topMargin: 20
           anchors.top: appName.bottom
           anchors.left: appIcon.right
           anchors.leftMargin: 30
           text: dev_name
       }
       Text{
           id: appInfo1
           anchors.topMargin: 20
           anchors.top: appName.bottom
           anchors.right: installWin.right
           anchors.rightMargin: 30
           text: "Info1: appid: " + app_id
       }
       Text{
           id: appInfo2
           anchors.topMargin: 10
           anchors.top: devName.bottom
           anchors.left: appIcon.right
           anchors.leftMargin: 30
           text: "Info2: SomeInfo2"
       }
       Text{
           id: appInfo3
           anchors.topMargin: 10
           anchors.top: appInfo1.bottom
           anchors.right: installWin.right
           anchors.rightMargin: 30
           text: "Info3: SomeInfo3"
       }
       Rectangle{
           id: progressBarField
           visible: false
           anchors.top: appIcon.bottom
           anchors.bottom: installBtn.top
           anchors.left: installWin.left
           anchors.topMargin: 35
           anchors.bottomMargin: 25
           anchors.leftMargin: 40
           anchors.rightMargin: 40
           width: 420
           height: 20
           Text{
               text: appName.text + " app is downloading.."
               anchors.bottom: progressBar.top
               anchors.bottomMargin: 2
               font.pixelSize: 12
           }
           ProgressBar {
              id:progressBar
              anchors.fill: parent
              indeterminate: true
              style: ProgressBarStyle {
                  background: Rectangle {
                      radius: 2
                      color: "lightgray"
                      border.color: "gray"
                      border.width: 1
                      implicitWidth: 200
                      implicitHeight: 24
                  }
              }
           }
       }

       Button{
           id: installBtn
           text: "DOWNLOAD"
           visible: true
           anchors.left: parent.left
           anchors.bottom: parent.bottom
           anchors.leftMargin: installWin.width/2 - width
           anchors.bottomMargin: 30
           width: 100
           style: ButtonStyle {
                   background: Rectangle {
                       implicitWidth: 100
                       implicitHeight: 25
                       border.width: control.activeFocus ? 2 : 1
                       border.color: "#888"
                       radius: 4
                       gradient: Gradient {
                           GradientStop { position: 0 ; color: control.pressed ? "steelblue" : "lightsteelblue" }
                           GradientStop { position: 1 ; color: control.pressed ? "steelblue" : "lightsteelblue" }
                       }
                   }
               }
           onClicked: {
               progressBarField.visible=true
           }
       }


       Button{
           id: cancelBtn
           text: "CANCEL"
           visible:true
           width: 100
           anchors.left: installBtn.right
           anchors.leftMargin: 30
           anchors.bottom: parent.bottom
           anchors.bottomMargin: 30
           style: ButtonStyle {
                   background: Rectangle {
                       implicitWidth: 100
                       implicitHeight: 25
                       border.width: control.activeFocus ? 2 : 1
                       border.color: "#888"
                       radius: 4
                       gradient: Gradient {
                           GradientStop { position: 0 ; color: control.pressed ? "steelblue" : "lightsteelblue" }
                           GradientStop { position: 1 ; color: control.pressed ? "steelblue" : "lightsteelblue" }
                       }
                   }
               }
           onClicked: {
               installArea.visible=false
               content.enabled=true
               swipeArea.enabled=true
               progressBarField.visible=false
           }
       }

       Text{
           id: alreadyInsText
           anchors.bottom: okBtn.top
           anchors.bottomMargin: 20
           font.bold: true
           visible: false
           text: appName.text + " app is already installed."
           anchors.horizontalCenter: parent.horizontalCenter
       }

       Text{
           id: nowInstalledTxt
           anchors.bottom: okBtn.top
           anchors.bottomMargin: 20
           font.bold: true
           visible: false
           text: appName.text + " app has successfully installed."
           anchors.horizontalCenter: parent.horizontalCenter
       }

       Button{
           id: okBtn
           text: "OK"
           visible: false
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.bottomMargin: 30
           anchors.bottom: parent.bottom
           width: 100
           style: ButtonStyle {
                   background: Rectangle {
                       implicitWidth: 100
                       implicitHeight: 25
                       border.width: control.activeFocus ? 2 : 1
                       border.color: "#888"
                       radius: 4
                       gradient: Gradient {
                           GradientStop { position: 0 ; color: control.pressed ? "steelblue" : "lightsteelblue" }
                           GradientStop { position: 1 ; color: control.pressed ? "steelblue" : "lightsteelblue" }
                       }
                   }
               }
           onClicked: {
               installArea.visible=false
               content.enabled=true
               swipeArea.enabled=true
           }
       }
   }
   onApp_idChanged:{
        console.log("app id is : "+ app_id)
        if(app_id == 2)
        {
            okBtn.visible=true
            cancelBtn.visible=false
            installBtn.visible=false
            alreadyInsText.visible=true
            nowInstalledTxt.visible=false
        }
        else if(app_id == 3)
        {
            okBtn.visible=true
            cancelBtn.visible=false
            installBtn.visible=false
            nowInstalledTxt.visible=true
            alreadyInsText.visible=false
        }
        else
        {
            okBtn.visible=false
            cancelBtn.visible=true
            installBtn.visible=true
            alreadyInsText.visible=false
            nowInstalledTxt.visible=false
        }
   }
}

