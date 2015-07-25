import QtQuick 2.0

Rectangle{
    height: 34
    width: parent.width
    anchors.top: parent.top
    color: "transparent"

    Rectangle{
        anchors.fill: parent
        color: "black"
        opacity: 0.5
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
