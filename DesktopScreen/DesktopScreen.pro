TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    appsmodel.cpp

RESOURCES += qml.qrc

#Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = /usr/include/qt5/QtQml/

# Default rules for deployment.
include(deployment.pri)


######################## added for C
INCLUDEPATH += /usr/include/dbus-1.0 \
               /usr/include/

LIBS += -L./usr/include/dbus-1.0 -ldbus-1




HEADERS += \
    appsmodel.h

CONFIG += dbus

DISTFILES += \
    pics/sober_newspecs/icon/icon_calendar.png
