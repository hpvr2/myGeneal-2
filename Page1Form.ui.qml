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
    property alias groupBox: groupBox
    property alias textFieldSelectTo: textFieldSelectTo
    property alias textFieldSelectFrom: textFieldSelectFrom
    property alias textFieldSelectName: textFieldSelectName
    property alias textSelection: textSelection
    
    property alias textEditFnote: textEditFnote
    property alias buttonHide: buttonHide
    property alias textEditTrailer: textEditTrailer
    property alias textEditHeader: textEditHeader
    property alias buttonSave: buttonSave
    
    property alias buttonNextFamily: buttonNextFamily
    property alias rectangleButtons: rectangleButtons
    property alias rectPerson: rectPerson
    property alias labelOccupation: labelOccupation
    height: 800
    property alias radioButtonUnknown: radioButtonUnknown
    property alias radioButtonFemale: radioButtonFemale
    property alias textSelectionSurname: textSelectionSurname
    property alias gridLayout1: gridLayout1
    property alias toolBar: toolBar
    property alias rowLayout: rowLayout
    x:0
    y: 100
    width: 1000
    z: 2147483646
    anchors.topMargin: 50
    anchors.fill: parent
    
    ToolBar {
        id: toolBar
        
        visible: true
        RowLayout {
            id: rowLayout
            anchors.fill: parent
            Button {
                id: buttonSave
                width: 150
                text: qsTr("save screen data")
                anchors.fill: parent
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
            
            
        }
    }
    
    
    Rectangle {
        id: rectSelect
        width: 200
        color: "#d3d3b5"
        z: 1
        anchors.rightMargin: -66
        anchors.bottomMargin: 0
        anchors.leftMargin: 468
        anchors.topMargin: 0
        anchors.fill: parent
        visible: true
        
        GridLayout {
            id: gridLayout1
            anchors.fill: parent
            rows: 6
            columns: 2

            
            Text {
                id: textSelection
                text: qsTr("Please enter options to restrict the seach")
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                Layout.columnSpan: 2
                visible: true
                font.pixelSize: 15
            }
            


            Text {
                id: textSelectionSurname
                text: "Surname beginning with ..."
                Layout.columnSpan: 1
                font.pixelSize: 12
            }

            GroupBox {
                id: groupBox
                width: 500
                height: 100
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                Layout.rowSpan: 3
                Layout.columnSpan: 1
                title: qsTr("If known, specify Gender")

                RadioButton {
                    id: radioButtonMale
                    text: qsTr("Male")
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -28
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    autoExclusive: false
                }

                RadioButton {
                    id: radioButtonFemale
                    x: -1
                    y: -12
                    text: qsTr("Female")
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -28
                    autoExclusive: false
                    anchors.left: parent.left
                    anchors.leftMargin: 81
                }

                RadioButton {
                    id: radioButtonUnknown
                    x: 0
                    y: -12
                    text: qsTr("Unknown")
                    autoExclusive: false
                    anchors.left: parent.left
                    anchors.leftMargin: 164
                }

            }

            TextField {
                id: textFieldSelectName
                width: 159
                height: 27
                text: qsTr("")
                Layout.rowSpan: 2
            }



            
            

            Text {
                id: textSelectionBorn
                text: qsTr("Born between ...")
                font.pixelSize: 12
            }
            
            Text {
                id: textSelectionTo
                text: qsTr("and ...")
                font.pixelSize: 12
            }

            TextField {
                id: textFieldSelectFrom
                width: 198
                height: 27
                text: qsTr("")
            }

            TextField {
                id: textFieldSelectTo
                width: 198
                height: 27
                text: qsTr("")
            }

            
            ListView {
                id: listViewSelect
                width: 500
                height: 500
                Layout.columnSpan: 2
                Layout.rowSpan: 5
                visible: true
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 12
                focus: true
                
                delegate: Text {
                    text: bYear + "-" + dYear + " " + givenName + surName
                }
                model: selection
                MouseArea {
                    id: mouseAreaSelect
                    anchors.fill: parent
                }
            }



        }
    }
    
    Rectangle {
        id: rectPerson
        x: 0
        y: 100
        width: 1000
        
        color: "#dedcdc"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        
        
        GridLayout {
            id: gridLayout
            width: 1000
            anchors.fill: parent
            columnSpacing: 2
            rows: 15
            columns:8
            Layout.fillHeight: true
            Layout.fillWidth: true
            
            
            
            Button {
                id: buttonNextId
                text: qsTr("next person")
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.columnSpan: 2
            }
            
            Button {
                id: buttonPrevious
                width: 100
                height: 19
                text: qsTr("previous person")
                Layout.columnSpan: 1
            }
            
            Label {
                id: labelParents
                width: 85
                height: 13
                text: qsTr("Parents :")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: false
                Layout.columnSpan: 1
                
                Button {
                    id: buttonDiscoParents
                    width: 144
                    text: qsTr("disconnect from parents")
                    anchors.left: parent.left
                    anchors.leftMargin: 90
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -6
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    Layout.columnSpan: 4
                }
            }
            
            Label {
                id: labelPid
                text: qsTr("Person Id :     ")
                anchors.fill: parent
                Layout.column: 0
                Layout.row :1
            }
            
            TextField {
                id: textFieldGivenName
                text: qsTr("* Givenname")
            }
            
            TextField {
                id: textFieldSurName
                text: qsTr("*  Surname")
                Layout.columnSpan: 3
                
                Rectangle {
                    id: rectangleGender
                    x: -220
                    y: 12
                    width: 15
                    height: 15
                    
                    color: "green"
                    radius: 6
                    anchors.right: parent.right
                    anchors.rightMargin: -30
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            
            ListView {
                id: listViewParents
                width: 200
                height: 50
                Layout.rowSpan: 1
                Layout.fillWidth: true
                Layout.columnSpan: 1
                model: parents
                delegate: Text {
                    text: bYear + "-" + dYear + " " + givenName + surName
                }
                //       highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                focus: true
                
                MouseArea {
                    id: mouseAreaParents
                    anchors.fill: parent
                }
            }
            
            Label {
                id: labelBorn
                text: qsTr("Born :     ")
                visible: true
                
                Layout.column: 0
                Layout.row : 2
                Layout.columnSpan: 1
                Layout.fillWidth: false
            }
            
            TextField {
                id: textFieldBirthDate
                text: qsTr("*  Birthdate")
            }
            
            TextField {
                id: textFieldBirthPlace
                text: qsTr("*  Birthplace")
                Layout.columnSpan: 1
            }
            
            Label {
                id: labePartners
                width: 85
                height: 13
                text: qsTr("Partners")
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.columnSpan: 2
            }
            
            Button {
                id: buttonNextFamily
                width: 144
                height: 19
                text: qsTr("next family")
                enabled: true
                checked: false
                Layout.columnSpan: 1
                
                Button {
                    id: buttonDiscoPartner
                    width: 144
                    text: qsTr("disconnect from partner")
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    anchors.left: parent.left
                    anchors.leftMargin: 117
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.columnSpan: 1
                    enabled: true
                    checked: false
                }
            }
            
            
            Label {
                id: labelDied
                text: qsTr("Died : ")
                Layout.column: 0
                Layout.row : 3
                Layout.columnSpan: 1
            }
            
            TextField {
                id: textFieldDeathDate
                text: qsTr("*  Deathdate")
                Layout.columnSpan: 1
            }
            
            TextField {
                id: textFieldDeathPlace
                text: qsTr("*  Deathplace")
                Layout.columnSpan: 3
            }
            
            ListView {
                id: listViewPartners
                width: 200
                height: 71
                Layout.fillWidth: true
                Layout.rowSpan: 1
                Layout.columnSpan: 1
                model: partners
                delegate: Text {
                    text: bYear + "-" + dYear + " " + givenName + surName
                }
                //       highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                focus: true
                
                MouseArea {
                    id: mouseAreaPartners
                    anchors.fill: parent
                }
            }
            
            Label {
                id: labelMarried
                
                text: qsTr("Married in family ....")
                Layout.column: 0
                Layout.row : 4
                Layout.columnSpan: 1
            }
            
            TextField {
                id: textFieldMarryDate
                width: 198
                height: 27
                text: qsTr("*  Marrydate")
            }
            
            TextField {
                id: textFieldMarryPlace
                width: 198
                height: 27
                text: qsTr("*  Marryplace")
                Layout.columnSpan: 2
            }
            
            Label {
                id: labeChilderen
                width: 85
                height: 13
                text: qsTr("Children")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.columnSpan: 1
                Layout.rowSpan: 1
            }
            
            Button {
                id: buttonDiscoChild
                width: 144
                height: 19
                text: qsTr("disconnect child")
                Layout.columnSpan: 3
                checked: false
            }
            
            Label {
                id: labelDivorced
                width: 85
                height: 13
                text: qsTr("Divorced")
                Layout.rowSpan: 1
                Layout.columnSpan: 1
            }
            
            TextField {
                id: textFieldDivorceDate
                width: 198
                height: 27
                text: qsTr("*  Divorcedate")
            }
            
            TextField {
                id: textFieldDivorcePlace
                width: 198
                height: 27
                text: qsTr("*  Divorceplace")
                Layout.columnSpan: 3
            }
            
            ListView {
                id: listViewChilds
                
                width: 200
                height: 150
                Layout.fillWidth: true
                Layout.rowSpan: 3
                Layout.columnSpan: 2
                model: childs
                delegate: Text {
                    text: bYear + "-" + dYear + " " + givenName + surName
                }
                //       highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                focus: true
                
                MouseArea {
                    id: mouseAreaChilds
                    anchors.fill: parent
                }
            }
            
            Label {
                id: labelOccupation
                text: qsTr("Occupation")
                Layout.column: 0
                Layout.row : 6
                Layout.rowSpan: 2
                Layout.columnSpan: 1
            }
            
            TextField {
                id: textFieldOccupation
                text: qsTr("*  Occupation")
                Layout.rowSpan: 2
                Layout.fillWidth: true
                Layout.columnSpan: 2
            }
            
            Label {
                id: labelPersonNote
                text: qsTr("Person-Note")
                Layout.column: 0
                Layout.row : 7
                Layout.rowSpan: 1
                Layout.columnSpan: 1
            }
            
            TextEdit {
                id: textEditPnote
                text: qsTr("none")
                Layout.fillHeight: true
                Layout.minimumHeight: 200
                Layout.minimumWidth: 400
                Layout.rowSpan: 4
                Layout.columnSpan: 3
                Layout.fillWidth: true
                font.pixelSize: 12
            }
            
            Label {
                id: labelfamilyNote
                width: 85
                height: 13
                text: qsTr("Family-Note")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.columnSpan: 2
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            TextEdit {
                id: textEditFnote
                width: 211
                height: 200
                text: qsTr("none")
                renderType: Text.QtRendering
                Layout.minimumHeight: 200
                Layout.minimumWidth: 400
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.columnSpan: 1
                selectionColor: "#008069"
                Layout.rowSpan: 4
                font.pixelSize: 12
            }
            
            
        }
        
    }
    
    
    Rectangle {
        id: rectangleButtons
        x: 1014
        y: 0
        width: 160
        color: "#5f5c5c"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        visible: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignRight | Qt.AlignTop
        
        ColumnLayout {
            id: columnLayout
            anchors.fill: parent
            
            //            Button {
            //                id: buttonSave
            //                width: 117
            //                height: 17
            //                text: qsTr("save screen data")
            //                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            //            }
            
            Button {
                id: buttonAddNewPerson
                width: 117
                height: 17
                text: qsTr("add new person")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
            
            Button {
                id: buttonDeletePerson
                width: 117
                height: 17
                text: qsTr("delete person")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
            
            Button {
                id: buttonSelectOther
                width: 117
                height: 17
                text: qsTr("Select other person")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
            
            Button {
                id: buttonShowDocs
                width: 117
                height: 17
                text: qsTr("Show Documents")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
            
            Button {
                id: buttonShowAnchesterTree
                width: 139
                height: 17
                text: qsTr("Show Anchestor Tree")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
            
            Button {
                id: buttonOptions
                width: 117
                height: 17
                text: qsTr("Show Options")
                Layout.rowSpan: 2
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
            
            Label {
                id: labeMessages
                width: 85
                height: 13
                text: qsTr("Messages")
                Layout.rowSpan: 2
            }
            
            TextEdit {
                id: textEditMessages
                width: 150
                height: 200
                text: qsTr("none")
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.rowSpan: 1
                font.pixelSize: 12
            }
            
            
            
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
            text: qsTr("Write HTML  Files  ")
            visible: true
            checkable: true
            z: 2
            checked: true
        }
        
        Text {
            id: textReadCSV
            x: 174
            y: 210
            text: "Read internal CSV file ( default at startup ) "
            font.pixelSize: 16
        }
        
        Text {
            id: textWriteCSV
            x: 178
            y: 154
            text: qsTr("Write  internal CSV file ( autosave ) ")
            font.pixelSize: 16
        }
        
        Text {
            id: textWriteHtml
            x: 174
            y: 268
            text: "Write HTML Files ( TODO )"
            font.pixelSize: 16
        }
        
        TextEdit {
            id: textEditHeader
            x: 28
            y: 326
            width: 300
            height: 200
            text: qsTr("Header :")
            font.pixelSize: 12
        }
        
        TextEdit {
            id: textEditTrailer
            x: 368
            y: 326
            width: 300
            height: 200
            text: qsTr("Trailer :")
            font.pixelSize: 12
        }
        
        Button {
            id: buttonHide
            x: 34
            y: 547
            width: 131
            height: 40
            text: qsTr("Hide Option screen")
            checkable: true
            z: 2
            checked: true
        }
    }
}

