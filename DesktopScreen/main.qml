import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    title: qsTr("Desktop Screen")
    width: 1024
    height: 600
    visible: true
    id: root

    property int numberOfPages: 2
    property int currentIndex: 0

    function getNumberOfPages(){
        //here in this function, write the logic for the number of pages
        //that will be displayed in the main screen of sober.
        // then you can replace the property above to assign numberOfPages value by this fnc

        return numOfPages
    }

    onCurrentIndexChanged: {
        slide_anim.to = - root.width * currentIndex
        slide_anim.start()
        slide_anim.alwaysRunToEnd = true
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
        source: "pics/sober_newspecs/bg.png"
        fillMode: Image.PreserveAspectCrop
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

            console.log("swipe.")
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


    Item{
        id:content
        width: root.width * numberOfPages
        height: root.height - statusBar.height - navigationBar.height
        anchors.top: statusBar.bottom
        anchors.bottom: navigationBar.top
        //anchors.left: parent.left

        Rectangle{
            id: grids
            anchors.fill: parent
            anchors.leftMargin: 52
            anchors.topMargin: 16
            anchors.bottomMargin: 34
            color: "transparent"

            GridView{
                id:grid1


                height: parent.height
                width: parent.width / numberOfPages - 25

                cellHeight: 156
                cellWidth: 162

                interactive: false

                boundsBehavior: Flickable.StopAtBounds
                //snapMode: GridView.SnapOneRow

                model: MenuModel {
                    id:menuModel
                }
                delegate: AppDelegate{
                }

                focus: true
                clip:true

            }

            GridView{
                id:grid2
                anchors.left: grid1.right
                anchors.leftMargin: 52

                height: parent.height
                width: parent.width / numberOfPages

                x: parent.width

                cellHeight: 156
                cellWidth: 162

                interactive: false

                boundsBehavior: Flickable.StopAtBounds
                snapMode: GridView.SnapOneRow

                model: Menu2Model{
                    id:menu2Model
                }

                delegate: AppDelegate{
                }

                //focus: true
                clip:true
            }

            //THIS REPEATER WILL BE USED IN CASE OF DYNAMICALLY ALLOCATING THE MENU

//            Repeater{
//                id: gridList
//                model: numberOfPages

//                GridView{
//                    height: parent.height
//                    width: parent.width / numberOfPages - 25

//                    cellHeight: 156
//                    cellWidth: 162

//                    interactive: false
//                    clip:true

//                    boundsBehavior: Flickable.StopAtBounds

//                    model: MenuModel{

//                    }

//                    delegate: AppDelegate{

//                    }
//                }
//            }

        }

        function fillGrids(){
            //this function can be used to dynamically fill the grids.
            //a text file can be read here to populate gridList's grids.
            //the individual grids can be reached by: gridList.itemAt(i).

            //in this function, you must fill the grids according to the number of elements
            //per page. For instance, you should pass to the next grid for each 18 elements etc.

            //uncomment the repeater above and delete the previously existing grids.
            //call this function when Component.onCompleted to populate the grids.
            //the anchors of the grids in gridList must be set accordingly.
        }

    }



    //Dots row
    Row {
        id: dotsRow
        anchors { bottom: parent.bottom; bottomMargin: 58; horizontalCenter: parent.horizontalCenter }
        spacing: 6
        Repeater {
            model: numberOfPages
            Rectangle {
                width: 12; height: 12; radius: 6
                color: currentIndex === index ? "#88ffffff" : "#88000000"
                border { width: 2; color: currentIndex === index ? "#33ffffff" : "#11000000" }
            }
        }
    }

    //StatusBar and NavigationBar should be commented out if
    //they will be run as separate applications.

    //StatusBar
    StatusBarTop{
        id:statusBar

    }

    //BottomBar
    NavigationBar{
        id:navigationBar
    }

    Component.onCompleted: {
        // fillGrids();
    }


}
