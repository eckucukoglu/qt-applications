#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QtQml>
#include "fileio.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<FileIO, 1>("FileIO", 1, 0, "FileIO");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
