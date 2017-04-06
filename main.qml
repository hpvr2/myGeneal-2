import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import "Gedcom.js" as Gedcom


ApplicationWindow {
    id: appWindow
    visible: true
    width: 1200
    height: 600
    color: "lightgrey"
    title: qsTr("myGeneal 0.2")

    property Item settings: SetInit {   }

    property int actualId : 0
    property int  actualFam : 0

    property int startIndi :0
    property int startFam : 0
    property int startTrailer:0


    property var persons :[]
    property var families :[]
    property var trailer : []

    property var personIndex : []
    property var familyIndex : []
    property var unusedPersons :[]
    property var unusedfanilies : []

    property Family parentFamily :null
    property Family partnerFamily :null
    property Family family: null
    property Person person: null

    property string selectGender: ""
    property string selectName : ""
    property int selectFrom: 0      //todo variable year
    property int selectTo : 2017   // todo variable year

    onClosing: {
        print ("closing")
        Gedcom.writeGedcom()
        print("done")
    }

    ScrollView{
        enabled: true

        anchors.fill: parent
        verticalScrollBarPolicy: Qt.ScrollBarAlwaysOn
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOn
        EditPerson {
    }
    }

}

