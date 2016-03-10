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



#define APPMAN_VIEW_DEBUG_PREFIX "L >> "

class LoginHelper: public QObject
{
    Q_OBJECT
public:
   explicit LoginHelper(QObject *parent = 0);

    Q_INVOKABLE bool check_password(QString pwd,bool _isShamir);
    Q_INVOKABLE void query_access(int access_code);
    Q_INVOKABLE void set_tryCount(int tryCount);
    Q_INVOKABLE int get_tryCount();

private:
    bool isShamir;

};


#endif // LOGINHELPER_H
