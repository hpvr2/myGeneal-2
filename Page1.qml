import QtQuick 2.7
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import "Gedcom.js" as Gedcom
import "EditPage.js" as EditPage
import "ExternalData.js" as External


// This is the main Page for Reading and editing

// todo: set initial values and read INI File
// todo: If Available, read CSV


Page1Form {
    property int actualId : 0

    property int startIndi :0
    property int startFam : 0
    property int startTrailer:0

    property var header :[]
    property var persons :[]
    property var families :[]
    property var trailer : []

    property var personIndex : []
    property var familyIndex : []

    property Family parentFamily :null
    property Family partnerFamily :null
    property Family family: null
    property Person person: null

    property string selectGender: ""
    property string selectName : ""
    property int selectFrom: 0      //todo variable year
    property int selectTo : 2017 // todo variable year
    textEditHeader.onTextChanged: {

        for ( var i = 1; i< textEditHeader.length; i++){

            header[i] = String(textEditHeader[i])}
            print(header[i])
}

    buttonEditHeader.onClicked: {
        print(header + "  "+ header.length)
        for ( var i = 0; i< header.length; i++){
            print("line "+i + " " +header[i])
            textEditHeader.append(String(header[i]))
        }
}
    buttonSave.onClicked: {
        EditPage.saveScreen(person)
}

    buttonReadCSV.onClicked: {
        rectOptions.visible = false
        print("before calling")
        persons = External.readCSV_P()
        print(persons)
        families = External.readCSV_F()
        print(families)}
//#################################### selection control
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

    mouseAreaChilds.onClicked: {
        var p1 = childs.get(listViewChilds.indexAt(mouseAreaChilds.mouseX,mouseAreaChilds.mouseY))
        actualId = personIndex.indexOf(p1.pid)
        EditPage.setRelatives(actualId)
    }
    mouseAreaPartners.onClicked: {
        var p1 = partners.get(listViewPartners.indexAt(mouseAreaPartners.mouseX,mouseAreaPartners.mouseY))
        actualId = personIndex.indexOf(p1.pid)
        EditPage.setRelatives(actualId)
    }
    mouseAreaParents.onClicked: {
        var p1 = parents.get(listViewParents.indexAt(mouseAreaParents.mouseX,mouseAreaParents.mouseY))
        actualId = personIndex.indexOf(p1.pid)
        EditPage.setRelatives(actualId)
    }
    mouseAreaSelect.onClicked: {
        var p1 = selection.get(listViewSelect.indexAt(mouseAreaSelect.mouseX,mouseAreaSelect.mouseY))
        actualId = personIndex.indexOf(p1.pid)
        EditPage.setRelatives(actualId)
        rectSelect.visible= false
    }

    buttonOptions.onClicked: {                                  // options
        if (rectOptions.visible) {rectOptions.visible= false }
        else{rectOptions.visible = true}
    }


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

            header.length = 0
            Gedcom.parseHEADER(a)                               // parse Header data
            for ( var i = 0 ; i<header.length; i++) print(header[i])

            persons.length = 0
            personIndex.length = 0
            Gedcom.parseINDI(a)                                 // parse INDI data
//            for ( i = 0 ; i<persons.length; i++) print(persons[i].pid + " " +persons[i].givenName + " " + persons[i].surName)

            families.length = 0
            familyIndex.length = 0
            Gedcom.parseFAM(a)                                      // parse FAM data
//            for ( i = 0 ; i<families.length; i++) print(families[i].pid + " " +families[i].marriageDate + " " + families[i].marriagePlace)

                                                                    // parse trailor  data   TODO
            console.log("##########################################")
            External.writeCSV()                                                         //TODO : move to closing code
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


    buttonWriteGedcom.onClicked : {

        Gedcom.writeGedcom()}
}




