import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import "Gedcom.js" as Gedcom
import "ExternalData.js" as External
import "EditPage.js" as EditPage


ApplicationWindow {
    id: appWindow
    visible: true
    width: 1200
    height: 600
    color: "lightgrey"
    title: qsTr("myGeneal 0.2")

    property Item settings: SetInit {   }

    property int actualId : 1
    property int lastId : 0
    property int actualFam : 0
    property int actualFamId : 0

    property int startIndi :0   // TODO only for gedcom read
    property int startFam : 0   // TODO only for gedcom read
    property int startTrailer:0  // TODO only for gedcom read

    property string header : ""
    property string trailer : ""


    property var persons :({})
    property var personsSort : []
    property var families :({})
  //  property var trailer : []    // TODO only for gedcom read

    property var unusedPersons :[]
    property var unusedFamilies : []

    property Family parentFamily :null
    property Family partnerFamily :null
    property Family family: null
    property Person person: null

    property bool selectInit : true
    property string selectCase: "person"
    property string selectGender: ""
    property string selectName : ""
    property int selectFrom: standard.firstYear      //todo variable year
    property int selectTo : standard.lastYear   // actual year


    property int lastfamId : 0
    property int  maxid : 0
    property int  maxidFam : 0


    property string path : appWindow.settings.path

    property var standard :  External.setInit()

    onClosing: {
        External.writeCSV()
        External.writeHeader()
        External.writeTrailer()
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

