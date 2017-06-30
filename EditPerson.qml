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
        print("startup, check csv")
        var fileid1 = standard.path +"/p-autosave.csv"
        var fileid2 = standard.path +"/f-autosave.csv"
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
        actualId = "1"
        EditPage.setRelatives(actualId)
    }

    // Select buttons & fields

    buttonAddStop.onClicked: {           // stop selection screen
        rectSelect.visible= false
        print("selection stopped")
    }
    buttonDiscoParents.onClicked: {      // disconnect parents
        persons[actualId].prt()
        msgDiscoParents(persons[actualId])
}
    buttonAddPerson.onClicked: {       // add new person
        rectSelect.visible= false
        if ( radioButtonFemale.checked === true ) EditPage.addPerson("F",persons[actualId].surName)
        else {
            if ( radioButtonMale.checked === true ) EditPage.addPerson("M",persons[actualId].surName)
            else EditPage.addPerson("",persons[actualId].surName)
        }
    }

    radioButtonFemale.onClicked: {       // filter selection on females

        selectGender = "F"
        EditPage.select(selectCase,selectGender,
                        selectName,selectFrom,selectTo)
    }
    radioButtonMale.onClicked: {         // filter selection on males

        selectGender = "M"
        EditPage.select(selectCase,selectGender,
                        selectName,selectFrom,selectTo)
    }
    radioButtonUnknown.onClicked: {      // reset gender filert for selection

        selectGender = ""
        EditPage.select(selectCase,selectGender,
                        selectName,selectFrom,selectTo)
    }


    textFieldSelectName.onTextChanged: { // filter selection on surname
        if ( !selectInit) {
            selectName = textFieldSelectName.text
            EditPage.select(selectCase,selectGender,
                            selectName,selectFrom,selectTo)
        }
    }
    textFieldSelectFrom.onTextChanged: { // filter selection on birthday from
        if ( !selectInit) {
            if (textFieldSelectFrom.text === "" ) selectFrom = 0
            else selectFrom = parseInt(textFieldSelectFrom.text)
            EditPage.select(selectCase,selectGender,
                            selectName,selectFrom,selectTo)
        }
    }
    textFieldSelectTo.onTextChanged: {   // filter selection on birthday to
        if ( !selectInit) {
            if (textFieldSelectTo.text === "" ) selectTo = 0
            else selectTo = parseInt(textFieldSelectTo.text)
            EditPage.select(selectCase,selectGender,
                            selectName,selectFrom,selectTo)
        }
    }

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
        EditPage.setRelatives(actualId)
    }
    buttonSelectOther.onClicked: {        // select another person for display
        rectSelect.visible= true
        textFieldSelectFrom.text = standard.firstYear
        textFieldSelectTo.text   = standard.lastYear

        EditPage.select("person","","",selectFrom,selectTo)
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

        for  (var i= actualId+1;i<persons.length;i++){
            if  (persons[i].pid === -1 )continue
            else {actualId = i;break}
        }
        if (actualId===persons.length-1) actualId = 1
        actualFam = 0
        EditPage.setRelatives(actualId)
    }
    buttonShowAnchester.onClicked: {      // switch to anchester tree  ( TODO )
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
            print("TODO : use fathers name as default")
            EditPage.select("child","",persons[actualId].surName,
                            parseInt(persons[actualId].yearOf(persons[actualId].birthDate)+14),
                            parseInt(persons[actualId].yearOf(persons[actualId].birthDate)+50))

        }
        else                  // existing person
        {
            actualId = p1.pid
            actualFam = 0

        }
        EditPage.setRelatives(actualId)
    }
    tabViewPartners.onClicked: {          // switch to partner or display partner selection ( TODO )
        print(" TODO : switch to partner or display partner selection ")
        var p1 = partners.get(row)
        selectGender = "M"
        if  (p1.pid === -1)   // new partner
        {
            rectSelect.visible= true
            var genderSelect = "M"
            if (persons[actualId].gender === "M") genderSelect = "F"

            EditPage.select("partner",genderSelect,persons[actualId].surName,
                            parseInt(persons[actualId].birthYear)-40,
                            parseInt(persons[actualId].birthYear)+50)
        }
        else {
            actualId = p1.pid
            actualFam = 0
            EditPage.setRelatives(actualId)
        }
    }
    tabViewParents.onClicked: {           // switch to parent or display parent selection ( TODO )
        print(" switch to parent or display parent selection ( TODO )")
        var p1 = parents.get(row)
        switch(p1.pid )  {
        case "-1" : {// father
            rectSelect.visible= true
            EditPage.select("parent","M",persons[actualId].surName,
                            parseInt(persons[actualId].birthYear)-40,
                            parseInt(persons[actualId].birthYear)-15)
            break
        }
        case "-2" : {
            rectSelect.visible= true
            EditPage.select("parent","F","",
                            parseInt(persons[actualId].birthYear)-40,
                            parseInt(persons[actualId].birthYear)-15)
            break
        }
        default : {
            actualId = p1.pid
            actualFam = 0
            EditPage.setRelatives(actualId)
        }}
    }
    tabViewSelect.onClicked: {            // switch to  selection  screen
        var p1 = selectOther.get(row)
        actualId = p1.pid
        person= persons[actualId]
        actualFam = 0
        rectSelect.visible= false
        switch ( selectCase ){
        case "person":
            EditPage.setRelatives(actualId)
            break
        case "child" :
            person.prt("case child")
            if ( person.childOfFamily === 0 ) {
                print(actualId)
                partnerFamily.prt("child")
                EditPage.connParents(actualId,partnerFamily.pid)
                EditPage.setRelatives(actualId)
            }
            else {
               msgDiscoParents(persons[actualId])
            }
            break

        case "parent" :
            persons[actualId].prt()
            print("TODO : disconnect function before select parents")
            break

        case "partner" :
            persons[actualId].prt()
            print("TODO : disconnect function before select partner")
            break

        }
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
            if ( this.title === "Disconnect from parents ?" ) {
                EditPage.discoParents(actualId)
                if ( selectCase === "child" ) EditPage.connParents(actualId,partnerFamily.pid)
                EditPage.setRelatives(actualId)

            }

            if ( this.title === "Delete person" ) { print("action delete person")}
            if ( this.title === "initial" )       { print("unkown message dialog : "+this.title)}

        }
        onNo: {print("NO pressed for : "+this.title)
            if ( this.title === "Select child" ) { print("assuming Female"); p1 = "F"}
            if ( this.title === "Disconnect from parents ?" ) {
                print("dont Disconnect from parents ?")

            }
        }

        onRejected: {print("aborted : "+this.title)

        }
    }
    function msgDiscoParents(p1){
        msgBox.title = "Disconnect from parents ?"
        msgBox.text = p1.father().givenName + " " + p1.father().surName + " & "
                + p1.mother().givenName + " "  + p1.mother().surName
        msgBox.detailedText = " TODO : detail text"
        msgBox.visible = true
    }

    // Option Buttons

    buttonWriteHtml.onClicked: {          // write html files ( TODO )
        External.writeHtmlP1()
    }
    buttonSave.onClicked: {               // save screen data & write CSV
        EditPage.saveScreen()
        External.writeCSV()
    }
    buttonReadCSV.onClicked: {            // read CSV data ( is this necessary ? )

        var fileid = standard.path+"/p-autosave.csv"
        External.readCSV_P(fileid)

        fileid = standard.path+"/f-autosave.csv"
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
            console.log(genealFile.fileExists(fileid) + fileid)

            var text = genealFile.readFile(fileid);          // read file and split into lines
            var a = text.split("\n");

            header.length = 0
            Gedcom.parseHEADER(a)                               // parse Header data

//            persons.length = 0
            Gedcom.parseINDI(a)              // parse INDI data

  //          families.length = 0
            Gedcom.parseFAM(a)                                      // parse FAM data

//  for(var i in persons){
//     persons[i].prt("after parseFAM")
//  }
            trailer.length = 0
            Gedcom.parseTRAILER(a)                               // parse Header data
            console.log("##########################################")

            External.writeCSV()                                     //TODO : move to closing code
            rectOptions.visible=false
            rectPerson.visible=true

            for ( var i in persons){
                personsSort[i]= {
                    yb: parseInt(persons[i].yearOf(persons[i].birthDate)),
                    yd: parseInt(persons[i].yearOf(persons[i].deathDate)),
                    gn: persons[i].givenName,sn: persons[i].surName,
                    gender:persons[i].gender}

     //           print(personsSort[i].yb,personsSort[i].yd,personsSort[i].gn,personsSort[i].sn,personsSort[i].gender                      )
            }

            //   personsSort=persons.slice() // copy of persons
            personsSort.sort(function(a, b){return a.birthYear - b.birthYear});

        }
        onRejected: { console.log("Canceled") }
    }
}







