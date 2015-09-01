import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import CpuMemHandler 1.0

Component{
    id:processDelegate

    Item{
        property int numberOfPages: 2
        property int currentIndex: 0
        id:root
        width: 577
        height: 45
        onCurrentIndexChanged: {
            slide_anim.to = - root.width * currentIndex
            slide_anim.start()
            slide_anim.alwaysRunToEnd = true
        }


        PropertyAnimation {
            id: slide_anim
            target: content
            easing.type: Easing.OutQuad

            properties: "x"
            duration: 500
        }

        SwipeArea {
            anchors.fill: parent
            id:swipeArea
            z:-1
            onMove: {
                if((x > 0 && currentIndex != 0) || (x < 0 && currentIndex != numberOfPages-1 )){ //only when swipeable
                    content.x =(-root.width * currentIndex) + x
                }
            }
            onSwipe: {

                console.log("swipe.")
                switch (direction) {
                case "left":
                    if (currentIndex === numberOfPages - 1) {
                        currentIndexChanged()
                    }
                    else {
                        currentIndex++
                        //currentIndexChanged()
                    }
                    break
                case "right":
                    if (currentIndex === 0) {
                        currentIndexChanged()   //realign the view
                    }
                    else {
                        currentIndex--          //change the index
                        //currentIndexChanged()   //then realign the view
                    }
                    break
                }

            }

            onCanceled: {
                currentIndexChanged()
            }

        }

        Rectangle{
            id: contentContainer
            anchors.fill: parent
            color: "transparent"
            border.width: 1
            border.color: "#4e4c55"
            Rectangle{
                id: content
                width: parent.width * numberOfPages
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                color: "transparent"

                Rectangle{
                    id: coloredCircle
                    width: 20
                    height: 20
                    radius: width * 0.5
                    border.color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 8

                    Rectangle{
                        anchors.fill: parent
                        radius: parent.width * 0.5
                        color: parent.border.color
                        opacity: 0.4
                    }
                }

                SoberText{
                    id: processName
                    anchors.left: coloredCircle.right
                    //anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    font.pixelSize: 18

                    text: name
                }

                SoberText{
                    id: memText
                    horizontalAlignment: Qt.AlignRight
                    anchors.left: processName.right
                    anchors.leftMargin: 480
                    anchors.top: parent.top
                    anchors.topMargin: 10

                    font.pixelSize: 18

                    text: memory
                }

                Button{
                    anchors.verticalCenter: parent.verticalCenter
                    text: "KILL PROCESS"
                    x: parent.width * 0.70

                    onClicked:{
                        var result = cpuMemHandler.tryToKillProcess(parseInt(pid))
                    }
                }
            }
        }
        CpuMemHandler{
            id: cpuMemHandler
        }

        Component.onCompleted: {
            console.log("name: " + name)
            console.log("memory: " + memory)
            console.log("pid: " + pid)
        }
    }



}
