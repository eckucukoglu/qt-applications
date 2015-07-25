import QtQuick 2.0

Rectangle{
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
