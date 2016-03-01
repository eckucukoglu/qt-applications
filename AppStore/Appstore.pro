TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    appsmodel.cpp \
    HTTPPerform.cpp \
    cJSON.cpp

RESOURCES += qml.qrc
CFLAGS += -std=c++11

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = /usr/include/qt5/QtQml/

# Default rules for deployment.
include(deployment.pri)


######################## added for C
INCLUDEPATH += /usr/include/dbus-1.0 \
               /usr/include/ \
               /usr/include/x86_64-linux-gnu \
               /home/arcelik/MMIS_ARGE/filesystems/5/usr/include \
               /usr/include/x86_64-linux-gnu \
               /usr/lib/x86_64-linux-gnu/dbus-1.0/include

LIBS += -L/usr/include/dbus-1.0 -L/home/arcelik/MMIS_ARGE/filesystems/5/lib -ldbus-1 -lcurl -lcrypto -lssl -lpthread




HEADERS += \
    appsmodel.h \
    appsmodel.h \
    HTTPPerform.h \
    cJSON.h

CONFIG += dbus

DISTFILES += \
    pics/sober_newspecs/icon/icon_calendar.png
