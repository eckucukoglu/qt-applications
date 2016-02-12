#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "appsmodel.h"


#include <QVariant>
#include <QList>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>


AppsModel appsModel;
void sighandler(int signum);

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    //register signal
    signal(SIGCONT, sighandler);
    signal(SIGTSTP, sighandler);
    signal(SIGSTOP, sighandler);
    signal(SIGABRT,sighandler);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("AppsModel", &appsModel);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}

void sighandler(int signum)
{
    printf("<<<<<<<<<<< %d\n", signum);
   if(signum == SIGCONT)
   {
        printf("::main>SIGCONT\n");
        appsModel.set_is_active(true);
   }
   else if(signum == SIGSTOP)
   {
        printf("::main>SIGSTOP\n");
        appsModel.set_is_active(false);
   }
   else if(signum == SIGTSTP)
   {
        printf("::main>SIGTSTP\n");
        appsModel.set_is_active(false);
   }
   else if(signum == SIGABRT)
   {
        printf("::main>SIGABRT\n");
        appsModel.set_is_active(false);
   }
}
