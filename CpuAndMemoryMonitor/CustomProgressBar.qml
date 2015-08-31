import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.3

Item{
    property alias text: title.text
    property alias value: pBar.value
    property int progressBarRightMargin
    property string fillColor: pBar.color
    property string bgText
    property string progressBarText

    width: 577
    height: 50

    SoberText{
        width: parent.width
        anchors.top: parent.top
        id: title
        font.pixelSize: 20
        height: 20
    }

    ProgressBar{
        id: pBar
        style: progressBarStyle
        anchors.top: title.bottom
        anchors.topMargin: 15
        //value: 0.4
        width: 577
        height: 14
    }

    Component{
        id:progressBarStyle
        ProgressBarStyle{
            background: Rectangle {
                color: "#4e4c55"

                SoberText{
                    anchors.right: parent.right
                    anchors.rightMargin: progressBarRightMargin
                    //anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 14
                    text: bgText
                }
            }
            progress: Rectangle {
                color: fillColor
                //border.color: "steelblue"

                SoberText{
                    anchors.right: parent.right
                    anchors.rightMargin: progressBarRightMargin
                    //anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 14
                    font.weight: Font.Normal
                    text: progressBarText
                    color: "#444547"
                }
            }

        }
    }

}
