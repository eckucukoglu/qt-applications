#ifndef APPSMODEL_H
#define APPSMODEL_H
#include <QObject>
#include <QList>
#include <QMap>
#include <QString>
#include <QVariant>
#include <dbus/dbus.h>

#define MAX_NUMBER_APPLICATIONS 50
#define APPMAN_VIEW_DEBUG_PREFIX "V >> "

typedef struct application {
    unsigned int id;
    char* prettyname;
    char* iconpath;
    char* color;
} application;



class AppsModel: public QObject
{
    Q_OBJECT
public:
   explicit AppsModel(QObject *parent = 0);
   //~AppsModel();
  // Q_INVOKABLE QVariantList<QVariantMap> appList; //store app info
   Q_INVOKABLE QVariant appList;
   Q_INVOKABLE QVariant get_element_list();
   Q_INVOKABLE void set_element_list(application list[]);
   Q_INVOKABLE void query_listapps();
   Q_INVOKABLE void query_runapp(int param);
   Q_INVOKABLE bool is_active();
   Q_INVOKABLE void set_is_active(bool _value);
   Q_INVOKABLE void assert_dbus_method_return (DBusMessage* msg);



   Q_INVOKABLE int get_current_index();
   Q_INVOKABLE void set_current_index(int index);
   Q_INVOKABLE int get_page_index();
   Q_INVOKABLE void set_page_index(int index);
   Q_INVOKABLE int get_number_of_applications();
   Q_INVOKABLE int get_applist();
   Q_INVOKABLE void set_page_count();
   Q_INVOKABLE int get_page_count();
   application APPLIST[MAX_NUMBER_APPLICATIONS];

private: 
    int current_index;
    int page_index;
    int number_of_applications;
    int page_count;
    bool _isActive;

};

#endif // APPSMODEL_H
