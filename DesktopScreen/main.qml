import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    title: qsTr("Desktop Screen")
    width: 1024
    height: 600
    maximumHeight: height
    minimumHeight: height
    maximumWidth: width
    minimumWidth: width
    visible: true
    id: root

    property var itemData: ["#22eeeeee", "#22eeeeee"]
    property int currentIndex: 0

    onCurrentIndexChanged: {
        slide_anim.to = - root.width * currentIndex
        slide_anim.start()
    }
    PropertyAnimation {
        id: slide_anim
        target: content
        easing.type: Easing.OutExpo
        properties: "x"
        duration: 400
    }

    Image {
        id: img
        anchors.verticalCenter: root.verticalCenter
        source: "pics/bg2.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Item{
        id:content
        width: root.width * itemData.length
        height: root.height - topBar.height - bottomBar.height
        anchors.top: topBar.bottom
        anchors.bottom: bottomBar.top
        property double k: (content.width - root.width) / (img.width - root.width)
        onXChanged: {
            img.x = x / k
        }

        Rectangle{
            id:contentOfGrid
            width: parent.width
            height: parent.height

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            anchors.topMargin: 16
            anchors.leftMargin: 52
            anchors.bottomMargin: 34
            color: "transparent"

            SwipeArea {
                id: mouse
                anchors.fill: parent

                //preventStealing: true
                propagateComposedEvents: true
                z: 1
                drag.filterChildren: true;
                drag.threshold: 15

                onMove: {
                    if(currentIndex != 0 && currentIndex != (itemData.length - 1))
                        content.x = (-root.width * currentIndex) + x
                }
                onSwipe: {
                    switch (direction) {
                    case "left":
                        if (currentIndex === itemData.length - 1) {
                            currentIndexChanged()
                        }
                        else {
                            currentIndex++
                        }
                        break
                    case "right":
                        if (currentIndex === 0) {
                            currentIndexChanged()
                        }
                        else {
                            currentIndex--
                        }
                        break
                    }
                }
                onCanceled: {
                    currentIndexChanged()
                }
            }


            Component {
                id: appDelegate
                Rectangle {
                    width: 111
                    height: 134
                    color: "transparent"
                    Column {
                        width: parent.width
                        height: parent.height
                        spacing: 8

                        Image {
                            id: appIcon
                            source: portrait
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            id: appName
                            text: name
                            width: parent.width + 15
                            elide: Text.ElideRight

                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            color: "white"
                        }
                    }

                    MouseArea{
                        anchors.fill: parent
                        preventStealing: true
                        propagateComposedEvents: true
                        onClicked:{mainMenuGrid.currentIndex = index;}

                    }
                }
            }

            GridView{
                id:mainMenuGrid

                height: parent.height
                width: parent.width / 2

                cellHeight: 164
                cellWidth: 162

                contentWidth: parent.width *2
                contentHeight: parent.height

                interactive: false
                //boundsBehavior: Flickable.DragOverBounds
                snapMode: GridView.SnapOneRow
                flow: GridView.LeftToRight

                model: MenuModel {}
                delegate: appDelegate
                highlight: Rectangle { color: "lightsteelblue"; opacity: 0.3}
                focus: true
                clip:true
            }
        }
    }

    //Dots row
    Row {
        anchors { bottom: parent.bottom; bottomMargin: 48; horizontalCenter: parent.horizontalCenter }
        spacing: 16
        Repeater {
            model: itemData.length
            Rectangle {
                width: 12; height: 12; radius: 6
                color: currentIndex === index ? "#88ffffff" : "#88000000"
                border { width: 2; color: currentIndex === index ? "#33000000" : "#11000000" }
            }
        }
    }

    //TopBar
    Item{
        id: topBar
        height: 34
        width: parent.width
        Rectangle{
            anchors.fill: parent
            color: "black"
            opacity: 0.5
            anchors.top: parent.top
        }

        Text{
            id: hourAndDate
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            text: "" + new Date().toLocaleTimeString(Qt.locale("tr_TR"), "hh:mm") + " | " +
                  new Date().toLocaleDateString(Qt.locale("en_EN"), "dd-MM-yyyy")
            font.pixelSize: 17
            color: "white"
        }
    }



    //BottomBar
    Rectangle{
        id: bottomBar
        width: parent.width
        height: 48
        color: "transparent"
        anchors.bottom: parent.bottom

        Image{
            id:backButton
            source: "pics/backIcon.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 81

        }

        Image{
            id:homeButton
            source: "pics/homeIcon.png"
            //scale: 0.25
            anchors.verticalCenter: parent.verticalCenter
            anchors.centerIn: parent

        }

        Image{
            id:processesButton
            source: "pics/processes.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 81

        }
    }


}
