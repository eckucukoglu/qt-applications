#include "appsmodel.h"

AppsModel::AppsModel(QObject *parent) : QObject(parent)
{
    //read list, assign to elementsList

     current_index=0;
     page_index=0;
     number_of_applications=20;
     page_count=ceil(double(number_of_applications)/18);

    // TODO: clear this part
    application _list[number_of_applications];
    for(int i=0;i<number_of_applications;i++){
        application temp{
                i,
               "BEKOPOS",
               "developer",
               "pics/sober_newspecs/icon/icon_bekopos.png",
               "lightblue"
        };
        _list[i] = temp;
    }
    set_element_list(_list);
}

void AppsModel::set_element_list(application _list[]){
    QVariantList _list1;
    for(int i=0; i<number_of_applications;i++)
    {
        QVariant _data;
        QVariantMap _map;
        _map["prettyname"] = QVariant(_list[i].prettyname);
        _map["devName"] = QVariant(_list[i].devName);
        _map["iconpath"] = QVariant(_list[i].iconpath);
        _map["color"] = QVariant(_list[i].color);
        _map["id"] = QVariant(_list[i].id);
        _data = QVariant(_map);
        _list1.append(_data);
    }

    appList = QVariant(_list1);
    set_page_count();
}

QVariant AppsModel::get_element_list()
{
   return appList;
}

int AppsModel::get_current_index()
{
   return current_index;
}
void AppsModel::set_current_index(int index)
{
   current_index = index;
}
int AppsModel::get_page_index()
{
    return page_index;
}
void AppsModel::set_page_index(int index)
{
    page_index= index;
}

int AppsModel::get_number_of_applications()
{
    return number_of_applications;
}
int AppsModel::get_applist()
{
    return APPLIST[1].id;
}

void AppsModel::set_page_count()
{
    page_count = ceil(double(number_of_applications)/18);
}
int AppsModel::get_page_count()
{
    return page_count;
}
