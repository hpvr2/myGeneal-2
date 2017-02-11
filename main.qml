import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0


ApplicationWindow {
    id: appWindow
    visible: true
    width: 1200
    height: 600
    color: "lightgrey"
    title: qsTr("myGeneal 0.2")

    property Item settings: SetInit {    }

        //TODO : include toolbar here

    Page1 {   }



}




