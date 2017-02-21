import QtQuick 2.7
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import "Gedcom.js" as Gedcom
import "EditPage.js" as EditPage
import "ExternalData.js" as External


// This is the main Page for Reading and editing


EditPersonForm {

    MessageDialog{
        id : msgBox
        title: "initial"
        text : " initial ?"
        detailedText: "initial"
        standardButtons: StandardButton.Yes | StandardButton.No
        Component.onCompleted: visible = false
        onYes: {print(this.title)
            if ( this.title === "Add new person" ) {
                EditPage.addPerson()
            }

            if ( this.title === "Delete person" ) { print("action delete person")}

            if ( this.title === "initial" ) {print("unkown message dialog : "+this.title)}

        }
            onNo: print("NO pressed for : "+this.title)
            onRejected: print("aborted : "+this.title)

    }


    buttonAddNewPerson.onClicked: {
        msgBox.title= "Add new person"
        msgBox.text = " Do you want to add a new person ?"
        msgBox.detailedText= "Remember to save after completing all details"
        msgBox.visible = true

    }

    buttonDeletePerson.onClicked: {
        msgBox.title= "Delete person"
        msgBox.text = " Do you want to delete this person ?"
        msgBox.detailedText= "Remember to save after completing all details"
        msgBox.visible = true

    }

    buttonWriteHtml.onClicked: {
        External.writeHtmlP1()
}
    buttonSave.onClicked: {
        print("save")
        EditPage.saveScreen()
        External.writeCSV()
}
    anchors.fill: parent

    Component.onCompleted: {
        var fileid = "file:///C:/Users/hans-/Documents/myGeneal/p-autosave.csv"
        print(fileid)
        External.readCSV_P(fileid)

        fileid = "file:///C:/Users/hans-/Documents/myGeneal/f-autosave.csv"
        External.readCSV_F(fileid)
        rectOptions.visible=false

      }
     buttonReadCSV.onClicked: {
         var fileid = "file:///C:/Users/hans-/Documents/myGeneal/p-autosave.csv"
         print(fileid)
         External.readCSV_P(fileid)

         fileid = "file:///C:/Users/hans-/Documents/myGeneal/f-autosave.csv"
         External.readCSV_F(fileid)
         rectOptions.visible=false

     }

    buttonWriteGedcom.onClicked: {
        Gedcom.writeGedcom()
}


    //#################################### next family
    buttonNextFamily.onClicked: {
        person = persons[actualId]
        actualFam = actualFam + 1
        if ( actualFam > person.parentInFamily.length ) actualFam = 0
        EditPage.setRelatives(actualId)
    }
    //#################################### selection control
    radioButtonFemale.onClicked: {
        radioButtonMale.checked=false
        radioButtonUnknown.checked=false
        selectGender = "F"
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}
    radioButtonMale.onClicked: {print("button male")
        radioButtonFemale.checked=false
        radioButtonUnknown.checked=false
        selectGender = "M"
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}
    radioButtonUnknown.onClicked: {
        radioButtonFemale.checked=false
        radioButtonMale.checked=false
        selectGender = ""
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}

    textFieldSelectName.onTextChanged: {print("selected : "+  textFieldSelectName.text)
        selectName = textFieldSelectName.text
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}
    textFieldSelectFrom.onTextChanged: {selectFrom = textFieldSelectFrom.text
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}
    textFieldSelectTo.onTextChanged: {selectTo = textFieldSelectTo.text
        EditPage.select(selectGender,selectName,selectFrom,selectTo)}

    ListModel{ id :selection   }

    mouseAreaSelect.onClicked: {
        print(mouseAreaSelect.mouseX+ " " + mouseAreaSelect.mouseX)
        print(listViewSelect.indexAt(mouseAreaSelect.mouseX,mouseAreaSelect.mouseY))
        var p1 = selection.get(listViewSelect.indexAt(mouseAreaSelect.mouseX,mouseAreaSelect.mouseY))
        actualId = personIndex.indexOf(p1.pid)
        actualFam = 0
        EditPage.setRelatives(actualId)

        rectSelect.visible= false
    }

    buttonSelectOther.onClicked: {
        rectSelect.visible= true
        EditPage.select(selectGender,selectName,selectFrom,selectTo)

    }
    //#################################### selection control
    ListModel{ id :childs   }
    mouseAreaChilds.onClicked: {
        var p1 = childs.get(listViewChilds.indexAt(mouseAreaChilds.mouseX,mouseAreaChilds.mouseY))
        actualId = personIndex.indexOf(p1.pid)
        actualFam = 0
        EditPage.setRelatives(actualId)
    }
    ListModel{ id :partners }
    mouseAreaPartners.onClicked: {
        var p1 = partners.get(listViewPartners.indexAt(mouseAreaPartners.mouseX,mouseAreaPartners.mouseY))
        actualId = personIndex.indexOf(p1.pid)
        actualFam = 0
        EditPage.setRelatives(actualId)
    }
    ListModel{ id :parents  }
    mouseAreaParents.onClicked: {
        var p1 = parents.get(listViewParents.indexAt(mouseAreaParents.mouseX,mouseAreaParents.mouseY))
        actualId = personIndex.indexOf(p1.pid)
        actualFam = 0
        EditPage.setRelatives(actualId)
    }
    //#################################### option button
    buttonOptions.onClicked: {                                  // options
        if (rectOptions.visible) {rectOptions.visible= false }
        else{rectOptions.visible = true}
    }
    //#################################### nextid button
    buttonNextId.onClicked: {                   // switch to next pid
        //        print("button next "+actualId)
        actualId : actualId++
        actualFam = 0
        EditPage.setRelatives(actualId)
    }

    //    buttonSave.onClicked: {
    //        EditPage.saveScreen(person)
    //    }

    //    textEditHeader.onTextChanged: {

    //        for ( var i = 1; i< textEditHeader.length; i++){

    //            header[i] = String(textEditHeader[i])}
    //        print(header[i])
    //    }

    buttonReadGedcom.onClicked: {
        fileDialog.visible = true
        rectOptions.visible = false

    }


    FileDialog {
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
            personIndex.length = 0
            Gedcom.parseINDI(a)              // parse INDI data
            var xx =Math.max.apply(Math,personIndex)
            print("p-max "+xx)
            print("INDI List ####################################")
            //            for ( i = 0 ; i<persons.length; i++) print(persons[i].pid + " " +persons[i].givenName + " " + persons[i].surName)

            families.length = 0
            familyIndex.length = 0
            Gedcom.parseFAM(a)                                      // parse FAM data

            trailer.length = 0
            Gedcom.parseTRAILER(a)                               // parse Header data
            //            for ( var i = 0 ; i<trailer.length; i++) print(trailer[i])

            //            for ( i = 0 ; i<families.length; i++) print(families[i].pid + " " +families[i].marriageDate + " " + families[i].marriagePlace)

            // parse trailor  data   TODO
            console.log("##########################################")

            External.writeCSV()                                                         //TODO : move to closing code
            rectOptions.visible=false


        }
        onRejected: { console.log("Canceled") }
    }
}






