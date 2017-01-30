import QtQuick 2.7
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import "Gedcom.js" as Gedcom
import "EditPage.js" as EditPage


// This is the main Page for Reading and editing

// todo: set initial values and read INI File
// todo: If Available, read CSV


Page1Form {
    property int actualId : 0

    property int startHeader :0
    property int startIndi :0
    property int startFam : 0
    property int startTrailer:0

    property var header :[]
    property var persons :[]
    property var families :[]
    property var trailer : []

    property Family parentFamily :null
    property Family partnerFamily :null
    property Family  family: null

    property string selectGender: ""
    property string selectName : ""
    property int selectFrom: 0    //todo variable year
    property int selectTo : 2017
    // todo variable year

    radioButtonFemale.onClicked: {
        radioButtonMale.checked=false
        radioButtonUnknown.checked=false
        selectGender = "F"
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}
    radioButtonMale.onClicked: {
        radioButtonFemale.checked=false
        radioButtonUnknown.checked=false
        selectGender = "M"
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}
    radioButtonUnknown.onClicked: {
        radioButtonFemale.checked=false
        radioButtonMale.checked=false
        selectGender = ""
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}

    textFieldSelectName.onTextChanged: {selectName = textFieldSelectName.text
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}
    textFieldSelectFrom.onTextChanged: {selectFrom = textFieldSelectFrom.text
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}
    textFieldSelectTo.onTextChanged: {selectTo = textFieldSelectTo.text
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}

    buttonSelectOther.onClicked: {
        if (rectSelect.visible) {EditPage.select(selectGender,selectName,selectFrom,selectTo) }
        else{rectSelect.visible = true}

    }

    buttonOptions.onClicked: {
        if (rectOptions.visible) {rectOptions.visible= false }
        else{rectOptions.visible = true}
    }

    mouseAreaChilds.onClicked: {
        var p1 = childs.get(listViewChilds.indexAt(mouseAreaChilds.mouseX,mouseAreaChilds.mouseY))
        actualId = p1.pid
        EditPage.setRelatives(actualId)
    }
    mouseAreaPartners.onClicked: {
        var p1 = partners.get(listViewPartners.indexAt(mouseAreaPartners.mouseX,mouseAreaPartners.mouseY))
        actualId = p1.pid
        EditPage.setRelatives(actualId)
    }
    mouseAreaParents.onClicked: {
        var p1 = parents.get(listViewParents.indexAt(mouseAreaParents.mouseX,mouseAreaParents.mouseY))
        actualId = p1.pid
        EditPage.setRelatives(actualId)
    }
    mouseAreaSelect.onClicked: {
        var p1 = selection.get(listViewSelect.indexAt(mouseAreaSelect.mouseX,mouseAreaSelect.mouseY))
        actualId = p1.pid
        EditPage.setRelatives(actualId)
        rectSelect.visible= false
    }
    textFieldGivenName.onTextChanged: {person.givenName = textFieldGivenName.text }


    // Enter filedialog for Gedcom File and store data in Objects : persons , families


    Item{
    }

    FileDialog {
        id: fileDialog
        title: "Please select Gedcom file"
        folder: appWindow.settings.path


        onAccepted: {
            var fileid = fileDialog.fileUrls[0]
            console.log(genealFile.fileExists(fileid) + fileid)

            var text = genealFile.readFile(fileid);          // read file and split into lines
            var a = text.split("\r\n");

            // parse HEADER data
            var header = []
            header = Gedcom.parseHEADER(a)

            // parse INDI data
            persons = Gedcom.parseINDI(a)
            // parse FAM data
            families = Gedcom.parseFAM(a)
            console.log("##########################################")

        }
        onRejected: { console.log("Canceled") }
    }
    ListModel{ id :parents  }
    ListModel{ id :partners }
    ListModel{ id :childs   }
    ListModel{ id :selection }


    buttonReadGedcom.onClicked: {
        fileDialog.visible = true
        rectOptions.visible = false
    }

    buttonNextFamily.onClicked: {     }


    buttonNextId.onClicked: {                   // switch to next pid
        print("button next "+actualId)
        actualId : actualId++
        EditPage.setRelatives(actualId)
    }


    buttonWriteGedcom.onClicked : {Gedcom.writeGedcom()}
}




