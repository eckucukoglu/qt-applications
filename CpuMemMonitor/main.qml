import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.3
import FileIO 1.0


ApplicationWindow {
    title: qsTr("CPU and RAM Monitor")
    width: 1024
    height: 600
    visible: true


    RamMonitor{
        id: ramMonitor
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left

    }

    Rectangle{
        id: border1
        width: parent.width
        height: 1
        color: "black"
        anchors.top: ramMonitor.bottom
    }

    CpuMonitor{
        id: cpuMonitor
        anchors.top: border1.bottom
        anchors.right: parent.right
        anchors.left: parent.left

    }

    Rectangle{
        id: border2
        width: parent.width
        height: 1
        color: "black"
        anchors.top: cpuMonitor.bottom
    }

    Processes{
        id:processes
        width: parent.width
        anchors.top: border2.bottom
        anchors.bottom: parent.bottom
    }

    Item{
        id: logic
        FileIO{
            id: meminfoFile
            source: "/proc/meminfo"
            onError: console.log(msg)
        }

        FileIO{
            id: procstatFile
            source: "/proc/stat"
            onError: console.log(msg)
        }

        function getOverallRamStats(){ //n=1 for total, n=3 for free memory
            var content = meminfoFile.read();
            var splitted = content.split("\n");
            var ramTotalStat = splitted[0].split(/\s+/);
            var ramFreeStat = splitted[1].split(/\s+/);
            var ramBufferStat = splitted[3].split(/\s+/);
            var ramCachedStat = splitted[4].split(/\s+/);

            //Refresh the RamBar
            var total = parseInt(ramTotalStat[1])
            var free = parseInt(ramFreeStat[1])
            var cached = parseInt(ramCachedStat[1])
            var buffered = parseInt(ramBufferStat[1])
            var used = total - (free + cached + buffered)

            ramMonitor.ramBar.maximumValue = total;
            ramMonitor.ramBar.value = used;
            ramMonitor.ramPercentage.text = (ramMonitor.ramBar.value / ramMonitor.ramBar.maximumValue * 100).toFixed(2) + " %";

            var KILO_CONSTANT = 1024;
            ramMonitor.usedFreeTotalRow.totalRam = (total / KILO_CONSTANT).toFixed();
            ramMonitor.usedFreeTotalRow.usedRam = (ramMonitor.ramBar.value / KILO_CONSTANT).toFixed();
            ramMonitor.usedFreeTotalRow.freeRam = ramMonitor.usedFreeTotalRow.totalRam - ramMonitor.usedFreeTotalRow.usedRam


        }


        //Variables for cpu stats
        property int prevtotal0:0
        property int total0:0
        property int prevtotal1:0
        property int total1:0
        property int previdle0:0
        property int idle0:0
        property int previdle1:0
        property int idle1:0

        function getOverallCpuStats(){
            //Works for two cpus (cpu0 and cpu1 only)

            //Assign old values to prev. totals
            logic.prevtotal0 = logic.total0;
            logic.previdle0 = logic.idle0;
            logic.prevtotal1 = logic.total1;
            logic.previdle1 = logic.idle1;

            var content = procstatFile.read();
            var lines = content.split('\n');
            var cpu0stats = lines[1].split(" ");
            var cpu1stats = lines[2].split(" ");

            //Getting idle0 and idle1 values:
            logic.idle0 = parseInt(cpu0stats[4]);
            logic.idle1 = parseInt(cpu1stats[4]);

            //calculate total:
            logic.total0 = 0
            logic.total1 = 0
            for(var i = 1; i < 8; i++){
                logic.total0 += parseInt(cpu0stats[i])
                logic.total1 += parseInt(cpu1stats[i])
            }

            //Calculate the differences, then percentage of cpu working
            var cpu0PercentageWorking = ((logic.total0 - logic.prevtotal0) - (logic.idle0 - logic.previdle0)) / (logic.total0 - logic.prevtotal0)
            var cpu1PercentageWorking = ((logic.total1 - logic.prevtotal1) - (logic.idle1 - logic.previdle1)) / (logic.total1 - logic.prevtotal1)

            cpuMonitor.cpu0percentage.text = (cpu0PercentageWorking * 100).toFixed(2) + " %"
            cpuMonitor.cpu1percentage.text = (cpu1PercentageWorking * 100).toFixed(2) + " %"
            cpuMonitor.cpu0progressBar.value = cpu0PercentageWorking
            cpuMonitor.cpu1progressBar.value = cpu1PercentageWorking

        }

        Component.onCompleted: {getOverallRamStats(); getOverallCpuStats();
                        createProcessFiles() }



        function createProcessFiles(){
            var procList = [];
            var workingDir = "/proc/";


            var newStatFile = createProcessFile(1);
            procList.push(newStatFile)

            newStatFile = createProcessFile(2);
            procList.push(newStatFile)

            console.log(procList[0].source)
            console.log(procList[0].ID)
        }

        function createProcessFile(pid){
            //Creates the new process file with given pid (which is also folder name in /proc/)
            var newProcessStatFile = Qt.createQmlObject('import QtQuick 2.0;
                    import FileIO 1.0;
                    FileIO{ id: proc'+ pid +';
                    source: "/proc/'+ pid + '/stat";
                    onError: console.log(msg)}', logic);

            return newProcessStatFile;
        }

        Timer{
            id:refresher
            interval: 1000
            running: true
            repeat: true

            onTriggered: {
                parent.getOverallRamStats(); parent.getOverallCpuStats()
            }
        }
    }
}
