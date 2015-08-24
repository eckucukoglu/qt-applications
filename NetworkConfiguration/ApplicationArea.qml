import QtQuick 2.0
import NetworkHandler 1.0

Item{
    Rectangle {
        anchors.fill: parent
        color: "#444347"

        Column{
            id: switchesColumn
            x: 389
            y: 60
            spacing: 10
            SwitchField{
                id: wirelessEthernetSwitchField

                info: "Connection Type:"
                text1: "Wireless"
                text2: "Ethernet"

                onSwitched: {
                    wirelessEthernetSwitchField.activeText = (wirelessEthernetSwitchField.activeText == text1) ? (text2) : (text1)
                    refreshEntryList(activeText);
                }

                function refreshEntryList(){

                }
            }


            SwitchField{
                id: manualAutoSwitchField

                info: "Network Configuration:"
                text1: "Auto"
                text2: "Manual"

                onSwitched: {
                    manualAutoSwitchField.activeText = (manualAutoSwitchField.activeText == text1) ? (text2) : (text1)
                }
            }
        }

        Column{
            id: addressEntriesColumn
            x:389
            y:190
            spacing: 10

            AddressEntryField{
                id: ipEntryField

                info: "IP Address:"
            }

            AddressEntryField{
                id: netmaskEntryField

                info: "Netmask:"
            }

            AddressEntryField{
                id: gatewayEntryField

                info: "Gateway Address:"
            }

            AddressEntryField{
                id: dnsEntryField

                info: "DNS Address:"
            }
        }

        Column{
            id: macAddressColumn
            x:389
            y:370
            spacing: 10

            MacField{
                id: macAddressField
                info: "MAC Address"
            }
        }


        Row{
            x:763
            y:420
            spacing: 20

            CustomButton{
                id: checkButton
                text: "Check"
            }

            CustomButton{
                id: applyButton
                text: "Apply"
            }

        }

    }

    NetworkHandler{
        id: networkHandler
    }

    Component.onCompleted: {
        var mac = networkHandler.getMACAddress("ethernet")
        console.log(mac)

        var mac2 = networkHandler.getMACAddress("WIREless")
        console.log(mac2)

        var ip = networkHandler.getIP("wireless");
        console.log(ip)
    }
}



