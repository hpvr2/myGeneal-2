import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import "Gedcom.js" as Gedcom

Item {
    id: externalpage
    width: 800
    height: 400
    property alias rectOptions: rectOptions
    property alias textWriteGedcom: textWriteGedcom
    property alias textWriteCSV: textWriteCSV
    property alias textReadCSV: textReadCSV
    property alias textWriteHtml: textWriteHtml
    property alias textEditHeader: textEditHeader
    property alias textEditTrailer: textEditTrailer
    property alias buttonHide: buttonHide
    property alias buttonWriteHtml: buttonWriteHtml
    property alias buttonReadCSV: buttonReadCSV
    property alias buttonWriteCSV: buttonWriteCSV
    property alias buttonReadGedcom: buttonReadGedcom
    property alias buttonWriteGedcom: buttonWriteGedcom

    Rectangle {
        id: rectOptions
        anchors.fill: parent

        visible: true

        GridLayout {
            id: gridLayout
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            rows: 8
            columns: 2
            anchors.fill: parent

            Button {
                id: buttonReadGedcom
                x: 0
                width: 150
                height: 40
                text: qsTr("Read Gedcom  File")
                visible: true
                anchors.top: parent.top
                anchors.topMargin: 17
                anchors.left: parent.left
                anchors.leftMargin: 28
                z: 1
                checkable: true
            }

            Text {
                id: textReadGedcom
                text: qsTr("Read external Gedcom file and start processing")
                font.pixelSize: 16
            }

            Button {
                id: buttonWriteGedcom
                width: 150
                height: 40
                text: qsTr("Write Gedcom  File")
                clip: false
                z: 2
                checked: false
                checkable: true
            }

            Text {
                id: textWriteGedcom
                text: qsTr("Write  external Gedcom file for data exchange ( TODO )")
                font.pixelSize: 16
            }

            Button {
                id: buttonWriteCSV
                width: 150
                height: 40
                text: qsTr("Write internal CSV  File")
                checkable: true
                z: 2
                checked: false
            }



            Text {
                id: textWriteCSV
                text: qsTr("Write  internal CSV file ( autosave ) ")
                font.pixelSize: 16
            }

            Button {
                id: buttonReadCSV
                width: 131
                height: 40
                text: qsTr("Read internal CSV File")
                checkable: true
                z: 2
                checked: false
            }

            Text {
                id: textReadCSV
                text: "Read internal CSV file ( default at startup ) "
                font.pixelSize: 16
            }




            Button {
                id: buttonWriteHtml
                width: 150
                height: 40
                text: qsTr("Write HTML  Files  ")
                Layout.fillWidth: false
                visible: true
                checkable: true
                z: 2
                checked: false
            }

            Text {
                id: textWriteHtml
                text: "Write HTML Files ( TODO )"
                font.pixelSize: 16
            }

            TextEdit {
                id: textEditHeader
                width: 300
                height: 200
                text: qsTr("Header :")
                font.pixelSize: 12
            }

            TextEdit {
                id: textEditTrailer
                width: 300
                height: 200
                text: qsTr("Trailer :")
                font.pixelSize: 12
            }

            Button {
                id: buttonHide
                width: 150
                height: 40
                text: qsTr("Hide Option screen")
                clip: true
                checkable: true
                z: 2
                checked: false
            }




        }
    }
}
