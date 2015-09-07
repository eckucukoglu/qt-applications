import QtQuick 2.0

Item{
    id: item1
    property string info
    property string text1
    property string text2
    property string activeText
    signal switched()

    width: 587
    height: 33

    SequentialAnimation{
        id:blink
        PropertyAnimation{
            target: activeTextField
            property: "opacity"
            to:0
            duration: 200
            easing.type: Easing.OutQuad
        }
        PropertyAnimation{
            target: activeTextField
            property: "opacity"
            to:1
            duration: 200
            easing.type: Easing.OutQuad
        }
    }

    onSwitched: blink.start()


    SoberText{
        id: infoText
        text: info
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 20
        width: 206
        height: 20
    }

    Item{
        id: switchItem
        width: 273
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter

        anchors.left: infoText.right
        anchors.leftMargin: 95

        Image{
            anchors.verticalCenter: parent.verticalCenter
            source: "assets/back_button.png"
            anchors.left: parent.left
            //anchors.verticalCenter: parent.verticalCenter


            MouseArea{
                anchors.fill: parent
                onClicked: switched()
            }
        }

        SoberText{
            id: activeTextField
            height: 20
            width: 273
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: activeText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 20
        }

        Image{
            anchors.verticalCenter: parent.verticalCenter
            source: "assets/forward_button.png"
            anchors.right: parent.right
            //anchors.verticalCenter: parent.verticalCenter


            MouseArea{
                anchors.fill: parent
                onClicked: switched()
            }
        }
    }



    Component.onCompleted: {
        activeText = text1
        info: ""
    }

}
