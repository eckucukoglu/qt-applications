import QtQuick 2.0

Item {
    width: 346
    height: 600

    property alias title: titleText.text
    property alias description: descText.text
    property alias iconSource: img.source

    Rectangle{
        anchors.fill: parent
        color: "#3b393e"

        Image{
            id: img
            x: 120
            y: 172
        }

        SoberText{
            id:titleText
            //x: 50
            y: 306
            font.pixelSize: 24
            horizontalAlignment: Qt.AlignHCenter
            anchors.right: parent.right
            anchors.left: parent.left
        }

        SoberText{
            id:descText
            //x:80
            y:337
            font.pixelSize: 14
            horizontalAlignment: Qt.AlignHCenter
            anchors.right: parent.right
            anchors.left: parent.left
        }

        Rectangle{
            id:greenRightStroke
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: 1
            color: "#0b988b"
        }
    }

}

