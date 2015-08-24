import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    title: qsTr("Network Configuration")
    width: 1024
    height: 600
    visible: true

    ApplicationArea{
        id: applicationArea
        anchors.fill: parent


        LeftWidgetArea{
            id: leftWidgetArea
            x:0
            y:0
        }
    }

}
