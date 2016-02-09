#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "appsmodel.h"


#include <QVariant>
#include <QList>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

void sighandler(int);

AppsModel appsModel;
int main(int argc, char *argv[])
{

    signal(SIGCONT, sighandler);
    signal(SIGTSTP, sighandler);
    signal(SIGSTOP, sighandler);

    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("AppsModel", &appsModel);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();

}

void sighandler(int signum)
{

   if(signum == 18)
   {
        printf("::main>SIGCONT\n");
        appsModel.set_is_active(true);
   }
   else if(signum == 19)
   {
        printf("::main>SIGSTOP\n");
        appsModel.set_is_active(false);
   }
   else if(signum == 20)
   {
        printf("::main>SIGTSTP\n");
        appsModel.set_is_active(false);
   }
}
