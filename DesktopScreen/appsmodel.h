#ifndef APPSMODEL_H
#define APPSMODEL_H
#include <QObject>
#include <QList>
#include <QMap>
#include <QString>
#include <QVariant>
#define MAX_NUMBER_APPLICATIONS 50

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
   Q_INVOKABLE void query_runapp(char* param);
   Q_INVOKABLE int run(int argc, char* argv[]);
   Q_INVOKABLE void run_app(int index);

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


};

#endif // APPSMODEL_H
