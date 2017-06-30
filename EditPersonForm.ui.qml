import QtQuick 2.7
import QtQuick.Controls 1.4

import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import "Gedcom.js" as Gedcom

Item {
    id: item1
    width: 1000
    property alias buttonAddPerson: buttonAddPerson
    property alias textFieldSelectType: textFieldSelectType
    property alias buttonShowAnchester: buttonShowAnchester
    x: 0
    y: 50
    z: 2147483646
    anchors.topMargin: 50
    anchors.fill: parent

    
    property alias labelPid: labelPid
    property alias labelOccupation: labelOccupation
    property alias labelBorn: labelBorn


    property alias textFieldGivenName: textFieldGivenName
    property alias textFieldSurName: textFieldSurName
    property alias textFieldOccupation: textFieldOccupation
    property alias textFieldDivorceDate: textFieldDivorceDate
    property alias textFieldDivorcePlace: textFieldDivorcePlace
    property alias textFieldMarryPlace: textFieldMarryPlace
    property alias textFieldMarryDate: textFieldMarryDate
    property alias textFieldDeathDate: textFieldDeathDate
    property alias textFieldBirthDate: textFieldBirthDate
    property alias textFieldBirthPlace: textFieldBirthPlace
    property alias textFieldDeathPlace: textFieldDeathPlace
    property alias textFieldSelectName: textFieldSelectName
    property alias textSelectionSurname: textSelectionSurname // rename
    property alias textFieldSelection: textFieldSelection
    property alias textFieldSelectTo: textFieldSelectTo
    property alias textFieldSelectFrom: textFieldSelectFrom



    property alias textEditPnote: textEditPnote

    property alias buttonNextId: buttonNextId
    property alias buttonOptions: buttonOptions
    property alias buttonDiscoParents: buttonDiscoParents
    property alias buttonDiscoPartner: buttonDiscoPartner
    property alias buttonDiscoChild: buttonDiscoChild
    property alias buttonSelectOther: buttonSelectOther
    property alias buttonPrevious: buttonPrevious
    property alias buttonAddNewPerson: buttonAddNewPerson
    property alias buttonDeletePerson: buttonDeletePerson
    property alias buttonShowDocs: buttonShowDocs
    property alias buttonNextFamily: buttonNextFamily
    property alias buttonWriteHtml: buttonWriteHtml
    property alias buttonWriteGedcom: buttonWriteGedcom
    property alias buttonAddStop: buttonAddStop
    property alias buttonGender: buttonGender
    property alias buttonSave: buttonSave
    property alias buttonReadCSV: buttonReadCSV
    property alias buttonReadGedcom: buttonReadGedcom


    property alias rectSelect: rectSelect
    property alias rectPerson: rectPerson
    property alias rectOptions: rectOptions


    property alias radioButtonMale: radioButtonMale
    property alias radioButtonUnknown: radioButtonUnknown
    property alias radioButtonFemale: radioButtonFemale

    
    
    
    
    property alias textWriteCSV: textWriteCSV
    property alias textWriteHtml: textWriteHtml
    property alias textEditHeader: textEditHeader
    property alias textEditTrailer: textEditTrailer

    property var header :[]
    

    property alias tabViewSelect: tabViewSelect
    property alias tabViewChildren: tabViewChildren
    property alias tabViewPartners: tabViewPartners
    property alias tabViewParents: tabViewParents



    
    

    Rectangle {
        id: rectPerson
        x: 0
        
        color: "#dedcdc"
        visible: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        
        Rectangle{ id: rectangle; x: 8; y: -58; width: 985; height: 50; color: "#8f8787";
            RowLayout{
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
                    id: buttonShowAnchester
                    text: qsTr("Show Anchestor Tree")
                }
                
                Button {
                    id: buttonOptions
                    text: qsTr("Show Options")
                    Layout.rowSpan: 1
                }

            }


            GridLayout {
                id: gridLayout
                x: 8
                y: 40
                width: 500
                height: 300
                rowSpacing: 27
                anchors.left: parent.left
                anchors.leftMargin: 13
                anchors.top: parent.top
                anchors.topMargin: 56
                visible: true
                columnSpacing: 13
                rows: 20
                columns:20
                Layout.fillHeight: true
                Layout.fillWidth: true



                Label {
                    id: labelPid
                    x: 50
                    y: 0
                    width: 20
                    height: 20
                    text: qsTr(" Id :     ")
                    anchors.fill: parent
                    verticalAlignment: Text.AlignTop
                    horizontalAlignment: Text.AlignLeft
                    transformOrigin: Item.TopLeft

                    Layout.column: 1
                    Layout.row :3

                    TextField {
                        id: textFieldGivenName
                        x: 100
                        y: 4
                        width: 180

                        text: qsTr("* Givenname")
                        anchors.left: parent.left
                        anchors.leftMargin: 74
                        Layout.preferredWidth: -1
                        Layout.minimumWidth: 200


                    }

                    TextField {
                        id: textFieldSurName
                        x: 500
                        y: 1
                        width: 200
                        text: qsTr("*  Surname")
                        anchors.verticalCenterOffset: -135
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 273
                        Layout.minimumWidth: 200
                        Layout.columnSpan: 1
                    }

                    Label {
                        id: labelParents
                        x: 550
                        y: 0
                        width: 85
                        height: 13
                        text: qsTr("   Parents :")
                        anchors.verticalCenterOffset: 1
                        anchors.left: parent.left
                        anchors.leftMargin: 500
                        anchors.verticalCenter: textFieldSurName.verticalCenter
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.fillWidth: false
                        Layout.columnSpan: 1

                        Button {
                            id: buttonDiscoParents
                            width: 144
                            height: 20
                            text: qsTr("disconnect from parents")
                            anchors.verticalCenterOffset: 3
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 209
                            Layout.columnSpan: 4
                        }

                        TableView {
                            id: tabViewParents
                            y: 100
                            horizontalScrollBarPolicy : Qt.ScrollBarAlwaysOff
                            width: 400
                            height: 50
                            anchors.left: parent.left
                            anchors.leftMargin: 50
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            Layout.rowSpan: 1
                            Layout.fillWidth: false
                            Layout.columnSpan: 3
                            model: parents


                            TableViewColumn {
                                role : "bYear"
                                title: "Born"
                                width : 40}
                            TableViewColumn {
                                role : "dYear"
                                title: "Died"
                                width: 40 }
                            TableViewColumn {
                                role : "givenName"
                                title: "Given name"
                                width: 150 }
                            TableViewColumn {
                                role : "surName"
                                title: "SurName"
                                width: 200 }

                        }

                    }
                }

                Label {
                    id: labelBorn
                    text: qsTr("Born :     ")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.column: 1
                    Layout.row : 4
                    Layout.columnSpan: 1
                    Layout.fillWidth: true

                    TextField {
                        id: textFieldBirthDate
                        y: -4
                        width: 130
                        text: qsTr("*  Birthdate")
                        anchors.verticalCenterOffset: 0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 63
                    }

                    TextField {
                        id: textFieldBirthPlace
                        y: 42
                        width: 200
                        text: qsTr("*  Birthplace")
                        anchors.verticalCenterOffset: 0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 263
                        Layout.columnSpan: 2
                    }
                }

                Label {
                    id: labelDied
                    text: qsTr("Died ( Age ) :")
                    Layout.column: 1
                    Layout.row : 5
                    Layout.columnSpan: 1

                    TextField {
                        id: textFieldDeathDate
                        y: -122
                        width: 130
                        text: qsTr("*  Deathdate")
                        anchors.verticalCenterOffset: 0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 63
                        Layout.columnSpan: 1
                    }

                    TextField {
                        id: textFieldDeathPlace
                        y: 22
                        width: 200
                        text: qsTr("*  Deathplace")
                        anchors.verticalCenterOffset: 0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 263
                        Layout.columnSpan: 1
                    }
                }

                Label {
                    id: labelMarried

                    text: qsTr("Married ")
                    Layout.column: 1
                    Layout.row : 6
                    Layout.columnSpan: 1

                    TextField {
                        id: textFieldMarryDate
                        y: 54
                        width: 130
                        text: qsTr("*  Marrydate")
                        anchors.verticalCenterOffset: -4
                        anchors.left: parent.left
                        anchors.leftMargin: 60
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    TextField {
                        id: textFieldMarryPlace
                        y: 54
                        width: 198
                        height: 20
                        text: qsTr("*  Marryplace")
                        anchors.verticalCenterOffset: -4
                        anchors.left: parent.left
                        anchors.leftMargin: 262
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.columnSpan: 2
                    }

                    Label {
                        id: labelPartners
                        x: 487
                        y: 40
                        width: 85
                        height: 13
                        text: qsTr("     Partners")
                        anchors.verticalCenter: textFieldMarryDate.verticalCenter
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

                        TableView {
                            id: tabViewPartners
                            x: 280
                            y: 51
                            width: 400
                            height: 80
                            Layout.columnSpan: 3
                            horizontalScrollBarPolicy : Qt.ScrollBarAlwaysOff

                            TableViewColumn {
                                width: 40
                                role: "bYear"
                                title: "Born"
                            }

                            TableViewColumn {
                                width: 40
                                role: "dYear"
                                title: "Died"
                            }

                            TableViewColumn {
                                width: 150
                                role: "givenName"
                                title: "Given name"
                            }

                            TableViewColumn {
                                width: 200
                                role: "surName"
                                title: "SurName"
                            }
                            anchors.top: parent.top
                            Layout.fillWidth: false
                            anchors.left: parent.left
                            Layout.rowSpan: 1
                            anchors.topMargin: 30
                            anchors.leftMargin: 50
                            model: partners
                        }

                        Label {
                            id: labelChildren
                            width: 85
                            height: 13
                            text: qsTr("   Children")
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            anchors.top: parent.top
                            anchors.topMargin: 120
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

                            TableView {
                                id: tabViewChildren
                                x: 302
                                y: 42
                                width: 400
                                height: 200
                                Layout.columnSpan: 3
                                horizontalScrollBarPolicy : Qt.ScrollBarAlwaysOff

                                TableViewColumn {
                                    width: 40
                                    role: "bYear"
                                    title: "Born"
                                }

                                TableViewColumn {
                                    width: 40
                                    role: "dYear"
                                    title: "Died"
                                }

                                TableViewColumn {
                                    width: 150
                                    role: "givenName"
                                    title: "Given name"
                                }

                                TableViewColumn {
                                    width: 200
                                    role: "surName"
                                    title: "SurName"
                                }
                                anchors.top: parent.top
                                Layout.fillWidth: false
                                anchors.left: parent.left
                                Layout.rowSpan: 1
                                anchors.topMargin: 30
                                anchors.leftMargin: 50
                                model: childs
                            }
                        }
                    }
                }

                Label {
                    id: labelDivorced
                    width: 85
                    height: 13
                    text: qsTr("    Divorced")
                    Layout.rowSpan: 1
                    Layout.columnSpan: 2
                    Layout.row : 7

                    TextField {
                        id: textFieldDivorceDate
                        x: 73
                        y: -3
                        width: 130
                        height: 20
                        text: qsTr("*  Divorcedate")
                    }

                    TextField {
                        id: textFieldDivorcePlace
                        y: -50
                        width: 198
                        height: 20
                        text: qsTr("*  Divorceplace")
                        anchors.verticalCenterOffset: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 271
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.columnSpan: 1
                    }
                }

                Label {
                    id: labelOccupation
                    text: qsTr("    Occupation")
                    Layout.rowSpan: 1
                    Layout.columnSpan: 2
                    Layout.row : 9



                    TextField {
                        id: textFieldOccupation
                        x: 73
                        y: -7
                        width: 400
                        text: qsTr("*  Occupation")
                        anchors.verticalCenterOffset: 0
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.rowSpan: 1
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                    }
                }

                Label {
                    id: labelPersonNote

                    text: qsTr("   Person-Note")
                    Layout.rowSpan: 1
                    Layout.columnSpan: 2
                    Layout.row : 10

                    Button {
                        id: buttonGender
                        x: 89
                        y: 1
                        text: qsTr("Select Gender")
                        checked: true
                        checkable: true
                    }

                    TextEdit {
                        id: textEditPnote
                        width: 500
                        height: 200
                        anchors.top: parent.top
                        anchors.topMargin: 30



                    }



                }


            }







        }


    }




    Rectangle {
        id: rectSelect
        width: 600
        height: 500
        color: "#d3d3b5"
        radius: 2
        anchors.left: parent.left
        anchors.leftMargin: 500
        anchors.top: rectPerson.bottom
        anchors.topMargin: 0
        antialiasing: true
        smooth: true
        enabled: true
        z: 4
        visible: false

        Text {
            id: textFieldSelection
            x: 0
            text: qsTr("Please Enter options to restrict the search")
            verticalAlignment: Text.AlignVCenter
            renderType: Text.NativeRendering
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            Layout.fillWidth: true
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            visible: true

            Text {
                id: textFieldSelectType
                x: 253
                text: qsTr("* person/child/partner/parent")
                anchors.top: parent.top
                anchors.topMargin: 19
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 12
            }

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

                    Button {
                        id: buttonAddPerson
                        x: 275
                        y: 5
                        text: qsTr("add new person")
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    GroupBox {
                        id: genderBox
                        x: 173
                        width: 100
                        height: 200
                        checked: false
                        checkable: false
                        anchors.top: parent.top
                        anchors.topMargin: -5
                        anchors.right: parent.right
                        anchors.rightMargin: -100
                        title: qsTr("    Select gender")
                        ExclusiveGroup{id: genderSelection}
                        RadioButton {
                            id: radioButtonMale
                            x: 10
                            text: qsTr("Male")
                            anchors.top: parent.top
                            anchors.topMargin: 5
                            anchors.left: parent.left
                            anchors.leftMargin: 20

                            exclusiveGroup: genderSelection
                        }

                        RadioButton {
                            id: radioButtonFemale
                            x: 400
                            text: qsTr("Female")
                            anchors.top: parent.top
                            anchors.topMargin: 25
                            exclusiveGroup: genderSelection
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                        }

                        RadioButton {
                            id: radioButtonUnknown
                            x: 400
                            text: qsTr("Unknown")
                            anchors.top: parent.top
                            anchors.topMargin: 50
                            exclusiveGroup: genderSelection
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                        }
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
                }
            }

            Text {
                id: textSelectionTo
                x: -4
                text: qsTr("                 and ...")
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

                    Button {
                        id: buttonAddStop
                        x: 275
                        y: 2
                        text: qsTr("Stop Selection")
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            TableView {
                id: tabViewSelect
                width: 400
                height: 300
                selectionMode: 0
                sortIndicatorVisible: false
                sortIndicatorOrder: -1
                sortIndicatorColumn: 0
                anchors.left: textSelectionTo.right
                anchors.leftMargin: -20
                anchors.top: textSelectionTo.bottom
                anchors.topMargin: 20
                clip: true
                visible: true
                antialiasing: true
                z: 1
                verticalScrollBarPolicy: 2
                backgroundVisible: true
                model: selectOther
                Layout.columnSpan: 3
                Layout.fillWidth: false
                horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
                Layout.rowSpan: 1

                TableViewColumn {
                    width: 40
                    title: "Born"
                    role: "bYear"
                }

                TableViewColumn {
                    width: 40
                    title: "Died"
                    role: "dYear"
                }

                TableViewColumn {
                    width: 150
                    title: "Given name"
                    role: "givenName"
                }

                TableViewColumn {
                    width: 200
                    title: "SurName"
                    role: "surName"
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





}

