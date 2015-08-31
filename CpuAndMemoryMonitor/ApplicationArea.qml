import QtQuick 2.0
import QtQuick.Controls 1.4
import CpuMemHandler 1.0

Item{
    property int numberOfCpus: cpuMemHandler.getNumberOfCpus();

    property var oldCpuTotals: []
    property var cpuTotals: []
    property var oldCpuIdles: []
    property var cpuIdles: []
    property var cpuPercentages: []
    property var cpuColors: ["#fce7c2", "#f68d76", "#679911", "#f17711", "#2366ee", "#d64222", "#229977", "#1caaee"]
    property double ramPerc
    property double totalRam


    CpuMemHandler{
        id:cpuMemHandler
    }

    anchors.fill: parent

    Rectangle{
        anchors.fill: parent
        color: "#444347"

        Flickable{
            x:390
            y:70
            width: 577
            height: 480
            contentWidth: contentColumn.width
            contentHeight: contentColumn.height
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.OvershootBounds

            Column{
                id: contentColumn
                spacing: 50

                CustomProgressBar{
                    id:totalCpuUsage
                    width: 200
                    height: 20
                    value: 0.3
                    text: "CPU Usage"
                    fillColor: "#80808f"
                    progressBarText: "5%"
                    bgText: "95%"
                    progressBarRightMargin: 40
                }

                Repeater{
                    id: cpus
                    model:numberOfCpus
                    CustomProgressBar{
                        width: 200
                        height: 20
                        value: 0.3
                        text: "Core " + index
                        fillColor: cpuColors[index % cpuColors.length]
                        progressBarRightMargin: 40
                    }
                }

                CustomProgressBar{
                    id:deviceMemory
                    width: 200
                    height: 20
                    value: 0.3
                    text: "Device Memory"
                    fillColor: "#04caad"
                    progressBarText: (totalRam * ramPerc) + " MB"
                    bgText: (totalRam - totalRam * ramPerc) + " MB"
                    progressBarRightMargin: 70
                }
            }
        }
    }

    function refreshCpuAndRamValues(){
        //Get ram percntage and update ram progress bar
        ramPerc = cpuMemHandler.getRamPercentage();
        deviceMemory.value = ramPerc

        //update cpu percentages
        for(var i = 0; i < numberOfCpus; i++){
            cpus.itemAt(i).value = cpuPercentages[i];
        }
    }

    function getOverallCpuStats(){

    }


    Component.onCompleted: {
        totalRam = cpuMemHandler.getTotalRam();
        console.log(totalRam)
        ramPerc = cpuMemHandler.getRamPercentage();
        deviceMemory.value = ramPerc

        //******************************************
        for(var i = 0; i < numberOfCpus; i++){
            oldCpuTotals.push(0);
            oldCpuIdles.push(0);
            cpuTotals.push(0);
            cpuIdles.push(0);
            cpuPercentages.push(0);
        }
    }

    Timer{
        id:refresher
        interval: 3000
        running: true
        repeat: true

        onTriggered: {
            refreshCpuAndRamValues();
        }
    }
}
