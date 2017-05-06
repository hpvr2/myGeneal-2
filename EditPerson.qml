import QtQuick 2.7
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import "Gedcom.js" as Gedcom
import "EditPage.js" as EditPage
import "ExternalData.js" as External


// This is the main Page for Reading and editing


EditPersonForm {


    anchors.fill: parent

    Component.onCompleted: {             // startup : read CSV or switch to options
        print("close")
        var fileid1 = "file:///C:/Users/hans-/Documents/myGeneal/p-autosave.csv"
        var fileid2 = "file:///C:/Users/hans-/Documents/myGeneal/f-autosave.csv"
        print(fileid1)
        if (genealFile.fileExists(fileid1) === true && genealFile.fileExists(fileid2) === true) {
            External.readCSV_P(fileid1)
            External.readCSV_F(fileid2)
            rectOptions.visible=false
        }
        else {
            rectOptions.visible=true
            rectPerson.visible=false

        }
    }

    // Select buttons & fields

    buttonAddStop.onClicked: {           // stop selection screen
        rectSelect.visible= false
        rectPerson.visible=true
         print("add child aborted")
}
    buttonAddDaughter.onClicked: {       // add new person as daughter
        rectSelect.visible= false
        rectPerson.visible=true
         EditPage.addPerson("F",persons[actualId].surName)
        // set : person :child in fam
        // set: family : new child
    }
    buttonAddSon.onClicked: {            // add new parson as son
        rectSelect.visible= false
        rectPerson.visible=true
         EditPage.addPerson("M",persons[actualId].surName)
        // set : person :child in fam
        // set: family : new child
    }

    radioButtonFemale.onClicked: {       // filter selection on females
        radioButtonMale.checked=false
        radioButtonUnknown.checked=false
        selectGender = "F"
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}
    radioButtonMale.onClicked: {         // filter selection on males

        print("button male")
        radioButtonFemale.checked=false
        radioButtonUnknown.checked=false
        selectGender = "M"
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}
    radioButtonUnknown.onClicked: {      // reset gender filert for selection
        radioButtonFemale.checked=false
        radioButtonMale.checked=false
        selectGender = ""
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}


    textFieldSelectName.onTextChanged: { // filter selection on surname
        print("selected : "+  textFieldSelectName.text)
        selectName = textFieldSelectName.text
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}
    textFieldSelectFrom.onTextChanged: { // filter selection on birthday from
        selectFrom = textFieldSelectFrom.text
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}
    textFieldSelectTo.onTextChanged: {   // filter selection on birthday to
        selectTo = textFieldSelectTo.text
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}

    // Main Page buttons

    buttonGender.onClicked: {             // switch gender
        persons[actualId].prt()
        if (persons[actualId].gender === "M" ) persons[actualId].gender="F"
        else persons[actualId].gender="M"
        EditPage.setRelatives(actualId)
}
    buttonAddNewPerson.onClicked:{        // add new person
        EditPage.addPerson("","")
    }
    buttonDeletePerson.onClicked: {       // delete person ( TODO )
        msgBox.title= "Delete person"
        msgBox.text = " Do you want to delete this person ?"
        msgBox.detailedText= "Remember to save after completing all details"
        msgBox.visible = true

    }
    buttonNextFamily.onClicked: {         // switch to next partner family
        person = persons[actualId]
        actualFam = actualFam + 1
        if ( actualFam > person.parentInFamily.length ) actualFam = 0
        EditPage.setRelatives(actualId)
    }
    buttonSelectOther.onClicked: {        // select another person for display
        rectSelect.visible= true
        //rectPerson.visible=false
        textFieldSelectFrom.text = selectFrom
        textFieldSelectTo.text   = selectTo
        selectType = "person"
        EditPage.select(selectGender,selectName,selectFrom,selectTo)

    }
    buttonOptions.onClicked: {            // switch to options screen ( TODO )
        if (rectOptions.visible) {
            rectOptions.visible= false
            rectPerson.visible=true
        }
        else{rectOptions.visible = true
            rectPerson.visible=false
        }
    }
    buttonNextId.onClicked: {             // switch to next ( sequential )pid
        //        print("button next "+actualId)

       for  (var i= actualId+1;i<persons.length;i++){
           print(i, persons[i].pid)
            if  (persons[i].pid === -1 )continue
             else {actualId = i;break}
       }
       if (actualId===persons.length-1) actualId = 1



        actualFam = 0
        EditPage.setRelatives(actualId)
    }

    // Table ViewSection
    ListModel{ id :childs   }
    ListModel{ id :partners }
    ListModel{ id :parents  }
    ListModel{ id :selectOther   }

    tabViewChildren.onClicked: {          // switch to child or display child selection
        var p1 = childs.get(row)
        if  (p1.pid === -1)   // new child
        {
            rectSelect.visible= true
            //rectPerson.visible=false
            textFieldSelectFrom.text = selectFrom
            textFieldSelectTo.text   = selectTo
            selectType= "child"

            EditPage.select("",persons[actualId].surName,parseInt(persons[actualId].birthYear)+14,parseInt(persons[actualId].birthYear)+60)
            //  break connections if wanted
            // set : person :child in fam
            // set: family : new child

        }
        else {

            actualId = p1.pid
            actualFam = 0
            EditPage.setRelatives(actualId)
            //  break connections if wanted
            // set : person :child in fam
            // set: family : new child
        }
    }
    tabViewPartners.onClicked: {          // switch to partner or display partner selection ( TODO )
        var p1 = partners.get(row)
        actualId = p1.pid
        actualFam = 0
        EditPage.setRelatives(actualId)
    }
    tabViewParents.onClicked: {           // switch to parent or display parent selection ( TODO )

        var p1 = parents.get(row)
        actualId = p1.pid
        actualFam = 0
        EditPage.setRelatives(actualId)
    }
    tabViewSelect.onClicked: {            // switch to  selection  screen
        var p1 = selectOther.get(row)
        actualId = p1.pid
        actualFam = 0
        rectSelect.visible= false
        //rectPerson.visible=true
        EditPage.setRelatives(actualId)


    }

    MessageDialog{                        // message box
        id : msgBox
        title: "initial"
        text : " initial ?"
        detailedText: "initial"
        standardButtons: StandardButton.Yes | StandardButton.No
        Component.onCompleted: visible = false
        onYes: {print(this.title)
            if ( this.title === "Select child" ) { print("assuming Male"); p1 = "M"}

            if ( this.title === "Delete person" ) { print("action delete person")}
            if ( this.title === "initial" )       { print("unkown message dialog : "+this.title)}

        }
        onNo: {print("NO pressed for : "+this.title)
            if ( this.title === "Select child" ) { print("assuming Female"); p1 = "F"}
        }
        onRejected: {print("aborted : "+this.title)

        }
    }


    // Option Buttons

    buttonWriteHtml.onClicked: {          // write html files ( TODO )
        External.writeHtmlP1()
    }
    buttonSave.onClicked: {               // save screen data & write CSV
        print("save")
        EditPage.saveScreen()
        External.writeCSV()
    }
    buttonReadCSV.onClicked: {            // read CSV data ( is this necessary ? )

        var fileid = "file:///C:/Users/hans-/Documents/myGeneal/p-autosave.csv"
        print(fileid)
        External.readCSV_P(fileid)

        fileid = "file:///C:/Users/hans-/Documents/myGeneal/f-autosave.csv"
        External.readCSV_F(fileid)
        rectOptions.visible=false

    }
    buttonWriteGedcom.onClicked: {        // write GEDCOM file

        Gedcom.writeGedcom()
    }
    buttonReadGedcom.onClicked: {         // read GEDCOM file ( TODO : cleabup before reading )
        fileDialog.visible = true
        rectOptions.visible = false

    }

    FileDialog {                          // file dialog for read GEDCOM
        id: fileDialog
        title: "Please select Gedcom file"
        folder: appWindow.settings.path


        onAccepted: {
            var fileid = fileDialog.fileUrls[0]
            print(fileid)
            console.log(genealFile.fileExists(fileid) + fileid)

            var text = genealFile.readFile(fileid);          // read file and split into lines
            var a = text.split("\n");

            header.length = 0
            Gedcom.parseHEADER(a)                               // parse Header data
            //            for ( var i = 0 ; i<header.length; i++) print(header[i])

            persons.length = 0
            Gedcom.parseINDI(a)              // parse INDI data
            //            for ( i = 0 ; i<persons.length; i++) print(persons[i].pid + " " +persons[i].givenName + " " + persons[i].surName)

            families.length = 0
            Gedcom.parseFAM(a)                                      // parse FAM data

            trailer.length = 0
            Gedcom.parseTRAILER(a)                               // parse Header data
            //            for ( var i = 0 ; i<trailer.length; i++) print(trailer[i])

            //            for ( i = 0 ; i<families.length; i++) print(families[i].pid + " " +families[i].marriageDate + " " + families[i].marriagePlace)

            // parse trailor  data   TODO
            console.log("##########################################")

            External.writeCSV()                                                         //TODO : move to closing code
            rectOptions.visible=false
            rectPerson.visible=true


        }
        onRejected: { console.log("Canceled") }
    }


}







