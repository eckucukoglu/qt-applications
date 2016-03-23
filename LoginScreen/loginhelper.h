#ifndef LOGINHELPER_H
#define LOGINHELPER_H
#include <QObject>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <dbus/dbus.h>
#include <fstream>
#include <iostream>


typedef enum{
    LOGINHELPER_RET_ERROR = -1,
    LOGINHELPER_RET_OK = 0,
}LOGINHELPER_ERR_TYPE;

#define APPMAN_VIEW_DEBUG_PREFIX "L >> "
using namespace std;
class LoginHelper: public QObject
{
    Q_OBJECT
public:
   explicit LoginHelper(QObject *parent = 0);

    Q_INVOKABLE bool check_password(QString pwd,bool _isShamir);
    Q_INVOKABLE void query_login(int access_code);
    Q_INVOKABLE int set_tryCount(int tryCount);
    Q_INVOKABLE int get_tryCount();
    Q_INVOKABLE bool initDisc(QString password, bool _isShamir);
    Q_INVOKABLE void resetDisc();
    Q_INVOKABLE int set_initMode(int initMode, bool isShamir);
    Q_INVOKABLE int get_initMode();
    Q_INVOKABLE int get_isShamir();

private:
    bool isShamir;

};


#endif // LOGINHELPER_H
