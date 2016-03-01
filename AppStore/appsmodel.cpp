#include "appsmodel.h"

AppsModel::AppsModel(QObject *parent) : QObject(parent)
{
    //read list, assign to elementsList
     check_internet = false;
     current_index= 0;
     page_index=0;
     page_count=ceil(double(number_of_applications)/18);
}

int AppsModel::download(int appid)
{
    printf("APPSMODEL: now downloading app: %d\n" , appid);
    return 0;
}

void AppsModel::set_element_list(app _list[]){
    QVariantList _list1;
    for(int i=0; i<number_of_applications;i++)
    {
        QVariant _data;
        QVariantMap _map;
        _map["id"] = QVariant(_list[i].id);
        _map["name"] = QVariant(_list[i].name.c_str());
        _map["developerName"] = QVariant(_list[i].developerName.c_str());
        _map["iconName"] = QVariant(_list[i].iconName.c_str());
        _map["hashValue"] = QVariant(_list[i].hashValue.c_str());
        _map["binaryPath"] = QVariant(_list[i].binaryPath.c_str());
        _map["binaryName"] = QVariant(_list[i].binaryName.c_str());
        _map["packagePath"] = QVariant(_list[i].packagePath.c_str());
        _map["isDownloaded"] = QVariant(_list[i].isDownloaded);
        _map["isInstalled"] = QVariant(_list[i].isInstalled);
        _map["error"] = QVariant(_list[i].error);
        _map["errorCode"] = QVariant(_list[i].errorCode.c_str());
        _map["borderColor"] = QVariant(_list[i].borderColor.c_str());
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
