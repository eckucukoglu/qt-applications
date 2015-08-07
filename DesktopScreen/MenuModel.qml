import QtQuick 2.0

ListModel {
    id: menu1
    ListElement{
        name: "Beko Yazar Kasa"
        borderColor: "#015f9a"
        portrait: "pics/sober_newspecs/icon/icon_bekopos.png"
    }
    ListElement{
        name: "Romeo Player"
        borderColor: "#1ABC9C"
        portrait: "pics/sober_newspecs/icon/icon_player.png"
    }
    ListElement{
        name: "Device Settings"
        borderColor: "#e74c3c"
        portrait: "pics/sober_newspecs/icon/icon_deviceset.png"
    }
    ListElement{
        name: "Calculator"
        borderColor: "#88aedb"
        portrait: "pics/sober_newspecs/icon/icon_calculator.png"
    }
    ListElement{
        name: "Calendar"
        borderColor: "#f37021"
        portrait: "pics/sober_newspecs/icon/icon_calender.png"
    }
    ListElement{
        name: "Clock"
        borderColor: "#1abc9c"
        portrait: "pics/sober_newspecs/icon/icon_clock.png"
    }
    ListElement{
        name: "Security Levels"
        borderColor: "#fd9f1b"
        portrait: "pics/sober_newspecs/icon/icon_security.png"
    }
    ListElement{
        name: "Mail"
        borderColor: "#88aedb"
        portrait: "pics/sober_newspecs/icon/icon_mail.png"
    }
    ListElement{
        name: "Network Settings"
        borderColor: "#0e95c5"
        portrait: "pics/sober_newspecs/icon/icon_networkset.png"
    }
    ListElement{
        name: "CPU and RAM Monitor"
        borderColor: "#1ABC9C"
        portrait: "pics/sober_newspecs/icon/icon_cpu.png"
    }
    ListElement{
        name: "Notebook"
        borderColor: "#e74c3c"
        portrait: "pics/sober_newspecs/icon/icon_notebook.png"
    }
    ListElement{
        name: "Arçelik Assistant"
        borderColor: "#b80505"
        portrait: "pics/sober_newspecs/icon/icon_assistant.png"
    }
    ListElement{
        name: "Yapı Kredi"
        borderColor: "#015f9a"
        portrait: "pics/sober_newspecs/icon/icon_ykb.png"
    }
    ListElement{
        name: "Garanti Bankası"
        borderColor: "#2aaf5c"
        portrait: "pics/sober_newspecs/icon/icon_garanti.png"
    }
    ListElement{
        name: "Google Chrome"
        borderColor: "#b80505"
        portrait: "pics/sober_newspecs/icon/icon_chrome.png"
    }
    ListElement{
        name: "Finansbank"
        borderColor: "#0e95c5"
        portrait: "pics/sober_newspecs/icon/icon_tfb.png"
    }
    ListElement{
        name: "TEB"
        borderColor: "#2aaf5c"
        portrait: "pics/sober_newspecs/icon/icon_teb.png"
    }
    ListElement{
        name: "ING Bank"
        borderColor: "#88aedb"
        portrait: "pics/sober_newspecs/icon/icon_ing.png"
    }

    Component.onCompleted: {
        getDay()
    }

    function getDay(){
        var date = new Date();
        var dayNum = date.toLocaleDateString(Qt.locale("en_EN"), "dd")
        var dayOfTheWeek = date.toLocaleDateString(Qt.locale("en_EN"), "dddd")

        console.log(dayNum)
        console.log(dayOfTheWeek)
    }
}


