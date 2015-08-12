#include "selinuxhandler.h"

SELinuxHandler::SELinuxHandler(QObject *parent) : QObject(parent)
{

}

void SELinuxHandler::setEnforced(){

}

void SELinuxHandler::getStatus(){
    //QString res = security_getenforce();
    qDebug() << "hello";
    int a = security_getenforce();
    qDebug() << a;
}
