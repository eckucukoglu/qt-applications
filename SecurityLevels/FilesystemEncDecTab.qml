import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import EncDecHandler 1.0

Item {
    anchors.fill: parent
    anchors.topMargin: 20

    EncDecHandler{
        id: encDecHandler
    }

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
                style: CustomSwitchStyle{
                    choice1: "Encrypt"
                    choice2: "Decrypt"
                }

                onCheckedChanged: {
                    pwDialog.encrypting = !(pwDialog.encrypting)
                    if(checked) //encrypt
                    {
                        enOrDeCryptedText.text = "Filesystem to be encrypted: "
                        encryptFileNamesCheckBox.opacity = 1.0
                        recognizeMeCheckBox.opacity = 1.0
                        //fileDialog.setNameFilters("Any filesystem (*)")
                    }
                    else{
                        enOrDeCryptedText.text = "Filesystem to be decrypted: "
                        encryptFileNamesCheckBox.opacity = 0.0
                        recognizeMeCheckBox.opacity = 0.0
                        //fileDialog.setNameFilters("Any filesystem (*)")

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
                width: 400
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
                    filesystemLoc.text = encDecHandler.getLocalFilePath(fileDialog.fileUrl)
                    console.log("You chose: " + filesystemLoc.text)
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

            onClicked:{

                if(filesystemLoc.text.length != 0)
                    pwDialog.open()
                else{
                    console.log("Enter a valid file")
                }

            }
        }

        PasswordDialog{
            id: pwDialog

            onPasswordEntered: {    //In a PasswordDialog, we know that the filesystem is valid.
                //In this slot, we know that password is also provided
                //by the user.
                var result;
                if(encDecSwitch.checked){
                    //we will encrypt the fileystem
                    if(encryptFileNamesCheckBox.checkedState == Qt.Checked){
                        //Encrpyt with encrypt file names.
                        result = encDecHandler.initiateFilesystemEncryption(filesystemLoc.text, password, true)
                    }
                    else{
                        result = encDecHandler.initiateFilesystemEncryption(filesystemLoc.text, password, false)
                    }


                    if(recognizeMeCheckBox.checkedState == Qt.Checked){
                        //Recognize me. Don't unmount
                        console.log("no unmount.");

                    }
                    else{
                        //dont recognize me, unmount.
                        encDecHandler.unmountFS(filesystemLoc.text)
                        console.log("unmount the filesystem: " + filesystemLoc.text)

                    }

                    if(result == false)
                        failedDialog.open();
                    else{
                        doneDialog.open();
                        encryptedFSListModel.append({filepath: filesystemLoc.text, recognizeMe: recognizeMeCheckBox.checked})
                        encryptedFSListView.update()
                    }
                }
                else{
                    //we will decrypt the file
                    result = encDecHandler.initiateFilesystemDecryption(filesystemLoc.text, password)
                    if(result == false)
                        failedDialog.open();
                    else{
                        doneDialog.open();
                    }
                }

            }
            Component.onCompleted:{
                encrypting: encDecSwitch.checked

            }
        }

        MessageDialog{
            id: failedDialog
            text: "Operation Failed."
            icon: StandardIcon.Critical
        }
        MessageDialog{
            id: doneDialog
            text: "Operation Done."
            icon: StandardIcon.Information
        }

        ListView{
            id: encryptedFSListView
            model: encryptedFSListModel
            width: 700
            height: 400

            delegate: Text {
                    text: "filepath: " + filepath + ", recognizeMe: "+ recognizeMe;
                }
        }

        ListModel{
            id:encryptedFSListModel
            ListElement{
                filepath: "sample"
                recognizeMe: false
            }
        }
    }


}

