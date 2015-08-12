#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QtQml>
#include "selinuxhandler.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<SELinuxHandler, 1>("SELinuxHandler", 1, 0, "SELinuxHandler");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
