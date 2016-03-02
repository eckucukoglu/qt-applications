#include "appsmodel.h"

AppsModel::AppsModel(QObject *parent) : QObject(parent)
{
    //read list, assign to elementsList
     check_internet = false;
     current_index= 0;
     page_index=0;
     performer = new HTTPPerform("http://10.155.10.206:8000/");
     listApps();
     page_count=ceil(double(number_of_applications)/18);
}

int AppsModel::download(int appid)
{
    int _ret=0; //return code
    try {
            _appList = performer->perform(DOWNLOAD,appid);
            if (_appList == NULL)
            {
                cout << "Applist is NULL" << endl;
            }
            else{
                if (performer->getError() == 1){
                    cout << "Error occured during HTTP request :" << performer->getErrorMessage() << endl;
                }
                else if (_appList->apps != NULL)
                {
                    check_internet=true;
                    string colours[] = {"#FC0505", "#89F0F0", "#F0E224", "#1AC44D"};
                    app _list[_appList->size];
                    for(int i=0;i< _appList->size; i++) //works for 1 app
                        {
                            cout << "Application "<< to_string(i) << endl;
                            cout << "\t" << "id: " << to_string(_appList->apps[i].id)<<endl;
                            cout << "\t" << "name: " << (_appList->apps[i].name)<<endl;
                            cout << "\t" << "developer name: " << (_appList->apps[i].developerName)<<endl;
                            cout << "\t" << "icon: " << (_appList->apps[i].iconName)<<endl;
                            app temp{
                                   _appList->apps[i].id,
                                   _appList->apps[i].name,
                                   _appList->apps[i].developerName,
                                   _appList->apps[i].iconName,
                                   _appList->apps[i].hashValue,
                                   _appList->apps[i].binaryPath,
                                   _appList->apps[i].binaryName,
                                   _appList->apps[i].packagePath,
                                   _appList->apps[i].isDownloaded,
                                   _appList->apps[i].isInstalled,
                                   _appList->apps[i].error,
                                   _appList->apps[i].errorCode,
                                   colours[i%4]
                            };
                            //TODO: do sth with temp
                        }
                        //TODO: check if download is successful
                        if(_appList->apps->isInstalled == 1 && _appList->apps->isDownloaded)
                        {
                            //TODO: update info area
                            printf("download is successful!\n");
                        }
                        else
                        {
                            //TODO: update info area
                            printf("an error occured while downloading\n");
                        }
                }
                else
                {
                    //TODO: update info area
                    cout << "Error occured: " << _appList->apps->errorCode << endl;
                }
            }
        }
        catch(exception &e)
        {
            //TODO: update info area
            cout << "Exception!:" << e.what() << endl;
        }
        return _ret;
}

void AppsModel::listApps(){
    try {
            _appList = performer->perform(SHOW,0);
            if (_appList == NULL)
            {
                cout << "Applist is NULL" << endl;
            }
            else{
                if (performer->getError() == 1){
                    cout << "Error occured during HTTP request :" << performer->getErrorMessage() << endl;

                }
                else if (_appList->apps != NULL)
                {
                    check_internet=true;
                    string colours[] = {"#FC0505", "#89F0F0", "#F0E224", "#1AC44D"};
                    number_of_applications = _appList->size;
                    app _list[_appList->size];
                    for(int i=0;i< _appList->size; i++)
                        {
                            cout << "Application "<< to_string(i) << endl;
                            cout << "\t" << "id: " << to_string(_appList->apps[i].id)<<endl;
                            cout << "\t" << "name: " << (_appList->apps[i].name)<<endl;
                            cout << "\t" << "developer name: " << (_appList->apps[i].developerName)<<endl;
                            cout << "\t" << "icon: " << (_appList->apps[i].iconName)<<endl;
                            app temp{
                                   _appList->apps[i].id,
                                   _appList->apps[i].name,
                                   _appList->apps[i].developerName,
                                   _appList->apps[i].iconName,
                                   _appList->apps[i].hashValue,
                                   _appList->apps[i].binaryPath,
                                   _appList->apps[i].binaryName,
                                   _appList->apps[i].packagePath,
                                   _appList->apps[i].isDownloaded,
                                   _appList->apps[i].isInstalled,
                                   _appList->apps[i].error,
                                   _appList->apps[i].errorCode,
                                   colours[i%4]
                            };
                            _list[i] = temp;
                        }
                        set_element_list(_list);
                }
             //   if(appList->apps->isInstalled == 1 && appList->apps->isDownloaded)
             //       cout << "Application installed" << endl;
                else
                    cout << "Error occured: " << _appList->apps->errorCode << endl;
            }
        }
        catch(exception &e)
        {
            cout << "Exception!:" << e.what() << endl;
        }
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
