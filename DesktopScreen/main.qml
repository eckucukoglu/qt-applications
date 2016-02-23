import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2


/* iteration example
    for (var i = 0; i < column.children.length; ++i)
        column.children[i].width = column.width;
*/

ApplicationWindow {
    title: qsTr("Desktop Screen")
    width: 800//1024
    height: 480 //600
    visible: true
    id: root
    objectName:"root"

    property int numberOfPages: AppsModel.get_page_count()
    property int currentIndex: 0
    property double  t1: 0
    property double  t2: 0


    function getNumberOfPages(){
        //here in this function, write the logic for the number of pages
        //that will be displayed in the main screen of sober.
        // then you can replace the property above to assign numberOfPages value by this fnc

        /*** tugba ***/
        // total # of apps / (6 * 3)
  //      console.log("num of pages" + parseInt(listModel.pageCount))
  //      return parseInt(listModel.pageCount)
    }

    onCurrentIndexChanged: {
        slide_anim.to = - root.width * currentIndex
        slide_anim.start()
        slide_anim.alwaysRunToEnd = true
        AppsModel.set_page_index(currentIndex)
    }

    onActiveChanged: {
        //fill grids
       // print("applist: "+ AppsModel.get_applist())
       // AppsModel.get_element_list()
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
        source: "pics/sober_newspecs/bg2.jpg"
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: if (background.status === Image.Ready) console.log('Loaded')
    }

    Item {
        id:content
        anchors.top: statusBar.bottom
        anchors.bottom: navigationBar.top   
        width: root.width * 3
        Component.onCompleted: {
          //  print("Row is completed")
            var desktopGrid;
            var component;
            var i;
            for(i=0;i<3;i++)
            {
                component= Qt.createComponent("DesktopGrid.qml");
                desktopGrid = component.createObject(content, {"x":i*root.width, "width": root.width, "height": root.height - statusBar.height - navigationBar.height});
                if (desktopGrid === null) {
                // Error Handling
              //     console.log("::main> Error creating object");
                }
                else{
            //        console.log("::main>successfull")
                }
            }
         }
    }

    //StatusBar
    StatusBarTop{
        id:statusBar

    }

    //BottomBar
    NavigationBar{
        id:navigationBar
    }

    SwipeArea {
        width: root.width * numberOfPages
        height: root.height - statusBar.height - navigationBar.height
        anchors.top: statusBar.bottom
        anchors.bottom: navigationBar.top
        id:swipeArea

        onMove: {
            if((x > 0 && currentIndex != 0) || (x < 0 && currentIndex != numberOfPages-1 )){ //only when swipeable
                content.x =(-root.width * currentIndex) + x
            }
        }
        onSwipe: {
            //console.log("::main> swipe.")
            switch (direction) {
            case "left":
                if (currentIndex === numberOfPages - 1) {
                    currentIndexChanged()
                }
                else {
                    currentIndex++
                    //currentIndexChanged()
                }
                break
            case "right":
                if (currentIndex === 0) {
                    currentIndexChanged()   //realign the view
                }
                else {
                    currentIndex--          //change the index
                    //currentIndexChanged()   //then realign the view
                }
                break
            }

        }
        onCanceled: {
            currentIndexChanged()
        }
    }


    //Dots row
    Row {
        id: dotsRow
        anchors {  bottom: parent.bottom; bottomMargin: 30 ; horizontalCenter: parent.horizontalCenter }
        spacing: 10
        height: 14
        Repeater {
            model: AppsModel.get_page_count()
            Rectangle {
                width: 8; height: 8; radius: 4 //12,12,6
                color: "#88ffffff" // currentIndex === index ?"#88ffffff" : "#88000000"
                border { width: 1; color: currentIndex === index ? "#ffffffff" : "#11000000" }
            }
        }
    }

    Component.onCompleted: {
        // fillGrids();
    }

}
