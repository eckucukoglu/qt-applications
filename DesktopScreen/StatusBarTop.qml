import QtQuick 2.0

Rectangle{
    height: 34
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
        text: date.toLocaleTimeString(Qt.locale("en_EN"), "hh:mm") + "  |  " +
              date.toLocaleDateString(Qt.locale("en_EN"), "dd MMM")
        font.pixelSize: 15
        color: "white"
    }

    Row{
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 60
        spacing: 10
        Image{
            source: "pics/blueetooth.png"
        }

        Image{
            source: "pics/energy39.png"

            Text{
                anchors.left: parent.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                text: "62%"
                color: "white"
                font.pixelSize: 15
            }
        }
    }

    Timer{
        interval: 10000
        running: true
        repeat: true
        onTriggered: {
            date = new Date();
            hourAndDate.text = date.toLocaleTimeString(Qt.locale("en_EN"), "hh:mm") + "  |  " +
                      date.toLocaleDateString(Qt.locale("en_EN"), "dd MMM")
        }
    }

    Component.onCompleted: {
        date = new Date();
    }
}
