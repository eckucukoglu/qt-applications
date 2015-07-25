import QtQuick 2.0

Component {
    id: appDelegate
    Rectangle {
        id: appDelegateRect
        parent: coords
        width: 111
        height: 134
        color: "transparent"
        Column {
            width: parent.width
            height: parent.height
            spacing: 8

            Image {
                id: appIcon
                source: portrait
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: appName
                text: name
                width: parent.width + 16
                elide: Text.ElideRight

                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 15
                color: "white"
            }
        }

        states: [
            State {
                name: "inDrag"
                when: index == grid.draggedItemIndex
                PropertyChanges { target: appDelegateRect; parent: dndContainer }
                PropertyChanges { target: appDelegateRect; x: coords.mouseX - appDelegateRect.width / 2 }
                PropertyChanges { target: appDelegateRect; y: coords.mouseY - appDelegateRect.height / 2 }
            }
        ]



    }
}
