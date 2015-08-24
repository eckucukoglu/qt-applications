#ifndef NETWORKHANDLER_H
#define NETWORKHANDLER_H

#include <QObject>
#include <QtNetwork>

class NetworkHandler : public QObject
{
    Q_OBJECT
public:
    explicit NetworkHandler(QObject *parent = 0);

    Q_INVOKABLE QString getMACAddress(QString ifaceName);
    Q_INVOKABLE QString getIP(QString ifaceName);
    Q_INVOKABLE QString getNetmask(QString ifaceName);

signals:

public slots:

private:
    QNetworkInterface interfaces;
    QList<QNetworkInterface> list;
};

#endif // NETWORKHANDLER_H
