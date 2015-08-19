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

    Q_INVOKABLE bool initiateFilesystemEncryption(QString filesystempath, QString password, bool encryptFileNamesToo);
    Q_INVOKABLE bool initiateFilesystemDecryption(QString filesystempath, QString password);
    Q_INVOKABLE bool unmountFS(QString filesystemPath);

    Q_INVOKABLE QString getLocalFilePath(QString fileurl);
    bool saveFilePathPasswordPair(QString filepath, QString password);
    bool checkFilePathPasswordPair(QString filepath, QString password);

    bool saveFilesystemPathPasswordSig(QString filesystempath, QString password, QString sig);
    bool checkFilesystemPathPasswordPair(QString filesystempath, QString password, QString& sig);
    QString getSignatureFromPassword(QString password);

    static bool copyRecursively(const QString &srcFilePath,
                                const QString &tgtFilePath);
    void clearDir( const QString path );

signals:

public slots:
};

#endif // ENCDECHANDLER_H
