import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

Item {
    anchors.fill: parent
    anchors.topMargin: 20
    Column{
        spacing: 20
        anchors.horizontalCenter: parent.horizontalCenter

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            text: "File Encryption"

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
                id: tempPermSwitch
                style: CustomSwitchStyle{
                    choice1: "Encrypt"
                    choice2: "Decrypt"
                }

                onCheckedChanged: {
                    if(checked) //encrypt
                    {
                        fileToBeEncDecText.text = "File to be encrypted: "
                    }
                    else{
                        fileToBeEncDecText.text = "File to be decrypted: "
                    }
                }
            }

            Text{
                text: " a file"
                anchors.verticalCenter: parent.verticalCenter
            }
        }


        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                id: fileToBeEncDecText
                text: "File to be decrypted: "
                anchors.verticalCenter: parent.verticalCenter
            }

            Text{
                id: fileLoc
                anchors.verticalCenter: parent.verticalCenter
                width: 200
                text: "                       "
                elide: Text.ElideRight
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
                    folder: "$$PWD"
                    onAccepted: {
                        fileLoc.text = fileDialog.fileUrl
                        console.log("You chose: " + fileDialog.fileUrls)
                    }
                    onRejected: {
                        console.log("Canceled")

                    }
            }
        }

        Button{
            text: "Apply"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}

