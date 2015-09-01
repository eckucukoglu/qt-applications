import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.3
import CpuMemHandler 1.0

Item{
    anchors.right: parent.right
    anchors.left: parent.left
    width: 200
    height: processListView.height

    Item{
        id: titleContainer
        width: parent.width
        height: 30

        SoberText{
            width: parent.width
            anchors.top: parent.top
            id: title
            font.pixelSize: 20
            height: 20
            color: "#04caad"
            text: "Processes"
        }

    }

    ListView{
        id: processListView
        anchors.top: titleContainer.bottom
        anchors.topMargin: 10
        spacing: 10
        height: count * 55  //height of the view element is (number of items in it) * (one item delegate's height + spacing)

        delegate: ProcessDelegate{
                }
        model: processListModel
    }

    ListModel{
        id: processListModel
    }


    Component.onCompleted: {
        updateProcessesList();

    }

    function updateProcessesList(){
        var statsString = cpuMemHandler.readAllStatFiles().split("\n");
        var name, mem, pid;

        //processListView.selection.clear();
        processListModel.clear();

        var memHumanReadable
        var processEntry

        for(var i = 0; i < statsString.length; i++){
            processEntry = statsString[i].split(" ")

            name = processEntry[0]
            mem = parseInt(processEntry[1])
            pid = parseInt(processEntry[3])
            console.log(processEntry)

            if(mem < 1024){
                memHumanReadable = mem + " KB"
            }
            else{
                memHumanReadable = ((mem / 1024).toFixed(2)) + " MB"
            }

            //now add this entry to our model
            processListModel.insert(0, {name: name, memory: memHumanReadable, pid: pid})
        }

        processListView.update()
    }

    CpuMemHandler{
        id:cpuMemHandler
    }
}
