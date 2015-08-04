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
        text: "" + new Date().toLocaleTimeString(Qt.locale("tr_TR"), "hh:mm:ss") + "  |  " +
              new Date().toLocaleDateString(Qt.locale("en_EN"), "dd-MM-yyyy")
        font.pixelSize: 17
        color: "white"

        onTextChanged: {
            gc()
        }
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
        interval: 200
        running: true
        repeat: true
        onTriggered: {
            hourAndDate.text = new Date().toLocaleTimeString(Qt.locale("tr_TR"), "hh:mm:ss") + "  |  " +
                      new Date().toLocaleDateString(Qt.locale("tr_TR"), "dd-MM-yyyy")
            gc();
        }
    }
}
