import QtQuick 2.7
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import "Gedcom.js" as Gedcom

// This is the main Page for Reading and editing

// todo: set initial values and read INI File
// todo: If Available, read CSV


Page1Form {
    property int actualId : 0


    property var persons :[]
    property var families :[]
    property Family parentFamily :null
    property Family partnerFamily :null

    property Person person : null

    property string selectGender: ""
    property string selectName : ""
    property int selectFrom: 0    //todo variable year
    property int selectTo : 2017
     // todo variable year

    radioButtonFemale.onClicked: {
        radioButtonMale.checked=false
        radioButtonUnknown.checked=false
        selectGender = "F"
        Gedcom.select(selectGender,selectName,selectFrom,selectTo)}
    radioButtonMale.onClicked: {
        radioButtonFemale.checked=false
        radioButtonUnknown.checked=false
        selectGender = "M"
        Gedcom.select(selectGender,selectName,selectFrom,selectTo)}
    radioButtonUnknown.onClicked: {
        radioButtonFemale.checked=false
        radioButtonMale.checked=false
        selectGender = ""
        Gedcom.select(selectGender,selectName,selectFrom,selectTo)}




    textFieldSelectName.onTextChanged: {selectName = textFieldSelectName.text
        Gedcom.select(selectGender,selectName,selectFrom,selectTo)}
    textFieldSelectFrom.onTextChanged: {selectFrom = textFieldSelectFrom.text
        Gedcom.select(selectGender,selectName,selectFrom,selectTo)}
    textFieldSelectTo.onTextChanged: {selectTo = textFieldSelectTo.text
        Gedcom.select(selectGender,selectName,selectFrom,selectTo)}

    buttonSelectOther.onClicked: {
        if (rectSelect.visible) {Gedcom.select(selectGender,selectName,selectFrom,selectTo) }
        else{rectSelect.visible = true}

}





    buttonOptions.onClicked: {
        if (rectOptions.visible) {rectOptions.visible= false }
        else{rectOptions.visible = true}
    }

    mouseAreaChilds.onClicked: {
        var p1 = childs.get(listViewChilds.indexAt(mouseAreaChilds.mouseX,mouseAreaChilds.mouseY))
        actualId = p1.pid
        Gedcom.setRelatives(actualId)
}
    mouseAreaPartners.onClicked: {
        var p1 = partners.get(listViewPartners.indexAt(mouseAreaPartners.mouseX,mouseAreaPartners.mouseY))
        actualId = p1.pid
        Gedcom.setRelatives(actualId)
    }

    mouseAreaParents.onClicked: {
        var p1 = parents.get(listViewParents.indexAt(mouseAreaParents.mouseX,mouseAreaParents.mouseY))
        actualId = p1.pid
        Gedcom.setRelatives(actualId)
    }

    mouseAreaSelect.onClicked: {

        var p1 = selection.get(listViewSelect.indexAt(mouseAreaSelect.mouseX,mouseAreaSelect.mouseY))
        print(mouseAreaSelect.mouseX+ " " +mouseAreaSelect.mouseY)
        print(listViewSelect.indexAt(mouseAreaSelect.mouseX,mouseAreaSelect.mouseY))
        actualId = p1.pid
        Gedcom.setRelatives(actualId)
        rectSelect.visible= false
}


    labelPid.text : "Person Id : " +    person.pid

    rectangleGender.color:   ( person.gender== "M") ? "cyan" : "pink"

    textFieldGivenName.text: person.givenName
    textFieldSurName.text: person.surName
    textFieldBirthDate.text: person.birthDate
    textFieldBirthPlace.text: person.birthPlace
    textFieldDeathDate.text: person.deathDate
    textFieldDeathPlace.text: person.deathPlace
    textFieldOccupation.text: person.occupation

    textEditPnote.text: person.note

    textFieldMarryDate.text: partnerFamily.marriageDate
    textFieldMarryPlace.text: partnerFamily.marriagePlace
    textFieldDivorceDate.text: partnerFamily.divorceDate
    textFieldDivorcePlace.text: partnerFamily.divorcePlace

    textFieldGivenName.onTextChanged: {person.givenName = textFieldGivenName.text }  // do this only on button save clicked

    // Enter filedialog for Gedcom File and store data in Objects : persons , families


    Item{
    }

    FileDialog {
        id: fileDialog
        title: "Please select Gedcom file"
        folder: appWindow.settings.path


        onAccepted: {
            var fileid = fileDialog.fileUrls[0]
            //            print(fileid)
            console.log(genealFile.fileExists(fileid))

            var text = genealFile.readFile(fileid);          // read file and split into lines
            var a = text.split("\r\n");

            persons = []
            // parse INDI data
            persons = Gedcom.parseINDI(a)


            // parse FAM data
            families = Gedcom.parseFAM(a)

            // console.log(p)
            console.log("##########################################")
            //            for (var i = 0; i < 10; i++) { persons[i].prt() }
            //            for (var i = 0; i < 10; i++) {families[i].prt() }

        }
        onRejected: { console.log("Canceled") }
    }
    ListModel{ id :parents  }
    ListModel{ id :partners }
    ListModel{ id :childs   }
    ListModel{ id :selection }


    buttonReadGedcom.onClicked: {
        //        console.log("Read Gedcom")
        fileDialog.visible = true


        // buttonReadGedcom.visible = false
        rectOptions.visible = false



    }

    buttonNextFamily.onClicked: {     }


    buttonNextId.onClicked: {                   // switch to next pid
        actualId : actualId++
        Gedcom.setRelatives(actualId)
    }


    buttonWriteGedcom.onClicked : {Gedcom.writeGedcom()}
}




