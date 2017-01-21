import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import "Gedcom.js" as Gedcom

ApplicationWindow {
    id: appWindow
    visible: true
    width: 1200
    height: 800
    color: "lightgrey"
    title: qsTr("myGeneal 0.2")

    property Item settings: SetInit {    }


    Page1 {



    }

}




