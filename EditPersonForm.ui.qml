import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import "Gedcom.js" as Gedcom

Item {
    id: item1
    
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
    property alias textEditPnote: textEditPnote
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
    property alias rectSelect: rectSelect
    property alias mouseAreaSelect: mouseAreaSelect
    property alias listViewSelect: listViewSelect
    property alias radioButtonMale: radioButtonMale
    property alias textFieldSelectName: textFieldSelectName
    property alias textSelection: textSelection
    
    property alias textEditFnote: textEditFnote
    //    property alias buttonHide: buttonHide
    
    property alias buttonNextFamily: buttonNextFamily
    
    property alias rectPerson: rectPerson
    property alias labelOccupation: labelOccupation
    property alias textSelectionSurname: textSelectionSurname
    
    property alias radioButtonUnknown: radioButtonUnknown
    property alias radioButtonFemale: radioButtonFemale
    
    property alias rectOptions: rectOptions
    property alias textWriteCSV: textWriteCSV
    property alias textWriteHtml: textWriteHtml
    property alias textEditHeader: textEditHeader
    property alias textEditTrailer: textEditTrailer
    property alias buttonWriteHtml: buttonWriteHtml
    property alias buttonWriteGedcom: buttonWriteGedcom

    property var header :[]
    
    x:0
    y: 100
    width: 1000

    property alias buttonSave: buttonSave
    property alias buttonReadCSV: buttonReadCSV
    property alias buttonReadGedcom: buttonReadGedcom
    property alias textFieldSelectTo: textFieldSelectTo
    property alias textFieldSelectFrom: textFieldSelectFrom
    z: 2147483646
    anchors.topMargin: 50
    anchors.fill: parent

    
//    Rectangle {
//        id: rectMsg
//        height: 200
//        color: "#3030ee"
//        visible: false
//        z: 3
//        anchors.topMargin: 100
//        anchors.rightMargin: 100
//        anchors.leftMargin: 100
//        anchors.right: parent.right
//        anchors.left: parent.left
//        anchors.top: parent.top

//        TextField {
//            id: textMsgHeader
//            x: 12
//            text: qsTr("Message Header")
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.top: parent.top
//            anchors.topMargin: 8
//        }

//        TextField {
//            id: textMsgText
//            text: qsTr("Message Text")
//            anchors.right: parent.right
//            anchors.rightMargin: 26
//            anchors.left: parent.left
//            anchors.leftMargin: 26
//            anchors.top: parent.top
//            anchors.topMargin: 64
//        }

//        Button {
//            id: buttonYes
//            y: 156
//            text: qsTr("YES")
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 4
//            anchors.left: parent.left
//            anchors.leftMargin: 4
//        }

//        Button {
//            id: buttonNo
//            y: 156
//            text: qsTr(" NO")
//            anchors.left: buttonYes.right
//            anchors.leftMargin: 4
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 4
//            visible: true
//        }
        

//    }

    Rectangle {
        id: rectPerson
        
        color: "#dedcdc"
        visible: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        
        Rectangle{ x: 8; y: -58; width: 985; height: 50; color: "#8f8787"; RowLayout{
                anchors.fill: parent
                Button {
                    id: buttonNextId
                    text: qsTr("next person")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.column: 1
                    Layout.row :1
                }
                
                Button {
                    id: buttonPrevious
                    width: 100
                    height: 19
                    text: qsTr("previous person")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.columnSpan: 1
                }
                
                Button {
                    id: buttonAddNewPerson
                    text: qsTr("add new person")
                }
                
                Button {
                    id: buttonDeletePerson
                    text: qsTr("delete person")
                }
                
                Button {
                    id: buttonSelectOther
                    text: qsTr("Select other person")
                }
                
                Button {
                    id: buttonSave
                    text: qsTr("Save person data")
                }

                Button {
                    id: buttonShowDocs
                    text: qsTr("Show Documents")
                }
                
                Button {
                    id: buttonShowAnchesterTree
                    text: qsTr("Show Anchestor Tree")
                }
                
                Button {
                    id: buttonOptions
                    text: qsTr("Show Options")
                    Layout.rowSpan: 1
                }

            }
        }
        
        
        GridLayout {
            id: gridLayout
            anchors.fill: parent
            visible: true
            columnSpacing: 2
            rows: 15
            columns:8
            Layout.fillHeight: true
            Layout.fillWidth: true
            
            
            //row 1
            //row 2
            //row 3
            Label {
                id: labelPid
                text: qsTr("Person Id :     ")

                Layout.column: 1
                Layout.row :3
            }
            
            TextField {
                id: textFieldGivenName
                color: "black"

                text: qsTr("* Givenname")
            }
            
            TextField {
                id: textFieldSurName
                width: 180
                text: qsTr("*  Surname")
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
                    anchors.leftMargin: 233
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -6
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    Layout.columnSpan: 4
                }
            }
            
            //row 4
            Label {
                id: labelBorn
                text: qsTr("Born :     ")
                Layout.column: 1
                Layout.row : 4
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
                Layout.columnSpan: 2
            }
            
            ListView {
                id: listViewParents
                width: 250
                height: 50
                Layout.rowSpan: 1
                Layout.fillWidth: true
                Layout.columnSpan: 3
                model: parents
                delegate: Text {
                    text: bYear + "-" + dYear + " " + givenName + surName
                }
                
                
                
                MouseArea {
                    id: mouseAreaParents
                    anchors.fill: parent
                }
            }
            
            // row 5
            
            Label {
                id: labelDied
                text: qsTr("Died : ")
                Layout.column: 1
                Layout.row : 5
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
                Layout.columnSpan: 1
            }
            
            Label {
                id: labelPartners
                width: 85
                height: 13
                text: qsTr("Partners")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: false
                Layout.columnSpan: 1
                
                Button {
                    id: buttonNextFamily
                    x: 66
                    y: -14
                    width: 144
                    height: 17
                    text: qsTr("next family")
                    anchors.verticalCenterOffset: 3
                    anchors.verticalCenter: parent.verticalCenter
                    enabled: true
                    checked: false
                    Layout.columnSpan: 1
                    
                    Button {
                        id: buttonDiscoPartner
                        width: 144
                        height: 17
                        text: qsTr("disconnect from partner")
                        anchors.verticalCenterOffset: 0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 164
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Layout.columnSpan: 1
                        enabled: true
                        checked: false
                    }
                }
            }
            // row 6
            Label {
                id: labelMarried
                x: 42
                
                text: qsTr("Married ")
                Layout.column: 1
                Layout.row : 6
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
            
            
            ListView {
                id: listViewPartners
                width: 200
                height: 71
                highlightRangeMode: ListView.ApplyRange
                snapMode: ListView.SnapToItem
                boundsBehavior: Flickable.StopAtBounds
                Layout.fillWidth: true
                Layout.rowSpan: 1
                Layout.columnSpan: 2
                model: partners
                delegate: Text {
                    text: bYear + "-" + dYear + " " + givenName + surName
                }
                
                MouseArea {
                    id: mouseAreaPartners
                    anchors.fill: parent
                }
            }
            
            // row 7
            Label {
                id: labelDivorced
                width: 85
                height: 13
                text: qsTr("Divorced")
                Layout.rowSpan: 1
                Layout.columnSpan: 2
                Layout.row : 7
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
                Layout.columnSpan: 1
            }
            Label {
                id: labelChildren
                width: 85
                height: 13
                text: qsTr("Children")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                
                Layout.columnSpan: 1
                Layout.rowSpan: 1
                
                Button {
                    id: buttonDiscoChild
                    x: 236
                    y: -3
                    width: 144
                    height: 19
                    text: qsTr("disconnect child")
                    Layout.columnSpan: 3
                    checked: false
                }
            }
            // row 8
            
            
            
            Label {
                id: labelOccupation
                text: qsTr("Occupation")
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.column: 1
                Layout.row : 8
                Layout.rowSpan: 1
                Layout.columnSpan: 1
            }
            
            TextField {
                id: textFieldOccupation
                width: 400
                text: qsTr("*  Occupation")
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.rowSpan: 1
                Layout.fillWidth: true
                Layout.columnSpan: 2
            }
            
            ListView {
                id: listViewChilds
                
                width: 200
                height: 150
                Layout.fillWidth: true
                Layout.rowSpan: 2
                Layout.columnSpan: 2
                model: childs
                delegate: Text {
                    text: bYear + "-" + dYear + " " + givenName + surName
                }
                //                //       highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                //                focus: true
                
                MouseArea {
                    id: mouseAreaChilds
                    anchors.fill: parent
                }
            }
            // row 9
            Label {
                id: labelPersonNote
                text: qsTr("Person-Note")
                Layout.column: 1
                Layout.row : 10
                Layout.rowSpan: 1
                Layout.columnSpan: 3
            }
            Label {
                id: labelfamilyNote
                width: 85
                height: 13
                text: qsTr("Family-Note")
                Layout.rowSpan: 1
                Layout.columnSpan: 2
            }
            // row 10
            TextEdit {
                id: textEditPnote
                text: qsTr("none")
                Layout.fillHeight: true
                Layout.minimumHeight: 200
                Layout.minimumWidth: 200
                
                Layout.column: 1
                Layout.row : 11
                Layout.rowSpan: 1
                Layout.columnSpan: 3
                Layout.fillWidth: true
                font.pixelSize: 12
            }
            
            
            
            TextEdit {
                id: textEditFnote
                width: 211
                height: 200
                text: qsTr("none")
                renderType: Text.QtRendering
                Layout.minimumHeight: 200
                Layout.minimumWidth: 200
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.columnSpan: 2
                selectionColor: "#008069"
                Layout.rowSpan: 1
                font.pixelSize: 12
            }
            
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    
    
    Rectangle {
        id: rectSelect
        x: 1000
        width: 300
        height: 500
        color: "#d3d3b5"
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: -174
        anchors.leftMargin: 470
        anchors.fill: parent
        z: 2
        visible: false

        Text {
            id: textSelection
            text: qsTr("Please enter options to restrict the seach")
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            Layout.fillWidth: true
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            visible: true
            font.pixelSize: 15

            Text {
                id: textSelectionSurname
                x: -4
                text: "   Surname beginning with ..."
                anchors.top: parent.top
                anchors.topMargin: 50
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                fontSizeMode: Text.FixedSize
                visible: true
                font.pixelSize: 12

                TextField {
                    id: textFieldSelectName
                    width: 159
                    height: 27
                    text: qsTr("")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 170

                    RadioButton {
                        id: radioButtonMale
                        y: -358
                        text: qsTr("Male")
                        anchors.left: parent.left
                        anchors.leftMargin: 200
                        anchors.verticalCenter: parent.verticalCenter
                        checked: false
                        enabled: true
                        autoExclusive: false
                    }
                }
            }

            Text {
                id: textSelectionBorn
                x: -4
                text: qsTr("   Born between ...")
                anchors.top: textSelectionSurname.bottom
                anchors.topMargin: 20
                Layout.fillWidth: false
                font.pixelSize: 12

                TextField {
                    id: textFieldSelectFrom
                    x: 170
                    y: -49
                    width: 159
                    height: 27
                    text: qsTr("")
                    anchors.verticalCenterOffset: 1
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 119

                    RadioButton {
                        id: radioButtonFemale
                        x: -914
                        y: 170
                        text: qsTr("Female")
                        anchors.verticalCenterOffset: -6
                        anchors.verticalCenter: parent.verticalCenter
                        autoExclusive: false
                        anchors.left: parent.left
                        anchors.leftMargin: 200
                    }
                }
            }

            Text {
                id: textSelectionTo
                x: -4
                text: qsTr("   and ...")
                anchors.top: textSelectionBorn.top
                anchors.topMargin: 30
                font.pixelSize: 12

                TextField {
                    id: textFieldSelectTo
                    x: 170
                    y: -167
                    width: 159
                    height: 27
                    text: qsTr("")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 170

                    RadioButton {
                        id: radioButtonUnknown
                        x: 141
                        y: 255
                        text: qsTr("Unknown")
                        anchors.verticalCenter: parent.verticalCenter
                        autoExclusive: false
                        anchors.left: parent.left
                        anchors.leftMargin: 200
                    }
                }
            }
            ListView {
                id: listViewSelect
                x: 15
                width: 400
                height: 450
                visible: true
                anchors.top: textSelectionTo.bottom
                anchors.topMargin: 20
                model: selection
                delegate: Text {
                    text: bYear + "-" + dYear + " " + givenName + surName
                }

                MouseArea {
                    id: mouseAreaSelect
                    anchors.fill: parent
                }
            }
        }
    }

    Rectangle {
        id: rectOptions
        anchors.fill: parent

        visible: true

        GridLayout {
            id: gridLayout1
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            rows: 8
            columns: 2
            anchors.fill: parent

            Button {
                id: buttonReadCSV
                width: 150
                height: 40
                text: qsTr("Read autosave data")
                z: 2
                checked: false
                clip: false
                checkable: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            Text {
                id: textReadGedcom
                text: qsTr("Read autosave data and restart")
                font.pixelSize: 16
            }

            Button {
                id: buttonReadGedcom
                width: 150
                height: 40
                text: qsTr("Read Gedcom  File")
                z: 2
                checked: false
                clip: false
                checkable: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            Text {
                id: textReadGedcom1
                text: qsTr("Read external Gedcom file and start processing")
                font.pixelSize: 16
            }

            Button {
                id: buttonWriteGedcom
                width: 150
                height: 40
                text: qsTr("Write Gedcom  File")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                clip: false
                z: 2
                checked: false
                checkable: true
            }



            Text {
                id: textWriteCSV
                text: qsTr("Write  internal CSV file ( autosave ) ")
                font.pixelSize: 16
            }




            Button {
                id: buttonWriteHtml
                width: 150
                height: 40
                text: qsTr("Write HTML  Files  ")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
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
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.pixelSize: 12
            }

            TextEdit {
                id: textEditTrailer
                width: 300
                height: 200
                text: qsTr("Trailer :")
                font.pixelSize: 12
            }









        }
    }


    //    property alias rectOptions: rectOptions
    //    property alias textWriteGedcom: textWriteGedcom
    //    property alias textWriteCSV: textWriteCSV
    //    property alias textReadCSV: textReadCSV
    //    property alias textWriteHtml: textWriteHtml
    //    property alias textEditHeader: textEditHeader
    //    property alias textEditTrailer: textEditTrailer
    //    property alias buttonHide: buttonHide
    //    property alias buttonWriteHtml: buttonWriteHtml
    //    property alias buttonReadCSV: buttonReadCSV
    //    property alias buttonWriteCSV: buttonWriteCSV
    //    property alias buttonReadGedcom: buttonReadGedcom
    //    property alias buttonWriteGedcom: buttonWriteGedcom

    //    Rectangle {
    //        id: rectOptions
    //        anchors.fill: parent

    //        visible: true

    //        GridLayout {
    //            id: gridLayout
    //            anchors.rightMargin: 0
    //            anchors.bottomMargin: 0
    //            anchors.leftMargin: 0
    //            anchors.topMargin: 0
    //            rows: 8
    //            columns: 2
    //            anchors.fill: parent

    //            Button {
    //                id: buttonReadGedcom
    //                x: 0
    //                width: 150
    //                height: 40
    //                text: qsTr("Read Gedcom  File")
    //                visible: true
    //                anchors.top: parent.top
    //                anchors.topMargin: 17
    //                anchors.left: parent.left
    //                anchors.leftMargin: 28
    //                z: 1
    //                checkable: true
    //            }

    //            Text {
    //                id: textReadGedcom
    //                text: qsTr("Read external Gedcom file and start processing")
    //                font.pixelSize: 16
    //            }

    //            Button {
    //                id: buttonWriteGedcom
    //                width: 150
    //                height: 40
    //                text: qsTr("Write Gedcom  File")
    //                clip: false
    //                z: 2
    //                checked: false
    //                checkable: true
    //            }

    //            Text {
    //                id: textWriteGedcom
    //                text: qsTr("Write  external Gedcom file for data exchange ( TODO )")
    //                font.pixelSize: 16
    //            }

    //            Button {
    //                id: buttonWriteCSV
    //                width: 150
    //                height: 40
    //                text: qsTr("Write internal CSV  File")
    //                checkable: true
    //                z: 2
    //                checked: false
    //            }



    //            Text {
    //                id: textWriteCSV
    //                text: qsTr("Write  internal CSV file ( autosave ) ")
    //                font.pixelSize: 16
    //            }

    //            Button {
    //                id: buttonReadCSV
    //                width: 131
    //                height: 40
    //                text: qsTr("Read internal CSV File")
    //                checkable: true
    //                z: 2
    //                checked: false
    //            }

    //            Text {
    //                id: textReadCSV
    //                text: "Read internal CSV file ( default at startup ) "
    //                font.pixelSize: 16
    //            }




    //            Button {
    //                id: buttonWriteHtml
    //                width: 150
    //                height: 40
    //                text: qsTr("Write HTML  Files  ")
    //                Layout.fillWidth: false
    //                visible: true
    //                checkable: true
    //                z: 2
    //                checked: false
    //            }

    //            Text {
    //                id: textWriteHtml
    //                text: "Write HTML Files ( TODO )"
    //                font.pixelSize: 16
    //            }

    //            TextEdit {
    //                id: textEditHeader
    //                width: 300
    //                height: 200
    //                text: qsTr("Header :")
    //                font.pixelSize: 12
    //            }

    //            TextEdit {
    //                id: textEditTrailer
    //                width: 300
    //                height: 200
    //                text: qsTr("Trailer :")
    //                font.pixelSize: 12
    //            }

    //            Button {
    //                id: buttonHide
    //                width: 150
    //                height: 40
    //                text: qsTr("Hide Option screen")
    //                clip: true
    //                checkable: true
    //                z: 2
    //                checked: false
    //            }




    //        }
    //    }
}
