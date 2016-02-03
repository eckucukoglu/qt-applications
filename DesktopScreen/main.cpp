#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "appsmodel.h"


#include <QVariant>
#include <QList>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{


    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
    AppsModel appsModel;
    engine.rootContext()->setContextProperty("AppsModel", &appsModel);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();

}
