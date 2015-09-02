import QtQuick 2.0
import QtQuick.Controls 1.4
import CpuMemHandler 1.0

Item{
    property int numberOfCpus: cpuMemHandler.getNumberOfCpus();
    property var cpuColors: ["#fce7c2", "#f68d76", "#679911", "#f17711", "#42aa48", "#d64222", "#229977", "#1caaee"]
    property double ramPerc
    property int totalRam
    property var cpuPercentages: []
    property var cpuPercentagesHumanReadable: []


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
                    value: cpuPercentages[0]
                    text: "CPU Usage"
                    fillColor: "#80808f"
                    progressBarText: "0 %"
                    bgText: "100 %"
                    progressBarRightMargin: 3
                }

                Repeater{
                    id: cpus
                    model:numberOfCpus
                    CustomProgressBar{
                        width: 200
                        height: 20
                        value: cpuPercentages[index + 1]
                        text: "Core " + index
                        fillColor: cpuColors[index % cpuColors.length]
                        progressBarRightMargin: 3
                        progressBarText: "0 %"
                        bgText: "100 %"
                    }
                }

                CustomProgressBar{
                    id:deviceMemory
                    width: 200
                    height: 20
                    value: ramPerc
                    text: "Device Memory"
                    fillColor: "#04caad"
                    progressBarText: (totalRam * ramPerc).toFixed()  + " MB"
                    bgText: (totalRam - totalRam * ramPerc).toFixed() + " MB"
                    progressBarRightMargin: 3
                }

                Processes{
                    id: processes
                    width: 200
                }
            }
        }
    }

    function refreshCpuAndRamValues(){
        //Get ram percentage and update ram progress bar
        ramPerc = cpuMemHandler.getRamPercentage();
        console.log(ramPerc)
        deviceMemory.value = ramPerc

        //update total percentage
        cpuPercentages[0] = cpuMemHandler.getCpuPercentage(0);
        cpuPercentagesHumanReadable[0] = (cpuPercentages[0] * 100).toFixed(0);
        totalCpuUsage.value = cpuPercentages[0];

        //update cpu percentages
        for(var i = 1; i <= numberOfCpus; i++){
            cpuPercentages[i] = cpuMemHandler.getCpuPercentage(i);
            cpuPercentagesHumanReadable[i] = (cpuPercentages[i] * 100).toFixed(0);
            cpus.itemAt(i-1).value = cpuPercentages[i];
        }

        //refresh the progress bar texts:
        //if the value is below 6%, don't write it down to the progress bar since it won't be seen
        totalCpuUsage.progressBarText = (cpuPercentagesHumanReadable[0] < 6) ? "" : (cpuPercentagesHumanReadable[0]   + " %");
        totalCpuUsage.bgText = (100 - cpuPercentagesHumanReadable[0]) + " %"
        for(var l = 1; l <= numberOfCpus; l++){
            cpus.itemAt(l - 1).progressBarText = (cpuPercentagesHumanReadable[l] < 6) ? "" : (cpuPercentagesHumanReadable[l]   + " %");
            cpus.itemAt(l - 1).bgText = (100 - cpuPercentagesHumanReadable[l]) + " %"
        }
    }

    Component.onCompleted: {
        //******************************************
        //update cpu values
        //******************************************
        cpuMemHandler.updateCpuValues();
        for(var j = 0; j <= numberOfCpus; j++){
            cpuPercentages.push(cpuMemHandler.getCpuPercentage(j));
            cpuPercentagesHumanReadable.push((cpuPercentages[j] * 100).toFixed(0));
        }

        //initially, the values of the cpus are all zeroes.
        totalCpuUsage.value = 0;
        for(var i = 0; i < numberOfCpus; i++){
            cpus.itemAt(i).value = 0;
        }

        //******************************************
        //update ram values
        //******************************************
        totalRam = cpuMemHandler.getTotalRam();
        console.log(totalRam)
        refreshCpuAndRamValues();
    }


    Timer{
        id:refresher
        interval: 3000
        running: true
        repeat: true

        onTriggered: {
            cpuMemHandler.updateCpuValues();
            refreshCpuAndRamValues();   //LEAKY FUNCTION.....
        }
    }
}
