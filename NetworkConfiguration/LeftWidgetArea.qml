import QtQuick 2.0

Item {
    width: 346
    height: 600

    Rectangle{
        anchors.fill: parent
        color: "#3b393e"

        Image{
            source: "assets/network_icon.png"
            x: 120
            y: 172
        }

        SoberText{
            x: 50
            y: 306
            text: "NETWORK SETTINGS"
            font.pixelSize: 24
        }

        SoberText{
            x:80
            y:337
            text: "You can manage your network"
            font.pixelSize: 14
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

