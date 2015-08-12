import QtQuick 2.0
import QtQuick.Controls 1.4
import SELinuxHandler 1.0

Item {
    anchors.fill: parent
    anchors.topMargin: 20

    SELinuxHandler{
        id: seLinuxHandler
    }

    Column{
        spacing: 20
        anchors.horizontalCenter: parent.horizontalCenter

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Change SELinux Mode"

        }

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Current Mode: ENFORCED"

        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                id: iWantToChangeSELinuxText
                text: "I want to change SELinux Mode "
                anchors.verticalCenter: parent.verticalCenter
            }
            Switch{
                id: tempPermSwitch
                style: CustomSwitchStyle{
                    choice1: "Permanently"
                    choice2: "Temporarily"
                }
            }
        }


        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                text: "I want my SELinuxMode to be : "
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Switch{
                id: permissiveEnforcedSwitch
                style: CustomSwitchStyle{
                    choice1: "Enforced"
                    choice2: "Permissive"

                }
            }
        }

        Button{
            text: "Apply"
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked:{
                seLinuxHandler.getStatus()
                //console.log()
            }
        }
    }
}

