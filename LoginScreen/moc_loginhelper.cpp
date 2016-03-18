/****************************************************************************
** Meta object code from reading C++ file 'loginhelper.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "loginhelper.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'loginhelper.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_LoginHelper_t {
    QByteArrayData data[10];
    char stringdata0[101];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_LoginHelper_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_LoginHelper_t qt_meta_stringdata_LoginHelper = {
    {
QT_MOC_LITERAL(0, 0, 11), // "LoginHelper"
QT_MOC_LITERAL(1, 12, 14), // "check_password"
QT_MOC_LITERAL(2, 27, 0), // ""
QT_MOC_LITERAL(3, 28, 3), // "pwd"
QT_MOC_LITERAL(4, 32, 9), // "_isShamir"
QT_MOC_LITERAL(5, 42, 11), // "query_login"
QT_MOC_LITERAL(6, 54, 11), // "access_code"
QT_MOC_LITERAL(7, 66, 12), // "set_tryCount"
QT_MOC_LITERAL(8, 79, 8), // "tryCount"
QT_MOC_LITERAL(9, 88, 12) // "get_tryCount"

    },
    "LoginHelper\0check_password\0\0pwd\0"
    "_isShamir\0query_login\0access_code\0"
    "set_tryCount\0tryCount\0get_tryCount"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_LoginHelper[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    2,   34,    2, 0x02 /* Public */,
       5,    1,   39,    2, 0x02 /* Public */,
       7,    1,   42,    2, 0x02 /* Public */,
       9,    0,   45,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::Bool, QMetaType::QString, QMetaType::Bool,    3,    4,
    QMetaType::Void, QMetaType::Int,    6,
    QMetaType::Void, QMetaType::Int,    8,
    QMetaType::Int,

       0        // eod
};

void LoginHelper::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        LoginHelper *_t = static_cast<LoginHelper *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: { bool _r = _t->check_password((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 1: _t->query_login((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 2: _t->set_tryCount((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 3: { int _r = _t->get_tryCount();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObject LoginHelper::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_LoginHelper.data,
      qt_meta_data_LoginHelper,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *LoginHelper::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *LoginHelper::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_LoginHelper.stringdata0))
        return static_cast<void*>(const_cast< LoginHelper*>(this));
    return QObject::qt_metacast(_clname);
}

int LoginHelper::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 4;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
