#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "appsmodel.h"


#include <QVariant>
#include <QList>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <QScreen>
#include <QDebug>


AppsModel appsModel;

//QObject *rootObject;
//QObject *rootObj;


void sighandler(int signum)
{
   printf(">>>>>>sigcont: %d\n", signum);
   //rootObj->setProperty("is_accepted", true);

}


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("AppsModel", &appsModel);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    foreach(QScreen *screen, app.screens()){
          screen->refreshRateChanged(qreal(100));

          qDebug() << "  Refresh rate:" << screen->refreshRate() << "Hz";
    }


  //  rootObject = engine.rootObjects().first();
  //  rootObj = rootObject->findChild<QObject*>("root");

    signal(SIGCONT, sighandler);

   return app.exec();
}



