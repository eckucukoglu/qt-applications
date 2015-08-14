#include "encdechandler.h"
#include <QFile>

EncDecHandler::EncDecHandler(QObject *parent) : QObject(parent)
{

}

bool EncDecHandler::initiateFileEncryption(QString filepath, QString password){
    qDebug() << "Filepath: " << filepath;
    qDebug() << "Password: " << password;
    qDebug() << "ENcryption begins..";


    QFile file(filepath);

    qDebug() << file.fileName();

    QProcess process;
    saveFilePathPasswordPair(filepath, password);
    QString encryptScript = "openssl enc -aes-128-cbc -nosalt -pass pass:" + password + " -in " + filepath + " -out " + filepath + ".enc";
    qDebug() << encryptScript;
    process.execute(encryptScript);

    //now remove the original file since we have the encrypted version
    file.remove();

    if(process.exitStatus() == QProcess::NormalExit)
        return true;
    else{
        return false;
    }

}

bool EncDecHandler::initiateFileDecryption(QString filepath, QString password){
    qDebug() << "Filepath: " << filepath;
    qDebug() << "Password: " << password;
    qDebug() << "DEcryption begins..";
    QString filepathWithoutEncAtTheEnd = filepath.mid(0, filepath.length() - 4 );

    if(checkFilePathPasswordPair(filepathWithoutEncAtTheEnd, password) == false)
    {
        qDebug() << "decryption failed. wrong password.";
        return false;
    }
    else{
        QProcess process;

        QString decryptScript = "openssl enc -d -aes-128-cbc -nosalt -pass pass:" + password + " -in " + filepath + " -out " + filepathWithoutEncAtTheEnd;
        qDebug() << "decrypt script workin: " +decryptScript;
        process.execute(decryptScript);

        //now remove the .enc file since it is decrypted.
        QFile file(filepath);
        file.remove();

        if(process.exitStatus() == QProcess::NormalExit)
            return true;
        else{
            return false;
        }
    }
}

QString EncDecHandler::getLocalFilePath(QString fileurl){
    QUrl file(fileurl);
    QString localfilepath(file.toLocalFile());
    return localfilepath;
}

bool EncDecHandler::saveFilePathPasswordPair(QString filepath, QString password){
    QFile ppp("path_password_pairs");

    if(!ppp.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text)){
        qDebug() << ppp.errorString();
        return false;
    }
    else{
        QTextStream out(&ppp);
        QString lineToWrite = filepath + "\t" + password;
        out << lineToWrite << endl;

        ppp.close();
        return true;
    }
}

bool EncDecHandler::checkFilePathPasswordPair(QString filepath, QString password){
    qDebug() << "checking filepath - password pair for : " + filepath + "\t" + password;
    QFile ppp("path_password_pairs");
    QString contentOfPpp;
    QString searchedLine = filepath + "\t" + password;
    if(!ppp.open(QIODevice::ReadWrite | QIODevice::Text)){
        qDebug() << ppp.errorString();
        return false;
    }
    else{
        bool foundYet = false;
        QTextStream in(&ppp);
        contentOfPpp = "";
        while(!in.atEnd()){
            QString line = in.readLine();
            qDebug() << "now line: " + line;
            if(!line.contains(searchedLine)){
                contentOfPpp.append(line + "\n");

            }
            else{
                //We found the line we are searching for.
                //Don't add it to the new content file.
                foundYet = true;
            }
        }
        //Update the file
        ppp.resize(0);
        //contentOfPpp = contentOfPpp.trimmed();
        if(ppp.write(contentOfPpp.toUtf8()) == -1)
            qDebug() << "error when writing into path password pair file";

        return foundYet;
    }
}
