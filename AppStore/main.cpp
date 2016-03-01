#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "appsmodel.h"
#include <QVariant>
#include <QList>
#include <stdio.h>
#include <stdlib.h>
#include "HTTPPerform.h"
using namespace std;

int main(int argc, char *argv[])
{
    AppsModel appsModel;
    HTTPPerform* performer = new HTTPPerform("http://10.155.10.206:8000/");
    applications* appList;
    printf("Main :: start\n");

    try {
            appList = performer->perform(SHOW,0);
            //appList = performer->perform(DOWNLOAD,app_id);
            if (appList == NULL)
            {
                cout << "Applist is NULL" << endl;
            }
            else{
                if (performer->getError() == 1){
                    cout << "Error occured during HTTP request :" << performer->getErrorMessage() << endl;

                }
                else if (appList->apps != NULL)
                {
                    appsModel.check_internet=true;
                    string colours[] = {"#FC0505", "#89F0F0", "#F0E224", "#1AC44D"};
                    appsModel.number_of_applications = appList->size;
                    app _list[appList->size];
                    for(int i=0;i< appList->size; i++)
                        {
                            cout << "Application "<< to_string(i) << endl;
                            cout << "\t" << "id: " << to_string(appList->apps[i].id)<<endl;
                            cout << "\t" << "name: " << (appList->apps[i].name)<<endl;
                            cout << "\t" << "developer name: " << (appList->apps[i].developerName)<<endl;
                            cout << "\t" << "icon: " << (appList->apps[i].iconName)<<endl;
                            app temp{
                                   appList->apps[i].id,
                                   appList->apps[i].name,
                                   appList->apps[i].developerName,
                                   appList->apps[i].iconName,
                                   appList->apps[i].hashValue,
                                   appList->apps[i].binaryPath,
                                   appList->apps[i].binaryName,
                                   appList->apps[i].packagePath,
                                   appList->apps[i].isDownloaded,
                                   appList->apps[i].isInstalled,
                                   appList->apps[i].error,
                                   appList->apps[i].errorCode,
                                   colours[i%4]
                            };
                            _list[i] = temp;
                        }
                        appsModel.set_element_list(_list);
                }
             //   if(appList->apps->isInstalled == 1 && appList->apps->isDownloaded)
             //       cout << "Application installed" << endl;
                else
                    cout << "Error occured: " << appList->apps->errorCode << endl;
            }
        }

        catch(exception &e)
        {
            cout << "Exception!:" << e.what() << endl;
        }

    printf("main:: end\n");
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("AppsModel", &appsModel);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
