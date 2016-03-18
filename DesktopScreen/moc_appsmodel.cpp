/****************************************************************************
** Meta object code from reading C++ file 'appsmodel.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "appsmodel.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'appsmodel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_AppsModel_t {
    QByteArrayData data[32];
    char stringdata0[423];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_AppsModel_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_AppsModel_t qt_meta_stringdata_AppsModel = {
    {
QT_MOC_LITERAL(0, 0, 9), // "AppsModel"
QT_MOC_LITERAL(1, 10, 16), // "get_element_list"
QT_MOC_LITERAL(2, 27, 0), // ""
QT_MOC_LITERAL(3, 28, 16), // "set_element_list"
QT_MOC_LITERAL(4, 45, 13), // "application[]"
QT_MOC_LITERAL(5, 59, 4), // "list"
QT_MOC_LITERAL(6, 64, 14), // "query_listapps"
QT_MOC_LITERAL(7, 79, 14), // "query_startapp"
QT_MOC_LITERAL(8, 94, 6), // "app_id"
QT_MOC_LITERAL(9, 101, 9), // "is_active"
QT_MOC_LITERAL(10, 111, 13), // "set_is_active"
QT_MOC_LITERAL(11, 125, 6), // "_value"
QT_MOC_LITERAL(12, 132, 25), // "assert_dbus_method_return"
QT_MOC_LITERAL(13, 158, 12), // "DBusMessage*"
QT_MOC_LITERAL(14, 171, 3), // "msg"
QT_MOC_LITERAL(15, 175, 17), // "get_current_index"
QT_MOC_LITERAL(16, 193, 17), // "set_current_index"
QT_MOC_LITERAL(17, 211, 5), // "index"
QT_MOC_LITERAL(18, 217, 14), // "get_page_index"
QT_MOC_LITERAL(19, 232, 14), // "set_page_index"
QT_MOC_LITERAL(20, 247, 26), // "get_number_of_applications"
QT_MOC_LITERAL(21, 274, 11), // "get_applist"
QT_MOC_LITERAL(22, 286, 14), // "set_page_count"
QT_MOC_LITERAL(23, 301, 14), // "get_page_count"
QT_MOC_LITERAL(24, 316, 8), // "shutdown"
QT_MOC_LITERAL(25, 325, 16), // "query_lockscreen"
QT_MOC_LITERAL(26, 342, 28), // "_securityResetDiscEncryption"
QT_MOC_LITERAL(27, 371, 9), // "deleteApp"
QT_MOC_LITERAL(28, 381, 19), // "query_uninstallapps"
QT_MOC_LITERAL(29, 401, 5), // "uint*"
QT_MOC_LITERAL(30, 407, 7), // "app_ids"
QT_MOC_LITERAL(31, 415, 7) // "appsize"

    },
    "AppsModel\0get_element_list\0\0"
    "set_element_list\0application[]\0list\0"
    "query_listapps\0query_startapp\0app_id\0"
    "is_active\0set_is_active\0_value\0"
    "assert_dbus_method_return\0DBusMessage*\0"
    "msg\0get_current_index\0set_current_index\0"
    "index\0get_page_index\0set_page_index\0"
    "get_number_of_applications\0get_applist\0"
    "set_page_count\0get_page_count\0shutdown\0"
    "query_lockscreen\0_securityResetDiscEncryption\0"
    "deleteApp\0query_uninstallapps\0uint*\0"
    "app_ids\0appsize"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_AppsModel[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      20,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    0,  114,    2, 0x02 /* Public */,
       3,    1,  115,    2, 0x02 /* Public */,
       6,    0,  118,    2, 0x02 /* Public */,
       7,    1,  119,    2, 0x02 /* Public */,
       9,    0,  122,    2, 0x02 /* Public */,
      10,    1,  123,    2, 0x02 /* Public */,
      12,    1,  126,    2, 0x02 /* Public */,
      15,    0,  129,    2, 0x02 /* Public */,
      16,    1,  130,    2, 0x02 /* Public */,
      18,    0,  133,    2, 0x02 /* Public */,
      19,    1,  134,    2, 0x02 /* Public */,
      20,    0,  137,    2, 0x02 /* Public */,
      21,    0,  138,    2, 0x02 /* Public */,
      22,    0,  139,    2, 0x02 /* Public */,
      23,    0,  140,    2, 0x02 /* Public */,
      24,    0,  141,    2, 0x02 /* Public */,
      25,    0,  142,    2, 0x02 /* Public */,
      26,    0,  143,    2, 0x02 /* Public */,
      27,    1,  144,    2, 0x02 /* Public */,
      28,    2,  147,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::QVariant,
    QMetaType::Void, 0x80000000 | 4,    5,
    QMetaType::Void,
    QMetaType::Int, QMetaType::Int,    8,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   11,
    QMetaType::Void, 0x80000000 | 13,   14,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   17,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   17,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool, QMetaType::Int,    8,
    QMetaType::Int, 0x80000000 | 29, QMetaType::Int,   30,   31,

       0        // eod
};

void AppsModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        AppsModel *_t = static_cast<AppsModel *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: { QVariant _r = _t->get_element_list();
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 1: _t->set_element_list((*reinterpret_cast< application(*)[]>(_a[1]))); break;
        case 2: _t->query_listapps(); break;
        case 3: { int _r = _t->query_startapp((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 4: { bool _r = _t->is_active();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 5: _t->set_is_active((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 6: _t->assert_dbus_method_return((*reinterpret_cast< DBusMessage*(*)>(_a[1]))); break;
        case 7: { int _r = _t->get_current_index();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 8: _t->set_current_index((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 9: { int _r = _t->get_page_index();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 10: _t->set_page_index((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 11: { int _r = _t->get_number_of_applications();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 12: { int _r = _t->get_applist();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 13: _t->set_page_count(); break;
        case 14: { int _r = _t->get_page_count();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 15: _t->shutdown(); break;
        case 16: _t->query_lockscreen(); break;
        case 17: _t->_securityResetDiscEncryption(); break;
        case 18: { bool _r = _t->deleteApp((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 19: { int _r = _t->query_uninstallapps((*reinterpret_cast< uint*(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObject AppsModel::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_AppsModel.data,
      qt_meta_data_AppsModel,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *AppsModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *AppsModel::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_AppsModel.stringdata0))
        return static_cast<void*>(const_cast< AppsModel*>(this));
    return QObject::qt_metacast(_clname);
}

int AppsModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 20)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 20;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 20)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 20;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
