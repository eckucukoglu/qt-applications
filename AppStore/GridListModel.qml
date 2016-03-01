import QtQuick 2.0

ListModel{
    id: listModel
    property int m;
    function fillListModel(){
        var index=0
        var appList = AppsModel.get_element_list()
        var appCount = AppsModel.get_number_of_applications()
        listModel.clear();
        index = AppsModel.get_current_index()
        var _range = appCount - index; //remaining apps to show
        if(_range <= 18)
        {
            for(m=index; m<(index+_range); m++) //for each page
            {
                listModel.append({"app_id": appList[m]["id"] ,"name": appList[m]["name"], "developerName":appList[m]["developerName"],"borderColor":appList[m]["borderColor"],"portrait":appList[m]["iconName"], "hashValue":appList[m]["hashValue"], "binaryPath":appList[m]["binaryPath"], "packagePath":appList[m]["packagePath"], "isDownloaded":appList[m]["isDownloaded"], "isInstalled":appList[m]["isInstalled"], "error":appList[m]["error"], "errorCode":appList[m]["errorCode"]})
            }
            index = index + _range
        }
        else
        {
            for(m=index; m<index+18; m++) //for each page
            {
                listModel.append({"app_id": appList[m]["id"] ,"name": appList[m]["name"], "developerName":appList[m]["developerName"],"borderColor":appList[m]["borderColor"],"portrait":appList[m]["iconName"], "hashValue":appList[m]["hashValue"], "binaryPath":appList[m]["binaryPath"], "packagePath":appList[m]["packagePath"], "isDownloaded":appList[m]["isDownloaded"], "isInstalled":appList[m]["isInstalled"], "error":appList[m]["error"], "errorCode":appList[m]["errorCode"]})
            }
            index = index + 18
        }
        AppsModel.set_current_index(index)
     }


     Component.onCompleted: {
            fillListModel()
     }
}
