import QtQuick 2.0

Rectangle {
    id: rowItem
    width: 0 //root.width
    height:0 // root.height - statusBar.height - navigationBar.height
    color: "transparent"
    property int page:0
    GridView{
       anchors.leftMargin: 36 // 42-6 for text
       anchors.rightMargin: 8
       anchors.topMargin: 23
       anchors.bottomMargin: 17 //23-6px for text area
       anchors.fill: parent
       cellHeight: 130
       cellWidth: 126
       interactive: false
       focus: true
       clip:true

       boundsBehavior: Flickable.StopAtBounds

       model: GridListModel{
           id: listModel
       }

      delegate: AppDelegate{

       }
   }
   function reload()
   {
       listModel.reload();
   }
}

