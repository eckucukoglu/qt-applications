import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.3
import Qt.labs.folderlistmodel 2.1
Item{
    width:1024
    height: 400
    Rectangle{
        id: processesTitle
        width: parent.width
        height: 60
        z:10

        Image{
            id: arrow1
            source: "arrow-up.png"
            rotation: 180
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
            scale: 0.3
            Behavior on rotation {RotationAnimation{duration: 300}}
        }

        Image{
            id: arrow2
            source: "arrow-up.png"
            rotation: 180
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            scale: 0.3
            Behavior on rotation {RotationAnimation{duration: 300}}
        }

        Text{
            text: "PROCESSES"
            anchors.centerIn: parent
            font.pixelSize: 24
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled:true
//            onClicked: {if(processListView.opacity == 0) processListView.opacity = 1;
//                        else    processListView.opacity = 0;
//                        arrow1.rotation += 180; arrow2.rotation += 180}

            onEntered: parent.color = "#97B9F7";
            onExited: parent.color = "white";
        }
    }

    ListModel{
        id: processListModel
        //Create list elements of 'processes' from proc/pid/stat

    }

//    ListView{
//        id: folderView
//        width: parent.width
//        height: 350
//        anchors.top: processesTitle.bottom
//        anchors.bottom: killProcessBar.top
//        FolderListModel{
//            id:foldermodel
//            folder: "/proc"
//            nameFilters: [ "*" ]
//        }

//        Item{
//            id:fileDelegate
//            width: parent.width
//            height: 50

//            Rectangle{
//                height: parent.height
//                width: parent.width

//                Text{
//                    text: fileName
//                }
//            }
//        }

//        model: foldermodel
//        delegate: fileDelegate
//    }


    TableView{
        id: processListView
        width: parent.width
        height: 350
        TableViewColumn{
            role: "name"
            title: "Name"
            width: 256
        }

        TableViewColumn{
            role: "cpuUsage"
            title: "CPU Usage"
            width: 256
        }

        TableViewColumn{
            role: "memUsageValue"
            title: "Memory Usage (MB)"
            width: 256
        }

        TableViewColumn{
            role: "memUsage"
            title: "Memory Usage"
            width: 256
        }


        model: processListModel
        opacity: 0
        Behavior on opacity{ NumberAnimation{duration: 500; easing.type: Easing.OutCubic} }
        clip: true
        anchors.top: processesTitle.bottom
        anchors.bottom: killProcessBar.top

        style: TableViewStyle{
        }

    }

    Component{
        id: processDelegate

        Item{
            width: parent.width
            height: 50


            Rectangle{
                id: topBorder
                width: parent.width
                height: 1
                color: "black"
            }

            Rectangle{
                id: contentRect
                width: parent.width
                height: 80
                anchors.top: topBorder.bottom

                color: processListView.currentIndex == index ?  "#97B9F7" : "white"

                Grid{
                    anchors.leftMargin: 10
                    columns: 7
                    spacing: 100
                    Rectangle{
                        height: parent.height
                        width: 2
                        color: "black"
                    }

                    Text{text: "Name: " + name}
                    Rectangle{
                        height: parent.height
                        width: 2
                        color: "black"
                    }
                    Text{text: "MemUsage: " + memUsage}
                    Rectangle{
                        height: parent.height
                        width: 2
                        color: "black"
                    }
                    Text{text: "CpuUsage: " + cpuUsage}

                }
            }

            Rectangle{
                id: botBorder
                width: parent.width
                height: 1
                color: "black"
                anchors.top: contentRect.bottom
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {processListView.currentIndex = index}
            }
        }
    }

    Rectangle{
        id: killProcessBar
        width: parent.width
        height: 60
        anchors.bottom: parent.bottom

        Button{
            text: "KILL PROCESS"
            anchors.centerIn: parent

            style: ButtonStyle{
                background: Rectangle{
                    implicitWidth: 200
                    implicitHeight: 50
                    border.width: control.pressed ? 2 : 1
                    border.color: "#4479DB"
                    radius: 4

                    color: control.pressed ? "#97B9F7" : "white"

                }

            }

        }

    }
}


