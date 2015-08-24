import QtQuick 2.0

Item{
    property string info

    width: 587
    height: 33

    SoberText{
        id: infoText
        text: info
        font.pixelSize: 20
        width: 206
        height: 20
        anchors.verticalCenter: parent.verticalCenter
    }

    Rectangle{
        id: addressRect
        anchors.verticalCenter: parent.verticalCenter
        color: "#4E4D55"
        anchors.left: infoText.right
        anchors.leftMargin: 95

        width: 286
        height: 33

        TextInput{
            color: readOnly ? "#858181" : "#d5d1d1"
            font.pixelSize: 20
            font.family: "Helvetica"
            width: 273

            anchors.centerIn: parent


            inputMask:  "000.000.000.000;"
//            validator:RegExpValidator{
//            regExp:/^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
//            }

        }
    }
}

