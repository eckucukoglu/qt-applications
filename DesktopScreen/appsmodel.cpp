#include "appsmodel.h"
#define DBUS_API_SUBJECT_TO_CHANGE
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
    _isActive = true;
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
bool AppsModel::is_active() //Type should be QList with AppElement type
{
    //return elementsList;
   return _isActive;
}
void AppsModel::set_is_active(bool _value) //Type should be QList with AppElement type
{
    //return elementsList;
   _isActive = _value;
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


void AppsModel::assert_dbus_method_return (DBusMessage* msg) {
    DBusMessageIter args;
    printf(APPMAN_VIEW_DEBUG_PREFIX"Coming dbus message...\n");
    printf(APPMAN_VIEW_DEBUG_PREFIX"-------------------------\n");
    printf(APPMAN_VIEW_DEBUG_PREFIX"Sender: %s\n", dbus_message_get_sender(msg));
    printf(APPMAN_VIEW_DEBUG_PREFIX"Type: %d\n", dbus_message_get_type(msg));
    printf(APPMAN_VIEW_DEBUG_PREFIX"Path: %s\n", dbus_message_get_path(msg));
    printf(APPMAN_VIEW_DEBUG_PREFIX"Interface: %s\n", dbus_message_get_interface(msg));
    printf(APPMAN_VIEW_DEBUG_PREFIX"Member: %s\n", dbus_message_get_member(msg));
    printf(APPMAN_VIEW_DEBUG_PREFIX"Destination: %s\n", dbus_message_get_destination(msg));
    printf(APPMAN_VIEW_DEBUG_PREFIX"Signature: %s\n", dbus_message_get_signature(msg));
    printf(APPMAN_VIEW_DEBUG_PREFIX"-------------------------\n");
    fflush(stdout);

    // TODO: in case of unexpected message type, free objects.

    switch (dbus_message_get_type(msg)) {
    case 0: /* INVALID */
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        printf("Invalid message from dbus.\n");
        exit(1);
        break;

    case 1: /* METHOD_CALL */
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        printf("Received method call from dbus, expecting method return\n");
        exit(1);
        break;

    case 2: /* METHOD_RETURN */
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        printf("Received method return.\n");
        break;

    case 3: /* ERROR */
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        printf("Received error message from dbus.\n");
        char *err_message;
        if (!dbus_message_iter_init(msg, &args)) {
            printf(APPMAN_VIEW_DEBUG_PREFIX);
            fprintf(stderr, "Message has no arguments!\n");
        } else if (DBUS_TYPE_STRING != dbus_message_iter_get_arg_type(&args)) {
            printf(APPMAN_VIEW_DEBUG_PREFIX);
            fprintf(stderr, "Argument is not string!\n");
        } else
            dbus_message_iter_get_basic(&args, &err_message);

        printf(APPMAN_VIEW_DEBUG_PREFIX);
        printf("%s\n", err_message);
        exit(1);
        break;

    case 4: /* SIGNAL */
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        printf("Message type is signal, expecting method return.\n");
        exit(1);
        break;

    default:
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        printf("Unknown message type.\n");
        exit(1);
        break;
    }
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
                                       "listapps"); // method name

    if (NULL == msg) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "memory can't be allocated for the message\n");
        exit(1);
    }

    // send message and get a handle for a reply
    if (!dbus_connection_send_with_reply (conn, msg, &pending, -1)) { // -1 is default timeout
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Out Of Memory!\n");
        exit(1);
    }

    if (!pending) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Pending Call Null\n");
        exit(1);
    }

    dbus_connection_flush(conn);

    printf(APPMAN_VIEW_DEBUG_PREFIX);
    printf("Request Sent to Dbus\n");

    // free message
    dbus_message_unref(msg);

    // block until we recieve a reply
    dbus_pending_call_block(pending);

    // get the reply message
    msg = dbus_pending_call_steal_reply(pending);

    if (NULL == msg) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Reply Null\n");
        exit(1);
    }

    // free the pending message handle
    dbus_pending_call_unref(pending);

    /* Be sure that dbus message is method return. */
    assert_dbus_method_return(msg);

    // read the parameters
    if (!dbus_message_iter_init(msg, &args)) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Message has no arguments!\n");
    } else if (DBUS_TYPE_UINT32 != dbus_message_iter_get_arg_type(&args)) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Argument is not integer!\n");
    } else
        dbus_message_iter_get_basic(&args, &number_of_applications);

    printf(APPMAN_VIEW_DEBUG_PREFIX);
    printf("number of applications: %d\n", number_of_applications);

    if (!dbus_message_iter_next(&args)) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Message has too few arguments!\n");
    } else if (DBUS_TYPE_ARRAY != dbus_message_iter_get_arg_type(&args)) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Argument is not array!\n");
    } else {
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

                printf(APPMAN_VIEW_DEBUG_PREFIX);
                printf("#(%d): %s\n", APPLIST[i].id, APPLIST[i].prettyname);
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


/**
 * Call a runapp method on a remote object.
 */
void AppsModel::query_runapp(int app_id) {
    DBusMessage* msg;
    DBusMessageIter args;
    DBusConnection* conn;
    DBusError err;
    DBusPendingCall* pending;
    int ret;
    dbus_uint32_t run_ret;

    printf(APPMAN_VIEW_DEBUG_PREFIX);
    printf("Calling runapp method with id:%d\n", app_id);

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
                  "runapp"); // method name

    if (!msg) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Message Null\n");
        exit(1);
    }

    // append arguments
    dbus_message_iter_init_append(msg, &args);
    if (!dbus_message_iter_append_basic(&args, DBUS_TYPE_UINT32, &app_id)) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Out Of Memory!\n");
        exit(1);
    }

    // send message and get a handle for a reply
    if (!dbus_connection_send_with_reply (conn, msg, &pending, -1)) { // -1 is default timeout
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Out Of Memory!\n");
        exit(1);
    }

    if (NULL == pending) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Pending Call Null\n");
        exit(1);
    }

    dbus_connection_flush(conn);

    printf(APPMAN_VIEW_DEBUG_PREFIX);
    printf("Request Sent\n");

    // free message
    dbus_message_unref(msg);

    // block until we recieve a reply
    dbus_pending_call_block(pending);

    // get the reply message
    msg = dbus_pending_call_steal_reply(pending);
    if (NULL == msg) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Reply Null\n");
        exit(1);
    }

    // free the pending message handle
    dbus_pending_call_unref(pending);

    assert_dbus_method_return(msg);

    // read the parameters
    if (!dbus_message_iter_init(msg, &args)) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Message has no arguments!\n");
    } else if (DBUS_TYPE_UINT32 != dbus_message_iter_get_arg_type(&args)) {
        printf(APPMAN_VIEW_DEBUG_PREFIX);
        fprintf(stderr, "Argument is not integer!\n");
    } else
        dbus_message_iter_get_basic(&args, &run_ret);

    printf(APPMAN_VIEW_DEBUG_PREFIX);
    printf("Got Reply: %d\n", run_ret);



    // free reply and close connection
    dbus_message_unref(msg);

    dbus_connection_unref(conn);
    // dbus_connection_close(conn);
}

