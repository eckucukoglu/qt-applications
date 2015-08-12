TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    selinuxhandler.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    selinuxhandler.h \

LIBS += -L/home/arcelik/qtWorkspace/SecurityLevels/selinuxso -lselinux
