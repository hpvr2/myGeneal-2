import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import "Gedcom.js" as Gedcom

Item {
    id: item1

    property alias buttonReadGedcom: buttonReadGedcom
    property alias labelPid: labelPid
    property alias textFieldGivenName: textFieldGivenName
    property alias textFieldSurName: textFieldSurName
    property alias buttonNextFamily: buttonNextFamily
    property alias textFieldOccupation: textFieldOccupation
    property alias textFieldDivorceDate: textFieldDivorceDate
    property alias textFieldDivorcePlace: textFieldDivorcePlace
    property alias textFieldMarryPlace: textFieldMarryPlace
    property alias textFieldMarryDate: textFieldMarryDate
    property alias textFieldDeathDate: textFieldDeathDate
    property alias buttonNextId: buttonNextId
    property alias textFieldBirthDate: textFieldBirthDate
    property alias textFieldBirthPlace: textFieldBirthPlace
    property alias textFieldDeathPlace: textFieldDeathPlace
    property alias rectangleGender: rectangleGender
    property alias textEditPnote: textEditPnote
    property alias textEditMessages: textEditMessages
    property alias buttonWriteGedcom: buttonWriteGedcom
    property alias listViewParents: listViewParents
    property alias listViewPartners: listViewPartners
    property alias listViewChilds: listViewChilds
    property alias mouseAreaParents: mouseAreaParents
    property alias mouseAreaChilds: mouseAreaChilds
    property alias mouseAreaPartners: mouseAreaPartners
    property alias buttonOptions: buttonOptions
    property alias buttonDiscoParents: buttonDiscoParents
    property alias buttonDiscoPartner: buttonDiscoPartner
    property alias buttonDiscoChild: buttonDiscoChild
    property alias buttonSelectOther: buttonSelectOther
    property alias buttonPrevious: buttonPrevious
    property alias buttonAddNewPerson: buttonAddNewPerson
    property alias buttonDeletePerson: buttonDeletePerson
    property alias buttonShowDocs: buttonShowDocs
    property alias buttonShowAnchesterTree: buttonShowAnchesterTree
    property alias buttonWriteCSV: buttonWriteCSV
    property alias buttonReadCSV: buttonReadCSV
    property alias buttonWriteHtml: buttonWriteHtml
    property alias rectOptions: rectOptions
    property alias rectSelect: rectSelect
    property alias mouseAreaSelect: mouseAreaSelect
    property alias listViewSelect: listViewSelect
    property alias radioButtonMale: radioButtonMale
    property alias radioButtonFemale: radioButtonFemale
    property alias radioButtonUnknown: radioButtonUnknown
    property alias groupBox: groupBox
    property alias textFieldSelectTo: textFieldSelectTo
    property alias textFieldSelectFrom: textFieldSelectFrom
    property alias textFieldSelectName: textFieldSelectName
    property alias textSelection: textSelection
    height: 800
    property alias textEditHeader: textEditHeader
    property alias buttonEditHeader: buttonEditHeader
    property alias buttonSave: buttonSave

    width: 1000
    z: 2147483646

    ListView{
        id: listViewParents
        x: 470
        y: 52
        width:200
        height: 71
        model :parents
        delegate: Text{
            text: bYear +"-"+dYear+" " + givenName + surName
        }
        //       highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true

        MouseArea {
            id: mouseAreaParents
            anchors.fill: parent
        }


    }
    ListView{
        id: listViewPartners
        x: 470
        y: 161
        width:200
        height: 71
        model :partners
        delegate: Text{
            text: bYear +"-"+dYear+" " + givenName + surName
        }
        //       highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true


        MouseArea {
            id: mouseAreaPartners
            anchors.fill: parent
        }
    }
    Button {
        id: buttonNextFamily
        x: 239
        y: 219
        width: 100
        height: 18
        text: qsTr("next family")
        checked: true
    }
    Label {
        id: labelPid
        x: 21
        y: 21
        width: 85
        height: 13
        text: qsTr("Person Id :     ")
    }
    TextField {

        id: textFieldGivenName
        x: 21
        y: 52
        width: 198
        height: 27
        text: qsTr("* Givenname")


    }
    TextField {
        id: textFieldBirthPlace
        x: 239
        y: 115
        width: 198
        height: 27
        text: qsTr("*  Birthplace")
    }
    TextField {
        id: textFieldBirthDate
        x: 21
        y: 115
        width: 198
        height: 27
        text: qsTr("*  Birthdate")
    }
    TextField {
        id: textFieldSurName
        x: 239
        y: 52
        width: 198
        height: 27
        text: qsTr("*  Surname")
    }
    Label {
        id: labelDied
        x: 21
        y: 154
        width: 85
        height: 13
        text: qsTr("Died : ")
    }
    Label {
        id: labelBorn
        x: 21
        y: 85
        width: 85
        height: 13
        text: qsTr("Born :     ")
    }
    TextField {
        id: textFieldDeathPlace
        x: 239
        y: 179
        width: 198
        height: 27
        text: qsTr("*  Deathplace")
    }
    TextField {
        id: textFieldDeathDate
        x: 21
        y: 179
        width: 198
        height: 27
        text: qsTr("*  Deathdate")
    }
    Label {
        id: labelMarried
        x: 21
        y: 219
        width: 85
        height: 13
        text: qsTr("Married in family ....")
    }
    TextField {
        id: textFieldDivorcePlace
        x: 239
        y: 309
        width: 198
        height: 27
        text: qsTr("*  Divorceplace")
    }
    TextField {
        id: textFieldDivorceDate
        x: 21
        y: 309
        width: 198
        height: 27
        text: qsTr("*  Divorcedate")
    }
    TextField {
        id: textFieldMarryPlace
        x: 239
        y: 243
        width: 198
        height: 27
        text: qsTr("*  Marryplace")
    }
    TextField {
        id: textFieldMarryDate
        x: 21
        y: 243
        width: 198
        height: 27
        text: qsTr("*  Marrydate")
    }
    Label {
        id: labelDivorced
        x: 21
        y: 282
        width: 85
        height: 13
        text: qsTr("Divorced")
    }
    Label {
        id: labelOccupation
        x: 21
        y: 365
        width: 85
        height: 13
        text: qsTr("Occupation")
    }
    TextField {
        id: textFieldOccupation
        x: 21
        y: 387
        width: 416
        height: 27
        text: qsTr("*  Occupation")
    }
    Button {
        id: buttonNextId
        x: 239
        y: 21
        width: 100
        height: 19
        text: qsTr("next person")
    }
    Rectangle {
        id: rectangleGender
        x: 129
        y: 21
        width: 13
        height: 13
        color: "green"
        radius: 6
    }
    Label {
        id: labelPersonNote
        x: 24
        y: 536
        width: 85
        height: 13
        text: qsTr("Person-Note")
    }
    TextEdit {
        id: textEditPnote
        x: 30
        y: 569
        width: 211
        height: 99
        text: qsTr("none")
        font.pixelSize: 12
    }
    Label {
        id: labeParents
        x: 470
        y: 21
        width: 85
        height: 13
        text: qsTr("Parents :  ")
    }
    Button {
        id: buttonDiscoParents
        x: 581
        y: 21
        width: 144
        height: 19
        text: qsTr("disconnect from parents")
    }
    Button {
        id: buttonDiscoPartner
        x: 581
        y: 136
        width: 144
        height: 19
        text: qsTr("disconnect from partner")
        checked: true
    }
    Label {
        id: labePartners
        x: 470
        y: 136
        width: 85
        height: 13
        text: qsTr("Partners")
    }
    Label {
        id: labeChilderen
        x: 470
        y: 250
        width: 85
        height: 13
        text: qsTr("Children")
    }
    Button {
        id: buttonDiscoChild
        x: 588
        y: 247
        width: 144
        height: 19
        text: qsTr("disconnect child")
        checked: true
    }
    Label {
        id: labeMessages
        x: 21
        y: 420
        width: 85
        height: 13
        text: qsTr("Messages")
    }
    Label {
        id: labelfamilyNote
        x: 477
        y: 541
        width: 85
        height: 13
        text: qsTr("Family-Note")
    }
    TextEdit {
        id: textEditPnote1
        x: 477
        y: 569
        width: 211
        height: 99
        text: qsTr("none")
        font.pixelSize: 12
    }
    TextEdit {
        id: textEditMessages
        x: 21
        y: 439
        width: 211
        height: 83
        text: qsTr("none")
        font.pixelSize: 12
    }
    Button {
        id: buttonSelectOther
        x: 743
        y: 57
        width: 117
        height: 17
        text: qsTr("Select other person")
    }
    Button {
        id: buttonPrevious
        x: 345
        y: 21
        width: 100
        height: 19
        text: qsTr("previous person")
    }
    Button {
        id: buttonAddNewPerson
        x: 743
        y: 93
        width: 117
        height: 17
        text: qsTr("add new person")
    }
    Button {
        id: buttonDeletePerson
        x: 877
        y: 93
        width: 117
        height: 17
        text: qsTr("delete person")
    }
    Button {
        id: buttonOptions
        x: 743
        y: 21
        width: 117
        height: 17
        text: qsTr("Show Options")
    }
    Button {
        id: buttonShowDocs
        x: 877
        y: 62
        width: 117
        height: 17
        text: qsTr("Show Documents")
    }
    Button {
        id: buttonShowAnchesterTree
        x: 866
        y: 21
        width: 139
        height: 17
        text: qsTr("Show Anchestor Tree")
    }
    ListView {
        id: listViewChilds
        x: 470
        y: 282
        width: 200
        height: 200
        model: childs
        delegate: Text{
            text: bYear +"-"+dYear+" " + givenName + surName
        }
        //       highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true


        MouseArea {
            id: mouseAreaChilds
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.fill: parent
        }
    }
    Rectangle {
        id: rectOptions
        x: 24
        y: 14
        width: 962
        height: 716
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ffffff"
            }

            GradientStop {
                position: 0.806
                color: "#ffffff"
            }

            GradientStop {
                position: 0.901
                color: "#ffffff"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }


        }
        visible: true

        Button {
            id: buttonWriteGedcom
            x: 28
            y: 85
            width: 131
            height: 40
            text: qsTr("Write Gedcom  File")
            z: 2
            checked: true
            checkable: true
        }

        Button {
            id: buttonReadGedcom
            x: 18
            y: 17
            width: 131
            height: 40
            text: qsTr("Read Gedcom  File")
            anchors.top: parent.top
            anchors.topMargin: 17
            anchors.left: parent.left
            anchors.leftMargin: 28
            z: 1
            checkable: true
        }

        Text {
            id: textReadGedcom
            x: 178
            y: 30
            text: qsTr("Read external Gedcom file and start processing")
            font.pixelSize: 16
        }

        Text {
            id: textWriteGedcom
            x: 178
            y: 96
            text: qsTr("Write  external Gedcom file for data exchange ( TODO )")
            font.pixelSize: 16
        }

        Button {
            id: buttonWriteCSV
            x: 28
            y: 143
            text: qsTr("Write internal CSV  File")
            checkable: true
            z: 2
            checked: true
        }

        Button {
            id: buttonReadCSV
            x: 28
            y: 199
            width: 131
            height: 40
            text: qsTr("Read internal CSV File")
            checkable: true
            z: 2
            checked: true
        }

        Button {
            id: buttonWriteHtml
            x: 28
            y: 257
            width: 131
            height: 40
            text: qsTr("Write HTML  Files")
            checkable: true
            z: 2
            checked: true
        }

        Text {
            id: textReadCSV
            x: 174
            y: 210
            text: "Read internal CSV file ( default at startup ) ( TODO )"
            font.pixelSize: 16
        }

        Text {
            id: textWriteGedcom2
            x: 178
            y: 154
            text: qsTr("Write  internal CSV file ( autosave ) (TODO )")
            font.pixelSize: 16
        }

        Text {
            id: textWriteHtml
            x: 174
            y: 268
            text: "Write HTML Files ( TODO )"
            font.pixelSize: 16
        }

        Button {
            id: buttonEditHeader
            x: 28
            y: 320
            width: 131
            height: 40
            text: qsTr("Edit Header Records")
            checkable: true
            z: 2
            checked: false
        }

        TextEdit {
            id: textEditHeader
            x: 205
            y: 320
            width: 300
            height: 200
            text: qsTr("Header :")
            font.pixelSize: 12
        }
    }
    Rectangle {
        id: rectSelect
        x: 463
        y: 21
        width: 500
        height: 720
        color: "#d3d3b5"
        visible: false

        ListView {
            id: listViewSelect
            x: 66
            y: 208
            width: 300
            height: 500
            visible: true
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 12
            focus: true


            delegate: Text {
                text: bYear +"-"+dYear+" " + givenName + surName
            }
            model: selection
            MouseArea {
                id: mouseAreaSelect
                anchors.fill: parent
            }

        }







        GroupBox {
            id: groupBox
            x: 229
            y: 37
            width: 300
            height: 80
            title: qsTr("If known, specify Gender")


            RadioButton {
                id: radioButtonMale
                x: -2
                y: 3
                height: 30
                text: qsTr("Male")
                autoExclusive: false
            }

            RadioButton {
                id: radioButtonUnknown
                x: 156
                y: 4
                height: 30
                text: qsTr("Unknown")
                autoExclusive: false
            }

            RadioButton {
                id: radioButtonFemale
                x: 70
                y: 3
                height: 30
                text: qsTr("Female")
                autoExclusive: false
            }
        }

        Text {
            id: textSelectionSurname
            x: 53
            y: 49
            text: "Surname beginning with ..."
            font.pixelSize: 12

            TextField {
                id: textFieldSelectName
                x: 3
                y: 27
                width: 159
                height: 27
                text: qsTr("")
            }
        }

        Text {
            id: textSelectionBorn
            x: 62
            y: 134
            text: qsTr("Born between ...")
            font.pixelSize: 12

            TextField {
                id: textFieldSelectFrom
                x: -2
                y: 28
                width: 198
                height: 27
                text: qsTr("")
            }
        }

        Text {
            id: textSelectionTo
            x: 279
            y: 139
            text: qsTr("and ...")
            font.pixelSize: 12

            TextField {
                id: textFieldSelectTo
                x: -4
                y: 22
                width: 198
                height: 27
                text: qsTr("")
            }
        }
        Text {
            id: textSelection
            x: 53
            y: 8
            text: qsTr("Please enter option to restrict the seach")
            visible: true
            font.pixelSize: 12
        }
    }

    Button {
        id: buttonSave
        x: 743
        y: 138
        width: 117
        height: 17
        text: qsTr("save screen data")
    }
}
