#include "loginhelper.h"

LoginHelper::LoginHelper(QObject *parent) : QObject(parent)
{
    pwd = "xxx";
}

void LoginHelper::set_password(QString password, bool _isShamir){
    pwd = new char[password.length() + 1];
    strcpy(pwd, password.toStdString().c_str());
    isShamir = _isShamir;
    if(isShamir)
    {
        printf("with shamir\n");

    }
    else
    {
        printf("without shamir\n");
    }

}

QString LoginHelper::test_method(){
    QString value = QString(pwd);
    return value;
}
