#include "networkhandler.h"

NetworkHandler::NetworkHandler(QObject *parent) : QObject(parent)
{
    list = interfaces.allInterfaces();
}

QString NetworkHandler::getMACAddress(QString ifaceName){


    QString interfaceName = (ifaceName.toLower() == "ethernet") ? "eth0" : ((ifaceName.toLower() == "wireless") ? "wlan0" : "invalid");

    if(interfaceName != "invalid"){
        foreach(QNetworkInterface i, list){
            if(i.name().startsWith(interfaceName))
                return i.hardwareAddress();
        }
    }
    return "HH:HH:HH:HH:HH:HH";
}

QString NetworkHandler::getIP(QString ifaceName){

    QString interfaceName = (ifaceName.toLower() == "ethernet") ? "eth0" : ((ifaceName.toLower() == "wireless") ? "wlan0" : "invalid");

    if(interfaceName != "invalid"){
        foreach(QNetworkInterface i, list){
            if(i.name().startsWith(interfaceName)){
                QList<QNetworkAddressEntry> entries = i.addressEntries();
                QNetworkAddressEntry entry = entries.first();
                return entry.ip().toString();
            }
        }
    }
    return "";
}

QString NetworkHandler::getNetmask(QString ifaceName){

    QString interfaceName = (ifaceName.toLower() == "ethernet") ? "eth0" : ((ifaceName.toLower() == "wireless") ? "wlan0" : "invalid");

    if(interfaceName != "invalid"){
        foreach(QNetworkInterface i, list){
            if(i.name().startsWith(interfaceName)){
                QList<QNetworkAddressEntry> entries = i.addressEntries();
                QNetworkAddressEntry entry = entries.first();
                return entry.netmask().toString();
            }
        }
    }
    return "";
}
