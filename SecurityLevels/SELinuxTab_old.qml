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
            id: currentModeText
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Current Mode : " + (seLinuxHandler.getStatus())

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
                    choice1: "Enforcing"
                    choice2: "Permissive"

                }
            }
        }

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            text: "PERMANENT CHANGES TAKE EFFECT AFTER REBOOT"
            color: "red"
        }

        Button{
            id: applyButton
            text: "Apply"
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked:{
                if(tempPermSwitch.checked)  //permanently, write to config file
                    if(permissiveEnforcedSwitch.checked){
                        console.log("permanently enforce")
                        seLinuxHandler.setModePermanently(1)
                    }
                    else{
                        console.log("permanently permissive")
                        seLinuxHandler.setModePermanently(0)
                    }
                else{
                    if(permissiveEnforcedSwitch.checked){
                        console.log("temporarily enforce")
                        seLinuxHandler.setTemporarilyEnforcing()
                    }
                    else{
                        console.log("temporarily permissive")
                        seLinuxHandler.setTemporarilyPermissive()
                    }
                    refreshStatus();
                }

            }
            function refreshStatus(){
                currentModeText.text = "Current Mode : " + (seLinuxHandler.getStatus());
            }
        }
    }
}

