import QtQuick 2.0

Item{
    width: parent.width
    height: 48
    //color: "transparent"
    anchors.bottom: parent.bottom

    Image{
        id:backButton
        source: "pics/backIcon.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 81

        MouseArea{
            anchors.fill: parent

            onClicked:{
                console.log("Back button clicked!")
            }
        }

    }

    Image{
        id:homeButton
        source: "pics/homeIcon.png"
        //scale: 0.25
        anchors.verticalCenter: parent.verticalCenter
        anchors.centerIn: parent


        MouseArea{
            anchors.fill: parent

            onClicked:{
                console.log("Home button clicked!")
            }
        }

    }

    Image{
        id:processesButton
        source: "pics/processes.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 81

        MouseArea{
            anchors.fill: parent

            onClicked:{
                console.log("List Processes button clicked!")
            }
        }

    }
}
