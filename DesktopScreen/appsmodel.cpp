#include "appsmodel.h"
#define DBUS_API_SUBJECT_TO_CHANGE
#include <dbus/dbus.h>
#include <stdbool.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

AppsModel::AppsModel(QObject *parent) : QObject(parent)
{
    //read list, assign to elementsList
    current_index = 0;
    page_count = 0;
    page_index = 0;
    query_listapps();
}

/*
AppsModel::~AppsModel()
{

}
*/
void AppsModel::set_element_list(application _list[]){
    QVariantList _list1;
    for(int i=0; i<number_of_applications;i++)
    {
        QVariant _data;
        QVariantMap _map;
        _map["prettyname"] = QVariant(_list[i].prettyname);
        _map["iconpath"] = QVariant(_list[i].iconpath);
        _map["color"] = QVariant(_list[i].color);
        _map["id"] = QVariant(_list[i].id);
        _data = QVariant(_map);
        _list1.append(_data);
    }

    appList = QVariant(_list1);
    set_page_count();
}

QVariant AppsModel::get_element_list() //Type should be QList with AppElement type
{
   return appList;
}

int AppsModel::get_current_index() //Type should be QList with AppElement type
{
    //return elementsList;
   return current_index;
}
void AppsModel::set_current_index(int index) //Type should be QList with AppElement type
{
    //return elementsList;
   current_index = index;
}
int AppsModel::get_page_index()
{
    return page_index;
}
void AppsModel::set_page_index(int index)
{
    page_index= index;
}

int AppsModel::get_number_of_applications()
{
    return number_of_applications;
}
int AppsModel::get_applist()
{
    return APPLIST[1].id;
}

void AppsModel::set_page_count()
{
    page_count = ceil(double(number_of_applications)/18);
}
int AppsModel::get_page_count()
{
    return page_count;
}
/**
 * Call a listapps method on a remote object.
 */
void AppsModel::query_listapps() {
    DBusMessage* msg;
    DBusMessageIter args, arrayIter, structIter;
    DBusConnection* conn;
    DBusError err;
    DBusPendingCall* pending;
    int ret;
    int i;

    // initialiset the errors
    dbus_error_init(&err);

    // connect to the system bus and check for errors
    conn = dbus_bus_get(DBUS_BUS_SESSION, &err);

    if (dbus_error_is_set(&err)) {
        fprintf(stderr, "Connection Error (%s)\n", err.message);
        dbus_error_free(&err);
    }

    if (NULL == conn) {
        exit(1);
    }

    // request our name on the bus
    ret = dbus_bus_request_name(conn, "appman.method.caller",
                                DBUS_NAME_FLAG_REPLACE_EXISTING , &err);

    if (dbus_error_is_set(&err)) {
        fprintf(stderr, "Name Error (%s)\n", err.message);
        dbus_error_free(&err);
    }

    if (DBUS_REQUEST_NAME_REPLY_PRIMARY_OWNER != ret) {
        exit(1);
    }

    // create a new method call and check for errors
    msg = dbus_message_new_method_call("appman.method.server", // target for the method call
                                       "/appman/method/Object", // object to call on
                                       "appman.method.Type", // interface to call on
                                       "listapps"); // method name

    if (NULL == msg) {
        fprintf(stderr, "memory can't be allocated for the message\n");
        exit(1);
    }

    // send message and get a handle for a reply
    if (!dbus_connection_send_with_reply (conn, msg, &pending, -1)) { // -1 is default timeout
        fprintf(stderr, "Out Of Memory!\n");
        exit(1);
    }

    if (NULL == pending) {
        fprintf(stderr, "Pending Call Null\n");
        exit(1);
    }

    dbus_connection_flush(conn);

    printf("Request Sent to Dbus\n");

    // free message
    dbus_message_unref(msg);

    // block until we recieve a reply
    dbus_pending_call_block(pending);

    // get the reply message
    msg = dbus_pending_call_steal_reply(pending);

    if (NULL == msg) {
        fprintf(stderr, "Reply Null\n");
        exit(1);
    }

    // free the pending message handle
    dbus_pending_call_unref(pending);


    printf("** Message info **\n");
    printf("Sender: %s\n", dbus_message_get_sender(msg));
    printf("Type: %d\n", dbus_message_get_type(msg));
    printf("Path: %s\n", dbus_message_get_path(msg));
    printf("Interface: %s\n", dbus_message_get_interface(msg));
    printf("Member: %s\n", dbus_message_get_member(msg));
    printf("Destination: %s\n", dbus_message_get_destination(msg));
    printf("Signature: %s\n", dbus_message_get_signature(msg));

    // TODO: in case of unexpected message type, free objects.

    switch (dbus_message_get_type(msg)) {
    case 0: /* INVALID */
        printf("Invalid message from dbus.\n");
        exit(1);
        break;

    case 1: /* METHOD_CALL */
        printf("Received method call from dbus, expecting method return\n");
        exit(1);
        break;

    case 2: /* METHOD_RETURN */
        printf("Received method return.\n");
        break;

    case 3: /* ERROR */
        printf("Received error message from dbus.\n");
        char *err_message;
       if (!dbus_message_iter_init(msg, &args))
            fprintf(stderr, "Message has no arguments!\n");
        else if (DBUS_TYPE_STRING != dbus_message_iter_get_arg_type(&args))
            fprintf(stderr, "Argument is not string!\n");
        else
            dbus_message_iter_get_basic(&args, &err_message);

        printf("%s\n", err_message);
        exit(1);
        break;

    case 4: /* SIGNAL */
        printf("Message type is signal, expecting method return.\n");
        exit(1);
        break;

    default:
        printf("Unknown message type.\n");
        exit(1);
        break;
    }

    // read the parameters
    if (!dbus_message_iter_init(msg, &args))
        fprintf(stderr, "Message has no arguments!\n");
    else if (DBUS_TYPE_UINT32 != dbus_message_iter_get_arg_type(&args))
        fprintf(stderr, "Argument is not integer!\n");
    else
        dbus_message_iter_get_basic(&args, &number_of_applications);

    printf("#applications: %d\n", number_of_applications);

    if (!dbus_message_iter_next(&args))
        fprintf(stderr, "Message has too few arguments!\n");
    else if (DBUS_TYPE_ARRAY != dbus_message_iter_get_arg_type(&args))
        fprintf(stderr, "Argument is not array!\n");
    else {
        dbus_message_iter_recurse(&args, &arrayIter);

        for (i = 0; i < number_of_applications; ++i) {
            if (DBUS_TYPE_STRUCT == dbus_message_iter_get_arg_type(&arrayIter)) {
                dbus_message_iter_recurse(&arrayIter, &structIter);
                if (DBUS_TYPE_UINT32 == dbus_message_iter_get_arg_type(&structIter))
                    dbus_message_iter_get_basic(&structIter, &(APPLIST[i].id));

                dbus_message_iter_next(&structIter);

                if (DBUS_TYPE_STRING == dbus_message_iter_get_arg_type(&structIter))
                    dbus_message_iter_get_basic(&structIter, &(APPLIST[i].prettyname));

                dbus_message_iter_next(&structIter);

                if (DBUS_TYPE_STRING == dbus_message_iter_get_arg_type(&structIter))
                    dbus_message_iter_get_basic(&structIter, &(APPLIST[i].color));

                dbus_message_iter_next(&structIter);

                if (DBUS_TYPE_STRING == dbus_message_iter_get_arg_type(&structIter))
                    dbus_message_iter_get_basic(&structIter, &(APPLIST[i].iconpath));

                printf("#(%d): %s, %s, %s\n", APPLIST[i].id, APPLIST[i].prettyname,
                      APPLIST[i].iconpath, APPLIST[i].color);
            }

            dbus_message_iter_next(&arrayIter);
        }

    }


    set_element_list(APPLIST);

    // free reply and close connection
    dbus_message_unref(msg);

    dbus_connection_unref(conn);
    // dbus_connection_close(conn);

}

void AppsModel::run_app(int index)
{
    char Str[16];
    sprintf(Str, "%d", index);
    query_runapp(Str);
}

/**
 * Call a runapp method on a remote object.
 */
void AppsModel::query_runapp(char* param){
    DBusMessage* msg;
    DBusMessageIter args;
    DBusConnection* conn;
    DBusError err;
    DBusPendingCall* pending;
    int ret;
    dbus_uint32_t run_ret;

    printf("Calling remote method with %s\n", param);

    // initialiset the errors
    dbus_error_init(&err);

    // connect to the system bus and check for errors
    conn = dbus_bus_get(DBUS_BUS_SESSION, &err);
    if (dbus_error_is_set(&err)){
        fprintf(stderr, "Connection Error (%s)\n", err.message);
        dbus_error_free(&err);
    }

    if (NULL == conn){
        printf("NULL connection established.\n");
        exit(1);
    }

    // request our name on the bus
    ret = dbus_bus_request_name(conn, "appman.method.caller", DBUS_NAME_FLAG_REPLACE_EXISTING , &err);

    if (dbus_error_is_set(&err)) {
        fprintf(stderr, "Name Error (%s)\n", err.message);
        dbus_error_free(&err);
    }

    if (DBUS_REQUEST_NAME_REPLY_PRIMARY_OWNER != ret && DBUS_REQUEST_NAME_REPLY_ALREADY_OWNER != ret) {
        printf("Not primary owner: %d\n", ret);
        exit(1);
    }

    // create a new method call and check for errors
    msg = dbus_message_new_method_call("appman.method.server", // target for the method call
                  "/appman/method/Object", // object to call on
                  "appman.method.Type", // interface to call on
                  "runapp"); // method name

    if (NULL == msg) {
        fprintf(stderr, "Message Null\n");
        exit(1);
    }

    printf("** Message info **\n");
    printf("Sender: %s\n", dbus_message_get_sender(msg));
    printf("Type: %d\n", dbus_message_get_type(msg));
    printf("Path: %s\n", dbus_message_get_path(msg));
    printf("Interface: %s\n", dbus_message_get_interface(msg));
    printf("Member: %s\n", dbus_message_get_member(msg));
    printf("Destination: %s\n", dbus_message_get_destination(msg));
    printf("Signature: %s\n", dbus_message_get_signature(msg));

    // append arguments
    dbus_message_iter_init_append(msg, &args);
    if (!dbus_message_iter_append_basic(&args, DBUS_TYPE_STRING, &param)) {
        fprintf(stderr, "Out Of Memory!\n");
        exit(1);
    }

    // send message and get a handle for a reply
    if (!dbus_connection_send_with_reply (conn, msg, &pending, -1)) { // -1 is default timeout
        fprintf(stderr, "Out Of Memory!\n");
        exit(1);
    }

    if (NULL == pending) {
        fprintf(stderr, "Pending Call Null\n");
        exit(1);
    }

    dbus_connection_flush(conn);

    printf("Request Sent\n");

    // free message
    dbus_message_unref(msg);

    // block until we recieve a reply
    dbus_pending_call_block(pending);

    // get the reply message
    msg = dbus_pending_call_steal_reply(pending);
    if (NULL == msg) {
        fprintf(stderr, "Reply Null\n");
        exit(1);
    }

    // free the pending message handle
    dbus_pending_call_unref(pending);

    // read the parameters
    if (!dbus_message_iter_init(msg, &args))
        fprintf(stderr, "Message has no arguments!\n");
    else if (DBUS_TYPE_UINT32 != dbus_message_iter_get_arg_type(&args))
        fprintf(stderr, "Argument is not integer!\n");
    else
        dbus_message_iter_get_basic(&args, &run_ret);

    printf("Got Reply: %d\n", run_ret);

    // free reply and close connection
    dbus_message_unref(msg);

    dbus_connection_unref(conn);
    // dbus_connection_close(conn);


}

int AppsModel::run(int argc, char* argv[]){
    if (argv[1] != NULL && strcmp("runapp", argv[1]) == 0 && argv[2] != NULL)
        query_runapp(argv[2]);
    else if (argv[1] != NULL && strcmp(argv[1], "listapps") == 0)
        query_listapps();
    else {
        printf ("Syntax: %s [runapp|listapps] [<param>]\n", argv[0]);
        return 1;
    }

    return 0;
}

