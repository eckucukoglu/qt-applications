#ifndef APPSMODEL_H
#define APPSMODEL_H
#define MAX_NUMBER_APPLICATIONS 50
#define APPMAN_VIEW_DEBUG_PREFIX "V >> "
#define DBUS_API_SUBJECT_TO_CHANGE

#include <QObject>
#include <QList>
#include <QMap>
#include <QString>
#include <QVariant>
#include <dbus/dbus.h>
#include <stdbool.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef struct application {
    unsigned int id;
    char* prettyname;
    char* devName;
    char* iconpath;
    char* color;
} application;

class AppsModel: public QObject
{
    Q_OBJECT
public:
    explicit AppsModel(QObject *parent = 0);
    Q_INVOKABLE QVariant get_element_list();
    Q_INVOKABLE void set_element_list(application list[]);
    Q_INVOKABLE int get_current_index();
    Q_INVOKABLE void set_current_index(int index);
    Q_INVOKABLE int get_page_index();
    Q_INVOKABLE void set_page_index(int index);
    Q_INVOKABLE int get_number_of_applications();
    Q_INVOKABLE int get_applist();
    Q_INVOKABLE void set_page_count();
    Q_INVOKABLE int get_page_count();

 private:
     int current_index;
     int page_index;
     int number_of_applications;
     int page_count;
     application APPLIST[MAX_NUMBER_APPLICATIONS];
     Q_INVOKABLE QVariant appList;
};

#endif // APPSMODEL_H
