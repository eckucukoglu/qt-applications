#include "cpumemhandler.h"

CpuMemHandler::CpuMemHandler(QObject *parent) : QObject(parent)
{

    numberOfCpus = getNumberOfCpus();
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

//QStringList getCpuPercentages(QStringList& oldCpuValues){
//    QFile f("/proc/stat");
//    if(!f.open(QIODevice::ReadOnly | QIODevice::Text)){
//        qDebug() << "error when opening /proc/meminfo";
//        return;
//    }

//    QTextStream in(&f);
//    QString content = in.readAll();
//    f.close();
//    QStringList lines = content.split("\n");
//    QStringList currentLine;
//    for(int i = 1; i <= numberOfCpus; i++){
//        currentLine = lines[i].split(" ");

//    }

//    lines[0].split(" ")[]

//}
