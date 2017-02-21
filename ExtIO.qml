import QtQuick 2.7
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import "Gedcom.js" as Gedcom
import "EditPage.js" as EditPage
import "ExternalData.js" as External


// This is the main Page for external IO


ExtIOForm {

    buttonHide.onClicked: {
        rectOptions.z = -1

    }

}
