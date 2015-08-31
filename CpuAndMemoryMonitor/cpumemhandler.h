#ifndef CPUMEMHANDLER_H
#define CPUMEMHANDLER_H

#include <QObject>
#include <QFile>
#include <QtCore>

class CpuMemHandler : public QObject
{
    Q_OBJECT
public:
    explicit CpuMemHandler(QObject *parent = 0);

    Q_INVOKABLE int getNumberOfCpus();
    Q_INVOKABLE void getRamStats(int& total, int& used);
    Q_INVOKABLE double getRamPercentage();
    Q_INVOKABLE int getTotalRam();

signals:

public slots:

private:
    int numberOfCpus;
};

#endif // CPUMEMHANDLER_H
