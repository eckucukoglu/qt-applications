#include "selinuxhandler.h"
#include <QFile>

SELinuxHandler::SELinuxHandler(QObject *parent) : QObject(parent)
{

}

QString SELinuxHandler::getStatus(){
    int a = security_getenforce();
    if(a == 1)
        return "ENFORCING";
    else if (a == 0){
        return "PERMISSIVE";
    }
    else{
        return "DISABLED";
    }
}

void SELinuxHandler::setModePermanently(int num){
    QDir configDir("/etc/selinux");
    if(QFile::exists(configDir.absolutePath()+ "/config"))
    {
        QFile configFile(configDir.absolutePath()+ "/config");

        //open the config file
        if (!configFile.open(QIODevice::ReadWrite | QIODevice::Text))
        {
            qDebug() << "Could not open " + configFile.fileName();
            qDebug() << configFile.errorString();
        }
        QTextStream in(&configFile);
        QString contentOfConfigFile;
        while(!in.atEnd()){
            QString line = in.readLine();
            contentOfConfigFile.append(line + "\n");
        }

        //Now, we have the content of the config file
        qDebug() << contentOfConfigFile;

        if(num == 1){   //we will make the mode enforcing
            if(contentOfConfigFile.contains("SELINUX=permissive")){
                contentOfConfigFile.replace(QString("SELINUX=permissive"),QString("SELINUX=enforcing"));
                contentOfConfigFile = contentOfConfigFile.trimmed();
                configFile.resize(0);
                if(configFile.write(contentOfConfigFile.toUtf8()) == -1)
                    qDebug() << "error when writing into configfile";
            }
            else{
                qDebug() << "no SELINUX=permissive line found";
            }
        }
        else if(num == 0){  //we will make the mode permissive
            if(contentOfConfigFile.contains("SELINUX=enforcing")){
                contentOfConfigFile.replace(QString("SELINUX=enforcing"),QString("SELINUX=permissive"));
                contentOfConfigFile = contentOfConfigFile.trimmed();
                configFile.resize(0);
                if(configFile.write(contentOfConfigFile.toUtf8()) == -1)
                    qDebug() << "error when writing into configfile";
            }
            else{
                qDebug() << "no SELINUX=enforcing line found";
            }
        }
        else{
            qDebug() << "invalid number";
        }

        configFile.close();
    }
    else{
        qDebug() << "no file there";
    }
}

void SELinuxHandler::setTemporarilyEnforcing(){
    qDebug() << "se linux enabled? : " << is_selinux_enabled();
    qDebug() << "current enforce flag: " << security_getenforce();
    qDebug() << "now setting the mode to enforcing";


    int code = security_setenforce(1);
    if(code == 0)
        qDebug() << "done!";
    else if(code == -1)
        qDebug() << "couldnt..:(";
}

void SELinuxHandler::setTemporarilyPermissive(){
    qDebug() << "se linux enabled? : " << is_selinux_enabled();
    qDebug() << "current enforce flag: " << security_getenforce();
    qDebug() << "now setting the mode to permissive";


    int code = security_setenforce(0);
    if(code == 0)
        qDebug() << "done!";
    else if(code == -1)
        qDebug() << "couldnt..:(";
}
