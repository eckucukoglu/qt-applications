import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

Item{
    property alias cpu0progressBar: cpu0pbar
    property alias cpu0percentage: cpu0perc
    property alias cpu1progressBar: cpu1pbar
    property alias cpu1percentage: cpu1perc


    width: 1024
    height: 80

    Column{
        width: parent.width
        height: parent.height

        Rectangle{
            width: parent.width
            height: parent.height / 2

            Text{
                text: "CPU 0"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 30
            }

            ProgressBar{
                id:cpu0pbar
                value: 0.04
                anchors.centerIn: parent
                anchors.verticalCenter: parent.verticalCenter
                style: progressBarStyleBlue
                Behavior on value{NumberAnimation{duration: 100}}
            }

            Text{
                id:cpu0perc
                text: "4%"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 30
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

            Text{
                text: "CPU 1"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 30
            }

            ProgressBar{
                id:cpu1pbar
                value: 0.1
                anchors.centerIn: parent
                anchors.verticalCenter: parent.verticalCenter
                style: progressBarStyleBlue
                Behavior on value{NumberAnimation{duration: 100}}
            }

            Text{
                id:cpu1perc
                text: "10%"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 30

            }

            MouseArea{
                hoverEnabled: true
                anchors.fill: parent
                onEntered: parent.color = "#97B9F7"
                onExited: parent.color = "white"
            }

        }
    }

    Component{
        id:progressBarStyleBlue
        ProgressBarStyle{
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
}

