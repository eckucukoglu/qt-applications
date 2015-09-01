#include "cpumemhandler.h"

CpuMemHandler::CpuMemHandler(QObject *parent) : QObject(parent)
{

    numberOfCpus = getNumberOfCpus();

    oldCpuTotals = new int[numberOfCpus +1];
    oldCpuIdles = new int[numberOfCpus +1];
    cpuTotals = new int[numberOfCpus +1];
    cpuIdles = new int[numberOfCpus+ 1];

    for(int i = 0; i <= numberOfCpus; i++){
        oldCpuIdles[i] = 0;
        oldCpuTotals[i] = 0;
        cpuIdles[i] = 0;
        cpuTotals[i] = 0;
    }
}

int CpuMemHandler::getNumberOfCpus(){
    int processorCount = 0;
    QFile f("/proc/cpuinfo");
    if(!f.open(QIODevice::ReadOnly | QIODevice::Text)){
        qDebug() << "error when opening /proc/cpuinfo";
        return -1;
    }
    QTextStream in(&f);
    QString content = in.readAll();
    f.close();
    QStringList lines = content.split("\n");

    foreach(QString line, lines){
        if(line.contains("processor"))
            processorCount++;
    }

    return processorCount;
}

void CpuMemHandler::getRamStats(int& total, int& used){
    QFile f("/proc/meminfo");
    if(!f.open(QIODevice::ReadOnly | QIODevice::Text)){
        qDebug() << "error when opening /proc/meminfo";
        return;
    }

    int free, buffer, cached;
    QTextStream in(&f);
    QString content = in.readAll();
    QStringList lines = content.split("\n");
    f.close();
    total = lines[0].split(QRegExp("\\s+"))[1].toInt();
    free = lines[1].split(QRegExp("\\s+"))[1].toInt();
    buffer = lines[3].split(QRegExp("\\s+"))[1].toInt();
    cached = lines[4].split(QRegExp("\\s+"))[1].toInt();

    used = total - (free + buffer + cached);
    total = total / 1024;
    used = used / 1024;
}

int CpuMemHandler::getTotalRam(){
    int total;
    QFile f("/proc/meminfo");
    if(!f.open(QIODevice::ReadOnly | QIODevice::Text)){
        qDebug() << "error when opening /proc/meminfo";
        return 0;
    }
    QTextStream in(&f);
    QString content = in.readAll();
    QStringList lines = content.split("\n");
    f.close();
    total = lines[0].split(QRegExp("\\s+"))[1].toInt();
    return total / 1024;
}

double CpuMemHandler::getRamPercentage(){
    int total, used;
    getRamStats(total, used);
    return (double)used / total;
}

void CpuMemHandler::updateCpuValues(){
    QFile f("/proc/stat");
    if(!f.open(QIODevice::ReadOnly | QIODevice::Text)){
        qDebug() << "error when opening /proc/stat";
        return;
    }


    QTextStream in(&f);
    QString content = in.readAll();

    f.close();

    //Assign last values to previous total and idles
    for(int i= 0; i < numberOfCpus; i++){
        oldCpuTotals[i] = cpuTotals[i];
        oldCpuIdles[i] = cpuIdles[i];
    }

    QStringList lines = content.split("\n");    //all lines of the stat file.
    QStringList currentLine;
    for(int i = 0; i <= numberOfCpus; i++){
        int currentTotalCount = 0;
        //current line has idle value in 5th value (4th index).
        currentLine = lines[i].split(QRegExp("\\s+"));

        //skip the 0th index since it's the name of the cpu
        //calculate total
        for(int k = 1; k <= 10; k++){

            currentTotalCount += currentLine[k].toInt();
        }
        //get idle value
        cpuIdles[i] = currentLine[4].toInt();
        cpuTotals[i] = currentTotalCount;
    }
}

double CpuMemHandler::getCpuPercentage(int i){
    //i is the element no in the /proc/stat file.
    //i=0 is for total, from 1.....n is for respective cpus.

    double cpuPercentage = (((double)cpuTotals[i] - oldCpuTotals[i]) - (cpuIdles[i] - oldCpuIdles[i])) / (cpuTotals[i] - oldCpuTotals[i]);
    return cpuPercentage;
}

QString CpuMemHandler::readAllStatFiles(){
    QString allStatsString = "";
    QDir procDir("/proc/");
    procDir.setFilter(QDir::Dirs | QDir::NoDotAndDotDot | QDir::NoSymLinks);
    QDirIterator di(procDir);

    //This loop will traverse all the directories in /proc
    while(di.hasNext()){
        QString currentDir = di.next();

        //Check if there is a stat file
        if(QFile::exists(currentDir + "/stat"))
        {
            QFile statusFile(currentDir + "/status");

            //open the statusfile
            if (!statusFile.open(QIODevice::ReadOnly | QIODevice::Text))
            {
                qDebug() << "Could not open " + statusFile.fileName();
                qDebug() << statusFile.errorString();
                return "";
            }

            QTextStream in(&statusFile);
            QString contentOfStatusFile = in.readAll();

            //qDebug() << contentOfStatusFile;
            QStringList entries = contentOfStatusFile.split("\n");
            QStringList nameEntry,pidEntry, memEntry;

            foreach(QString line, entries){
                if(line.startsWith("Name:"))
                     nameEntry = line.split("\t");
                else if(line.startsWith("Pid:"))
                    pidEntry = line.split("\t");
                else if (line.startsWith("VmRSS:"))
                    memEntry = line.split("\t");
            }

            statusFile.close();

            if(nameEntry.size() != 0 && memEntry.size() != 0 )
                allStatsString += nameEntry[1].trimmed() + " "  + memEntry[1].trimmed() + " " + pidEntry[1].trimmed() + "\n";

        }
    }//endwhile
    allStatsString.chop(1); //last empty line is deleted.
    //qDebug() << allStatsString;

    return allStatsString;
}

QString CpuMemHandler::tryToKillProcess(QString pid){
    QProcess process;
    qDebug() << "kill " + pid;
    process.start("kill  " + pid);

    if(!process.waitForFinished()){
        qDebug() << "error! " << process.errorString();
        return process.errorString();
    }
    else{
        qDebug() << "done!";
        return "The process "+ pid + " have been killed succesfully.";
    }
}
