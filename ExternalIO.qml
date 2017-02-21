
import QtQuick 2.7
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import "Gedcom.js" as Gedcom
import "EditPage.js" as EditPage
import "ExternalData.js" as External


// This is the main Page for external IO


ExternalIOForm {
     property var header :[]

    buttonReadGedcom.onClicked: {
        fileDialog.visible = true
        rectOptions.visible = false
    }

    buttonHide.onClicked: {
        rectOptions.visible = false

    }


    FileDialog {
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
            //            for ( var i = 0 ; i<header.length; i++) print(header[i])

            persons.length = 0
            personIndex.length = 0
            Gedcom.parseINDI(a)              // parse INDI data
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
                    }
        onRejected: { console.log("Canceled") }

    }

}

