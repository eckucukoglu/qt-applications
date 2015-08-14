import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2

Item {
    anchors.fill: parent
    anchors.topMargin: 20

    Column{
        spacing: 20
        anchors.horizontalCenter: parent.horizontalCenter

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Filesystem Encryption"

        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            Text{
                id: iWantToText
                text: "I want to "
                anchors.verticalCenter: parent.verticalCenter
            }
            Switch{
                id: encDecSwitch
                checked: false
                style: CustomSwitchStyle{
                    choice1: "Encrypt"
                    choice2: "Decrypt"
                }

                onCheckedChanged: {
                    if(checked) //encrypt
                    {
                        enOrDeCryptedText.text = "Filesystem to be encrypted: "
                        encryptFileNamesCheckBox.opacity = 1.0
                        recognizeMeCheckBox.opacity = 1.0
                    }
                    else{
                        enOrDeCryptedText.text = "Filesystem to be decrypted: "
                        encryptFileNamesCheckBox.opacity = 0.0
                        recognizeMeCheckBox.opacity = 0.0
                    }
                }

            }

            Text{
                text: " a filesystem"
                anchors.verticalCenter: parent.verticalCenter
            }
        }


        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                id: enOrDeCryptedText
                text: "Filesystem to be decrypted: "
                anchors.verticalCenter: parent.verticalCenter
            }

            Text{
                id: filesystemLoc
                anchors.verticalCenter: parent.verticalCenter
                width: 200
                text: ""
                elide: Text.ElideRight
                font.underline: true
            }

            Button{
                text: "Browse.."
                onClicked:{
                    fileDialog.visible = true
                }
            }

            FileDialog{
                id: fileDialog
                title: "Please choose a file"
                folder: shortcuts.home
                selectFolder: true
                onAccepted: {
                    filesystemLoc.text = fileDialog.fileUrl
                    console.log("You chose: " + fileDialog.fileUrls)
                }
                onRejected: {
                    console.log("Canceled")

                }
            }
        }

        CheckBox{
            id: encryptFileNamesCheckBox
            text: "I also want to encrypt file names in that directory"
            opacity: 0.0

            Behavior on opacity{ NumberAnimation{easing.type: Easing.OutQuint}}
        }
        CheckBox{
            id:recognizeMeCheckBox
            text: "Recognize me"
            opacity: 0.0
            Behavior on opacity{ NumberAnimation{easing.type: Easing.OutQuint}}
        }

        Button{
            text: "Apply"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        ListView{
            id: encryptedFSList
        }
    }
}
