TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    loginhelper.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = /usr/include/qt5/QtQml/

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    loginhelper.h

INCLUDEPATH += /usr/include/dbus-1.0 \
               /usr/include/  /usr/include/c++/4.8

LIBS += -L./usr/include/dbus-1.0 -ldbus-1

