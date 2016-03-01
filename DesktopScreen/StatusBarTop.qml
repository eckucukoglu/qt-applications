import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.0

Rectangle{
    height: 24
    width: parent.width
    anchors.top: parent.top
    color: "transparent"

    property var date
    Rectangle{
        anchors.fill: parent
        color: "black"
        opacity: 0.3
    }

    Text{
        id: hourAndDate
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 20
        text: date.toLocaleTimeString(Qt.locale("en_EN"), "hh:mm:ss") + "  |  " +
              date.toLocaleDateString(Qt.locale("en_EN"), "dd MMM yyyy")
        font.pixelSize: 12
        color: "white"
    }

    MessageDialog {
        id: msgLogout
        title: "Warning!"
        visible: false
        icon: StandardIcon.Warning
        text: "You are logging out. Do you want to continue?"
        standardButtons: StandardButton.Yes |  StandardButton.No
        onYes: console.log("yes") //open lock screen
        onNo: console.log("no")
    }


    Row{
        id: rowItems
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 20
        spacing: 8
        Image{
            source: "pics/blueetooth.png"
            scale: 0.7
        }

        Image{
            id: energyIcon
            source: "pics/energy39.png"
            scale: 0.9
        }
        Text{
            id: energyTxt
            anchors.verticalCenter: parent.verticalCenter
            text: "62%"
            color: "white"
            font.pixelSize: 12
        }
        Image{
            source: "pics/settings-icon.png"
            scale: 0.7
            Rectangle{
                anchors.top: root.top
                anchors.horizontalCenter: parent.horizontalCenter
                width: 120
                height: 50
                opacity: 0
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        //msgLogout.visible=true
                        settingsMenu.visible ^=true
                    }
                }
            }
        }

    }






   Rectangle{
        id: settingsMenu
        visible: false
        anchors.top: statusBar.bottom
        anchors.right: parent.right
        width: 180
        height: 120
        radius: 6
        Image{
            source: root.backgroundImg
            anchors.fill: parent
            opacity: 0.28
        }
        Rectangle{
            id: verticalSeperator
            width: 2
            anchors.verticalCenter: parent.verticalCenter
            opacity: 0.4
            x: 42
            color: "darkgray"
            height: parent.height-10
        }

        Rectangle{
             id: lockBtn
             anchors.top: parent.top
             width: parent.width
             color: "transparent"
             height: 40
             Image{
                source: "pics/lock.png"
                scale: 0.18
                anchors.right: lockTxt.left
                anchors.rightMargin: -18
                anchors.verticalCenter: parent.verticalCenter

             }
             Text{
                 id: lockTxt
                 text: "Lock"
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 font.bold: true
                 font.pixelSize: 18
                 font.family: "helvetica"
                 color: "darkgray"
             }
             RadialGradient {
                 id: gradientLock
                 visible: false
                 anchors.fill: parent
                 horizontalRadius: parent.width -10
                 verticalRadius: 84
                 gradient: Gradient {
                     GradientStop { position: 0.0; color: "#E6EBED" }
                     GradientStop { position: 0.5; color: "transparent" }
                 }
             }
             MouseArea{
                 anchors.fill: parent
                 propagateComposedEvents: false
                 onPressed: {
                     gradientLock.visible=true
                     lockTxt.color="#050505"
                 }
                 onReleased: {
                     gradientLock.visible=false
                     lockTxt.color = "#A2A3A3"
                 }
                 onClicked: {
                       settingsMenu.visible=false
                       console.log(">>TODO: lock the screen")
                 }
             }
        }
        Rectangle{
            anchors.top: lockBtn.bottom
            width: parent.width - 10
            color: "#A8A8A8"
            anchors.horizontalCenter: parent.horizontalCenter
            height: 2
        }
        Rectangle{
             id: powerOffBtn
             anchors.top: lockBtn.bottom
             width: parent.width
             color: "transparent"
             height: 40
             Image{
                source: "pics/poweroff.png"
                scale: 0.4
                anchors.right: powerOffTxt.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: -10
                opacity: 0.8

             }
             Text{
                 id: powerOffTxt
                 text: "Power Off"
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 font.bold: true
                 font.pixelSize: 18
                 font.family: "helvetica"
                 color: "darkgray"
             }
             RadialGradient {
                 id: gradientPwrOff
                 visible: false
                 anchors.fill: parent
                 horizontalRadius: parent.width -10
                 verticalRadius: 84
                 gradient: Gradient {
                     GradientStop { position: 0.0; color: "#E6EBED" }
                     GradientStop { position: 0.5; color: "transparent" }
                 }
             }
             MessageDialog {
                 id: powerOffMsg
                 title: "Warning!"
                 icon: StandardIcon.Question
                 text: "Do you want to Power Off"
                 standardButtons: StandardButton.Yes | StandardButton.No
                 onYes: {
                     AppsModel.shutdown()
                 }

                 onNo: {
                     console.log("canceled")
                     powerOffMsg.visible=false
                 }
             }
             MouseArea{
                 anchors.fill: parent
                 propagateComposedEvents: false
                 onPressed: {
                        powerOffTxt.color="#050505"
                        gradientPwrOff.visible=true
                 }
                 onReleased: {
                         powerOffTxt.color="#A2A3A3"
                         gradientPwrOff.visible=false
                 }
                 onClicked: {
                       settingsMenu.visible=false
                       powerOffMsg.visible=true
                 }
             }
        }
        Rectangle{
            anchors.top: powerOffBtn.bottom
            width: parent.width - 10
            color: "#A8A8A8"
            anchors.horizontalCenter: parent.horizontalCenter
            height: 2
        }

        Rectangle{
             id: settingsBtn
             anchors.top: powerOffBtn.bottom
             width: parent.width
             color: "transparent"
             height: 40
             Image{
                source: "pics/settings.png"
                anchors.right: settingsTxt.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 16
                opacity: 0.7

             }
             Text{
                 id: settingsTxt
                 text: "Settings"
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 font.bold: true
                 font.pixelSize: 18
                 font.family: "helvetica"
                 color: "darkgray"
             }
             RadialGradient {
                 id: gradientSttngs
                 visible: false
                 anchors.fill: parent
                 horizontalRadius: parent.width -10
                 verticalRadius: 84
                 gradient: Gradient {
                     GradientStop { position: 0.0; color: "#E6EBED" }
                     GradientStop { position: 0.5; color: "transparent" }
                 }
             }
             MouseArea{
                 anchors.fill: parent
                 propagateComposedEvents: false
                 onPressed: {
                        settingsTxt.color="#050505"
                        gradientSttngs.visible=true
                 }
                 onReleased: {
                         settingsTxt.color="#A2A3A3"
                         gradientSttngs.visible=false
                 }
                 onClicked: {
                       settingsMenu.visible=false
                       console.log(">>TODO: Settings")
                 }
             }
        }
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


    Component.onCompleted: {
        date = new Date();
    }
}
