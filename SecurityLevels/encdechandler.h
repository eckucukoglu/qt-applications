#ifndef ENCDECHANDLER_H
#define ENCDECHANDLER_H

#include <QObject>
#include <QtCore>

class EncDecHandler : public QObject
{
    Q_OBJECT
public:
    explicit EncDecHandler(QObject *parent = 0);

    Q_INVOKABLE bool initiateFileEncryption(QString filepath, QString password);
    Q_INVOKABLE bool initiateFileDecryption(QString filepath, QString password);
    Q_INVOKABLE QString getLocalFilePath(QString fileurl);
    Q_INVOKABLE bool saveFilePathPasswordPair(QString filepath, QString password);
    Q_INVOKABLE bool checkFilePathPasswordPair(QString filepath, QString password);

signals:

public slots:
};

#endif // ENCDECHANDLER_H
