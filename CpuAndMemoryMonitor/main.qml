import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    title: qsTr("CPU and Memory Monitor")
    width: 1024
    height: 600
    visible: true

    //for the Processes.qml
    property var statsString
    property string name
    property string mem
    property string pid
    property string memHumanReadable
    property var processEntry

    //for delegates
    property int numberOfPages: 2



    ApplicationArea{
        LeftWidgetArea{
            title: "CPU and Memory Monitor"
            description: "You can monitor your CPU and Memory"
            iconSource: "assets/icon_cpu.png"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }
    }

}
