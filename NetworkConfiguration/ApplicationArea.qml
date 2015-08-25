import QtQuick 2.0
import QtQuick.Dialogs 1.2
import NetworkHandler 1.0

Item{

    property string currentIP
    property string currentGateway
    property string currentNetmask
    property string currentDNS
    property string currentMAC

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

                function refreshEntryList(activeText){
                    currentMAC = networkHandler.getMACAddress(activeText)
                    currentIP = networkHandler.getIP(activeText);
                    currentNetmask = networkHandler.getNetmask(activeText)
                    currentGateway = networkHandler.getGateway(currentIP, currentNetmask)

                    ipEntryField.text = currentIP;
                    netmaskEntryField.text = currentNetmask;
                    gatewayEntryField.text = currentGateway;
                    macAddressField.text = currentMAC;
                }
            }


            SwitchField{
                id: manualAutoSwitchField

                info: "Network Configuration:"
                text1: "Auto"
                text2: "Manual"

                onSwitched: {
                    manualAutoSwitchField.activeText = (manualAutoSwitchField.activeText == text1) ? (text2) : (text1)

                    ipEntryField.readOnly = !ipEntryField.readOnly
                    dnsEntryField.readOnly = !dnsEntryField.readOnly
                    netmaskEntryField.readOnly = !netmaskEntryField.readOnly
                    gatewayEntryField.readOnly = !gatewayEntryField.readOnly
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
                readOnly: true

                onTextEdited: {
                    currentIP = text;
                }
            }

            AddressEntryField{
                id: netmaskEntryField

                info: "Netmask:"
                readOnly: true

                onTextEdited: {
                    currentNetmask = netmaskEntryField.text;
                }
            }

            AddressEntryField{
                id: gatewayEntryField

                info: "Gateway Address:"
                readOnly: true

                onTextEdited: {
                    currentGateway = gatewayEntryField.text;
                }
            }

            AddressEntryField{
                id: dnsEntryField

                info: "DNS Address:"
                readOnly: true

                onTextEdited: {
                    currentDNS = dnsEntryField.text;
                }
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

                property bool upAndRunning

                onClicked: {
                    upAndRunning = networkHandler.checkConnection(wirelessEthernetSwitchField.activeText);

                    //**************************************************
                    //Up and running check events will be inserted here.
                    //**************************************************
                    popUpCheckResultDialog();
                }

                function popUpCheckResultDialog(){
                    checkResultDialog.setVisible(true)
                }
            }

            CustomButton{
                id: applyButton
                text: "Apply"

                onClicked:{
                    areYouSureDialog.details = areYouSureDialog.prepareDetailsText();
                    popUpAreYouSureScreen();

                }
                function popUpAreYouSureScreen(){
                    areYouSureDialog.setVisible(true)

                }
            }
        }
    }

    MessageDialog{
        property string details: prepareDetailsText()

        id: areYouSureDialog
        title: "Are You Sure?"
        icon: StandardIcon.Question
        text: "These changes might corrupt your network settings."
        informativeText: (manualAutoSwitchField.activeText == "Manual") ? "Use <b>Auto</b> to revert back any changes." : ""
        detailedText: details
        standardButtons: StandardButton.Yes | StandardButton.No
        onYes: {loadingScreen.setVisible(true);
            networkHandler.applyConfiguration(wirelessEthernetSwitchField.activeText, manualAutoSwitchField.activeText, currentIP, currentNetmask, currentGateway, currentDNS)
            loadingScreen.setVisible(false);
        }
        onVisibleChanged: details = prepareDetailsText();
        modality: Qt.WindowModal


        function prepareDetailsText(){
            var str = "";
            if(manualAutoSwitchField.activeText == "Auto")
                str += "The network settings will be automatically configured for the " + wirelessEthernetSwitchField.activeText.toLowerCase() + " interface \n";
            else{
                str += "The following changes will be made:\n";
                str += "IP Address: " + currentIP + "\n";
                str += "Netmask: " + currentNetmask + "\n";
                str += "Gateway Address: " + currentGateway + "\n";

                if(dnsEntryField.text != "..."){    //three dots that are separators
                    str +=  "Also, the following DNS address will be set as your main DNS server: " + currentDNS;

                }
            }

            return str
        }

    }

    MessageDialog{
        id: checkResultDialog
        title: "Checking Your Network Status.."
        icon: StandardIcon.Information
        text: "The interface " + wirelessEthernetSwitchField.activeText.toUpperCase() + " is: \n\n" +
              (checkButton.upAndRunning ? "UP AND RUNNING" : "DOWN");
        modality: Qt.WindowModal
    }

    MessageDialog{
        id: loadingScreen
        modality: Qt.WindowModal
        text: "LOADING.\nPLEASE WAIT..."
        title: "Loading..."
    }

    NetworkHandler{
        id: networkHandler
    }

    Component.onCompleted: {

        //Filling the blanks initially.

        currentMAC = networkHandler.getMACAddress("wireless")
        currentIP = networkHandler.getIP("wireless");
        currentNetmask = networkHandler.getNetmask("wireless")
        currentGateway = networkHandler.getGateway(currentIP, currentNetmask)

        ipEntryField.text = currentIP;
        netmaskEntryField.text = currentNetmask;
        gatewayEntryField.text = currentGateway;
        macAddressField.text = currentMAC;
    }
}



