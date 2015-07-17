import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

Item{
    property alias ramBar: pBar
    property alias ramPercentage: ramPerc
    property alias usedFreeTotalRow: uftrow


    width: 1024
    height: 80



    Column{
        width: parent.width
        height: parent.height


        Rectangle {
            width: parent.width
            height: parent.height / 2

            Text{
                text: "RAM:"
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.verticalCenter: parent.verticalCenter
            }

            ProgressBar{
                id: pBar
                value: 0.7
                anchors.centerIn: parent
                anchors.verticalCenter: parent.verticalCenter
                Behavior on value{NumberAnimation{duration: 300}}

                style: ProgressBarStyle{
                    background: Rectangle {
                                radius: 2
                                color: "lightgray"
                                border.color: "gray"
                                border.width: 1
                                implicitWidth: 500
                                implicitHeight: 30
                            }
                            progress: Rectangle {
                                color: "lightsteelblue"
                                border.color: "steelblue"
                            }

                }
            }

            Text{
                id:ramPerc
                text: "70 %"
                anchors.right: parent.right
                anchors.rightMargin: 30
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea{
                hoverEnabled: true
                anchors.fill: parent
                onEntered: parent.color = "#97B9F7"
                onExited: parent.color = "white"
            }
        }

        Rectangle{
            width: parent.width
            height: parent.height / 2


            Row{
                id: uftrow
                anchors.centerIn: parent
                anchors.verticalCenter: parent.verticalCenter
                spacing: 60
                property string usedRam
                property string freeRam
                property string totalRam
                Text{
                    text: "<b>USED</b>: "+ uftrow.usedRam + " MB"
                }

                Text{
                    text: "<b>FREE</b>: "+ uftrow.freeRam + " MB"
                }

                Text{
                    text: "<b>TOTAL</b>: "+ uftrow.totalRam + "  MB"
                }
            }

            MouseArea{
                hoverEnabled: true
                anchors.fill: parent
                onEntered: parent.color = "#97B9F7"
                onExited: parent.color = "white"
            }


        }
    }
}


