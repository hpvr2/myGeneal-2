import QtQuick 2.7
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import "Gedcom.js" as Gedcom
import "EditPage.js" as EditPage
import "ExternalData.js" as External


// This is the main Page for Reading and editing


EditPersonForm {
    buttonCloseOptions.onClicked: {
        header   = textEditHeader.text
        trailer = textEditTrailer.text
        rectOptions.visible= false
        rectPerson.visible=true
    }



    anchors.fill: parent

    Component.onCompleted: {             // startup : read CSV or switch to options
        var fileid1 = standard.path +"/p-autosave.csv"
        var fileid2 = standard.path +"/f-autosave.csv"
        if (genealFile.fileExists(fileid1) === true && genealFile.fileExists(fileid2) === true) {
            External.readCSV_P(fileid1)
            External.readCSV_F(fileid2)

            var fileid = standard.path + "/header-data.ged"
            console.log(genealFile.fileExists(fileid))

            var x = genealFile.readFile(fileid)
            textEditHeader.append(x)

            fileid = standard.path + "/trailer-data.ged"
            console.log(genealFile.fileExists(fileid))

            x = genealFile.readFile(fileid)
            textEditTrailer.append(x)

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
    buttonDiscoPartner.onClicked: {
        msgDiscoFamily()

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
        person.prt("nextFam")
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

        for  (var i= actualId+1;i<maxid;i++){
            if  (persons[i].pid === -1 )continue
            else {actualId = i;break}
        }
        if (actualId===maxid-1) actualId = 1
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
        if  (p1.pid === "-1")   // new child
        {   rectSelect.visible= true
            EditPage.select("child","",persons[actualId].surName,
                            persons[actualId].birthYear()+14,
                            persons[actualId].birthYear()+50)
        }
        else                  // existing person
        {  actualId = p1.pid
            actualFam = 0
        }
        EditPage.setRelatives(actualId)
    }
    tabViewPartners.onClicked: {          // switch to partner or display partner selection ( TODO )
        var p1 = partners.get(row)
        selectGender = "M"
        if  (p1.pid === "-1")   // new partner
        {
            lastId = actualId

            rectSelect.visible= true
            if (persons[actualId].gender === "M") selectGender = "F"
            EditPage.select("partner",selectGender,"",
                            persons[actualId].birthYear()-20,
                            persons[actualId].birthYear()+20)
        }
        else {
            actualId = p1.pid
            actualFam = 0
            persons[actualId].prt("partner selected, before set")
            EditPage.setRelatives(actualId)
        }
    }
    tabViewParents.onClicked: {           // switch to parent or display parent selection ( TODO )
        var p1 = parents.get(row)
        switch(p1.pid )  {
        case "-1" : {// father
            rectSelect.visible= true
            EditPage.select("parent","M",persons[actualId].surName,
                            persons[actualId].birthYear()-40,
                            persons[actualId].birthYear()-15)
            break
        }
        case "-2" : {
            rectSelect.visible= true
            EditPage.select("parent","F","",
                            persons[actualId].birthYear()-40,
                            persons[actualId].birthYear()-15)
            break
        }
        default : {
            actualId = p1.pid
            actualFam = 0
            persons[actualId].prt("parent selected, before set")
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
            break

        case "partner" :
            persons[actualId].prt("select partner")
            msgNewFamily(lastId,actualId)
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
        onYes: {
            if ( this.title === "Select child" ) { print("assuming Male"); p1 = "M"}
            if ( this.title === "Disconnect from parents ?" ) {
                EditPage.discoParents(actualId)
                if ( selectCase === "child" ) EditPage.connParents(actualId,family.pid)
                EditPage.setRelatives(actualId)

            }
            if ( this.title === "Create new family ?" ) {
                EditPage.addFamily (lastId,actualId)
                EditPage.setRelatives(actualId)

            }
            if ( this.title === "Delete family ?" ) {
                EditPage.deleteFamily()
                EditPage.setRelatives(actualId)

            }
            if ( this.title === "Delete person" ) {
                person= persons[actualId]
                var i = families[person.childOfFamily].children.indexOf(person.pid)
                families[person.childOfFamily].children.splice(i,1)
                for (var id in person.parentInFamily){
                    if (person.gender === "M") families[person.parentInFamily[id]].husband = ""
                    else families[person.parentInFamily[id]].wife = ""
                    unusedPersons.push(actualId)
                }
                persons[person.id]= persons[0]
            }
            if ( this.title === "initial" )       { print("unkown message dialog : "+this.title)}

        }
        onNo: {print("NO pressed for : "+this.title)
            if ( this.title === "Select child" ) { print("assuming Female"); p1 = "F"}
            if ( this.title === "Disconnect from parents ?" ) {

            }
            if ( this.title === "Create new family ?" ) {

            }
        }

        onRejected: {print("aborted : "+this.title)

        }
    }

    function msgDiscoFamily(){
        var nl = "\n"
        msgBox.title = "Delete family ?"
        msgBox.text = "Delete family : " + persons[families[actualFamId].husband].givenName
                + " " + persons[families[actualFamId].husband].surName
                + " & " +                  persons[families[actualFamId].wife].givenName + " "
                + persons[families[actualFamId].wife].surName
                + nl +"           and " +families[actualFamId].children.length + " children "+" ? "
        msgBox.detailedText = " Disconnect both partners & children from family, delete family"
        msgBox.visible = true
    }
    function msgDiscoParents(p1){
        msgBox.title = "Disconnect from parents ?"
        msgBox.text = p1.father().givenName + " " + p1.father().surName + " & "
                + p1.mother().givenName + " "  + p1.mother().surName
        msgBox.detailedText = " TODO : detail text"
        msgBox.visible = true
    }
    function msgNewFamily(){
        msgBox.title = "Create new family ?"
        msgBox.text = "New family : " + persons[lastId].givenName + " " + persons[lastId].surName
                + " & " + persons[actualId].givenName + " " + persons[actualId].surName +" ? "
        msgBox.detailedText = " Create new family and connect hasband & wife"
        msgBox.visible = true
    }
    // Option Buttons

    buttonWriteHtml.onClicked: {          // write html files ( TODO )
        External.writeHtmlP1()
    }
    buttonSave.onClicked: {               // save screen data & write CSV
        EditPage.saveScreen()
        External.writeCSV()
//        External.writeHeader()
//        External.writeTrailer()
    }
    buttonWriteGedcom.onClicked: {        // write GEDCOM file
        Gedcom.writeGedcom()
    }
    buttonReadGedcom.onClicked: {         // read GEDCOM file ( TODO : cleabup before reading )
        fileDialog.visible = true
        rectOptions.visible = false
    }
    buttonShowDocs.onClicked: {
        docsDialog.folder = standard.path + "/Archiv/" + actualId
        docsDialog.visible = true
    }

    FileDialog {                          // file dialog for show documents
        id: docsDialog
        title: "Show Personal Documents"
        onAccepted: {
            Qt.openUrlExternally(fileUrls)
        }
        onRejected: { console.log("Canceled") }
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
            //TEST         for( i in persons){persons[i].prt()}


            //          families.length = 0
            Gedcom.parseFAM(a)                                      // parse FAM data
            //TEST          for( i in families){families[i].prt()}

            //            Gedcom.writeGedcom()


            trailer.length = 0
            Gedcom.parseTRAILER(a)                               // parse Header data
            console.log("##########################################")

            External.writeCSV()                                     //TODO : move to closing code

            actualId = 1
            lastId = 0
            actualFam = 0
            actualFamId = 0

            parentFamily =null
            partnerFamily =null
            family= null
            person= null

            selectInit = true
            selectCase= "person"
            selectGender= ""
            selectName = ""

            lastfamId = 0

            rectOptions.visible=false
            rectPerson.visible=true
            actualId="1"

            for ( var i in persons){
                personsSort[i]= {
                    yb: persons[i].birthYear(),
                    yd: persons[i].deathYear(),
                    gn: persons[i].givenName,sn: persons[i].surName,
                    gender:persons[i].gender}

            }

            //   personsSort=persons.slice() // copy of persons
            personsSort.sort(function(a, b){return a.birthYear - b.birthYear})


        }
        onRejected: { console.log("Canceled") }
    }
}







