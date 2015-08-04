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

    property int numberOfPages: 2
    property int currentIndex: 0

    function getNumberOfPages(){
        var count = menuModel.count
        var numOfPages = parseInt(count / 18)
        if(count % 18 != 0)
            numOfPages++

        return numOfPages
    }

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
        id: background
        anchors.verticalCenter: root.verticalCenter
        source: "pics/bg2.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Item{
        id:content
        width: root.width * numberOfPages
        height: root.height - statusBar.height - navigationBar.height
        anchors.top: statusBar.bottom
        anchors.bottom: navigationBar.top
        property double k: (content.width - root.width) / (background.width - root.width)
        onXChanged: {
            background.x = x / k
        }

        Rectangle{
            id:contentOfGrid
            width: parent.width
            height: parent.height// - 120

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            anchors.topMargin: 16
            anchors.leftMargin: 52
            anchors.bottomMargin: 34
            color: "transparent"

            SwipeArea {
                anchors.fill: parent
                id:swipeArea

                //preventStealing: true
                propagateComposedEvents: true
                //z: 1
                //drag.filterChildren: true;
                drag.threshold: 15

                onMove: {
                    if(currentIndex != 0 && currentIndex != (numberOfPages - 1))
                        content.x = (-root.width * currentIndex) + x
                }
                onSwipe: {
                    //mouse.accepted = true;
                    switch (direction) {
                    case "left":
                        if (currentIndex === numberOfPages - 1) {
                            currentIndexChanged()
                            //grid1.focus = false
                            //grid2.focus = true
                            //grid2.forceActiveFocus()

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

                GridView{
                    id:grid1

                    height: parent.height
                    width: parent.width / numberOfPages

                    cellHeight: 156
                    cellWidth: 162

                    interactive: false

                    boundsBehavior: Flickable.StopAtBounds
                    snapMode: GridView.SnapOneRow

                    model: MenuModel {
                        id:menuModel
                    }
                    delegate: AppDelegate{
                    }

                    focus: true
                    clip:true
                }

                GridView{
                    id:grid2
                    anchors.left: grid1.right

                    height: parent.height
                    width: parent.width / numberOfPages

                    x: parent.width

                    cellHeight: 156
                    cellWidth: 162

                    interactive: false

                    boundsBehavior: Flickable.StopAtBounds
                    snapMode: GridView.SnapOneRow

                    model: Menu2Model{
                        id:menu2Model
                    }

                    delegate: AppDelegate{
                    }

                    //focus: true
                    clip:true
                }
            }
        }
    }

    //Dots row
    Row {
        id: dotsRow
        anchors { bottom: parent.bottom; bottomMargin: 58; horizontalCenter: parent.horizontalCenter }
        spacing: 16
        Repeater {
            model: numberOfPages
            Rectangle {
                width: 12; height: 12; radius: 6
                color: currentIndex === index ? "#88ffffff" : "#88000000"
                border { width: 2; color: currentIndex === index ? "#33000000" : "#11000000" }
            }
        }
    }

    //StatusBar
    StatusBarTop{
        id:statusBar

    }

    //BottomBar
    NavigationBar{
        id:navigationBar
    }


}
