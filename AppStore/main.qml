import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.2

ApplicationWindow {
    title: qsTr("Desktop Screen")
    width: 800//1024
    height: 480 //600
    visible: true
    id: root
    property int numberOfPages: AppsModel.get_page_count()
    property int currentIndex: AppsModel.get_current_index()

    onCurrentIndexChanged: {
        slide_anim.to = - root.width * currentIndex
        slide_anim.start()
        slide_anim.alwaysRunToEnd = true
        AppsModel.set_page_index(currentIndex)
    }

    BusyIndicator {
           id: busyIndication
           anchors.centerIn: parent
           Text{
               anchors.top: parent.bottom
               anchors.horizontalCenter: parent.horizontalCenter
               text: "connecting to server.."
           }

           z:1
        }

    PropertyAnimation {
        id: slide_anim
        target: content
        easing.type: Easing.OutQuart
        properties: "x"
        duration: 500
    }

    Image {
        id: background
        anchors.fill: parent
        opacity: 0.7
        source: "pics/sober_newspecs/bg2.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Item {
        id:content
        enabled: true
        anchors.top: statusBar.bottom
        anchors.bottom: navigationBar.top
        width: root.width * 3
        Component.onCompleted: {
            var desktopGrid;
            var component;
            var i;
            for(i=0;i<3;i++)
            {
                component= Qt.createComponent("DesktopGrid.qml");
                desktopGrid = component.createObject(content, {"x":i*root.width, "width": root.width, "height": root.height - statusBar.height - navigationBar.height});
                if (desktopGrid === null) {
                    // Error Handling
                }
                else{
                    // successful
                }
            }
            busyIndication.visible=false
         }
    }

    StatusBarTop{
        id:statusBar

    }
    NavigationBar{
        id:navigationBar
    }
    SwipeArea {
        id: swipeArea
        width: root.width * numberOfPages
        height: root.height - statusBar.height - navigationBar.height
        anchors.top: statusBar.bottom
        anchors.bottom: navigationBar.top
        onMove: {
            if((x > 0 && currentIndex != 0) || (x < 0 && currentIndex != numberOfPages-1 )){ //only when swipeable
                content.x =(-root.width * currentIndex) + x
            }
        }
        onSwipe: {
            switch (direction) {
            case "left":
                if (currentIndex === numberOfPages - 1) {
                    currentIndexChanged()
                }
                else {
                    currentIndex++                    
                }
                break
            case "right":
                if (currentIndex === 0) {
                    currentIndexChanged()   //realign the view
                }
                else {
                    currentIndex--          //change the index
                }
                break
            }
        }
        onCanceled: {
            currentIndexChanged()
        }
    }
    Row {
        id: dotsRow
        anchors {  bottom: parent.bottom; bottomMargin: 30 ; horizontalCenter: parent.horizontalCenter }
        spacing: 10
        height: 14
        Repeater {
            model: AppsModel.get_page_count()
            Rectangle {
                width: 8; height: 8; radius: 4 //12,12,6
                color: "#88ffffff"
                border { width: 1; color: currentIndex === index ? "#ffffffff" : "#11000000" }
            }
        }
    }
    InstallArea{
        id: installArea
        x: (root.width-width)/2
        y: (root.height-height)/2

    }
    MessageDialog {
        id: errorMsg
        width: 600
        height: 300
        visible:false
        title: "Error!"
        icon: StandardIcon.Warning
        text: "No Internet Connection is Available"
        onAccepted: Qt.quit()
    }
    Component.onCompleted: {
        // check if error occured, if so quit app
    }
}
