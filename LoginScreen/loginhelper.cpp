#include "loginhelper.h"

LoginHelper::LoginHelper(QObject *parent) : QObject(parent)
{
    pwd = "xxx";
}

void LoginHelper::set_password(QString password, bool _isShamir){
    pwd = new char[password.length() + 1];
    strcpy(pwd, password.toStdString().c_str());
    isShamir = _isShamir;
    if(isShamir)
    {
        printf("with shamir\n");

    }
    else
    {
        printf("without shamir\n");
    }

}



void LoginHelper::query_access(int access_code) {
    DBusMessage* msg;
    DBusMessageIter args;
    DBusConnection* conn;
    DBusError err;
    int ret;

    printf(APPMAN_VIEW_DEBUG_PREFIX);
    printf("Calling pinvalid method.\n");

    // initialiset the errors
    dbus_error_init(&err);

    // connect to the session bus and check for errors
    conn = dbus_bus_get(DBUS_BUS_SESSION, &err);
    if (dbus_error_is_set(&err)) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Connection Error (%s)\n", err.message);
        dbus_error_free(&err);
    }

    if (!conn) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        printf("Null dbus connection.\n");
        exit(1);
    }

    // request our name on the bus
    ret = dbus_bus_request_name(conn, "appman.method.caller",
                                DBUS_NAME_FLAG_REPLACE_EXISTING , &err);

    if (dbus_error_is_set(&err)) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Name Error (%s)\n", err.message);
        dbus_error_free(&err);
    }

    if (DBUS_REQUEST_NAME_REPLY_PRIMARY_OWNER != ret &&
        DBUS_REQUEST_NAME_REPLY_ALREADY_OWNER != ret) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        printf("Process is not owner of requested dbus name\n");
        exit(1);
    }

    // create a new method call and check for errors
    msg = dbus_message_new_method_call("appman.method.server", // target for the method call
                                    "/appman/method/Object", // object to call on
                                    "appman.method.Type", // interface to call on
                                    "access"); // method name

    if (!msg) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Message Null\n");
        exit(1);
    }

    // append arguments
    dbus_message_iter_init_append(msg, &args);
    if (!dbus_message_iter_append_basic(&args, DBUS_TYPE_UINT32, &access_code)) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Out Of Memory!\n");
        exit(1);
    }

    // send message
    if (!dbus_connection_send(conn, msg, NULL)) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Out Of Memory!\n");
        exit(1);
    }

    dbus_connection_flush(conn);

    printf(APPMAN_VIEW_DEBUG_PREFIX);
    printf("access_code sent\n");

    // free message
    dbus_message_unref(msg);

    dbus_connection_unref(conn);
}

QString LoginHelper::test_method(){
    QString value = QString(pwd);
    return value;
}
