import QtQuick 2.7
import QtQuick.Controls 1.4

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

    //    property alias listViewPartners: listViewPartners
    //    property alias listViewChilds: listViewChilds
    //property alias mouseAreaParents: mouseAreaParents
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
    property alias radioButtonMale: radioButtonMale
    property alias textFieldSelectName: textFieldSelectName
    property alias textSelection: textSelection
    
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
    
    width: 1000
    property alias tabViewSelect: tabViewSelect
    property alias tabViewChildren: tabViewChildren
    property alias tabViewPartners: tabViewPartners
    property alias tabViewParents: tabViewParents
    property alias labelBorn: labelBorn


    property alias buttonSave: buttonSave
    property alias buttonReadCSV: buttonReadCSV
    property alias buttonReadGedcom: buttonReadGedcom
    property alias textFieldSelectTo: textFieldSelectTo
    property alias textFieldSelectFrom: textFieldSelectFrom
    x: 0
    y: 50
    z: 2147483646
    anchors.topMargin: 50
    anchors.fill: parent

    
    

    Rectangle {
        id: rectPerson
        
        color: "#dedcdc"
        visible: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        
        Rectangle{ id: rectangle; x: 8; y: -58; width: 985; height: 50; color: "#8f8787"; RowLayout{
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

            //row 4

            GridLayout {
                id: gridLayout
                x: 8
                y: 84
                width: 200
                rowSpacing: 27
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.top: parent.top
                anchors.topMargin: 84
                visible: true
                columnSpacing: 13
                rows: 20
                columns:20
                Layout.fillHeight: true
                Layout.fillWidth: true



                Label {
                    id: labelPid
                    text: qsTr("Person Id :     ")
                    anchors.fill: parent
                    verticalAlignment: Text.AlignTop
                    horizontalAlignment: Text.AlignLeft
                    transformOrigin: Item.TopLeft

                    Layout.column: 1
                    Layout.row :3

                    TextField {
                        id: textFieldGivenName
                        x: 100
                        y: 0
                        width: 180

                        text: qsTr("* Givenname")
                        anchors.verticalCenterOffset: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 101
                        anchors.verticalCenter: labelParents.verticalCenter
                        Layout.preferredWidth: -1
                        Layout.minimumWidth: 200


                    }

                    TextField {
                        id: textFieldSurName
                        x: 500
                        y: 0
                        width: 200
                        text: qsTr("*  Surname")
                        anchors.left: parent.left
                        anchors.leftMargin: 300
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
                    Layout.column: 1
                    Layout.row : 4
                    Layout.columnSpan: 1
                    Layout.fillWidth: false

                    TextField {
                        id: textFieldBirthDate
                        y: -4
                        width: 130
                        text: qsTr("*  Birthdate")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 100
                    }

                    TextField {
                        id: textFieldBirthPlace
                        y: 42
                        width: 200
                        text: qsTr("*  Birthplace")
                        anchors.verticalCenterOffset: 0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 302
                        Layout.columnSpan: 2
                    }
                }

                Label {
                    id: labelDied
                    text: qsTr("Died : ")
                    Layout.column: 1
                    Layout.row : 5
                    Layout.columnSpan: 1

                    TextField {
                        id: textFieldDeathDate
                        y: -122
                        width: 130
                        text: qsTr("*  Deathdate")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 100
                        Layout.columnSpan: 1
                    }

                    TextField {
                        id: textFieldDeathPlace
                        y: 22
                        width: 200
                        text: qsTr("*  Deathplace")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 300
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
                        anchors.left: parent.left
                        anchors.leftMargin: 100
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    TextField {
                        id: textFieldMarryPlace
                        y: 54
                        width: 198
                        height: 20
                        text: qsTr("*  Marryplace")
                        anchors.left: parent.left
                        anchors.leftMargin: 300
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
                            anchors.leftMargin: 66
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
                                anchors.leftMargin: 66
                                model: childs
                            }
                        }
                    }
                }

                Label {
                    id: labelDivorced
                    width: 85
                    height: 13
                    text: qsTr("   Divorced")
                    Layout.rowSpan: 1
                    Layout.columnSpan: 2
                    Layout.row : 7

                    TextField {
                        id: textFieldDivorceDate
                        x: 124
                        y: 0
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
                        anchors.verticalCenterOffset: 3
                        anchors.left: parent.left
                        anchors.leftMargin: 310
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.columnSpan: 1
                    }
                }

                Label {
                    id: labelOccupation
                    text: qsTr("      Occupation")
                    Layout.rowSpan: 1
                    Layout.columnSpan: 2
                    Layout.row : 9



                    TextField {
                        id: textFieldOccupation
                        x: 118
                        y: -7
                        width: 400
                        text: qsTr("*  Occupation")
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
        x: 1000
        width: 300
        height: 500
        color: "#d3d3b5"
        radius: 2
        antialiasing: true
        smooth: true
        enabled: true
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: -174
        anchors.leftMargin: 470
        anchors.fill: parent
        z: 4
        visible: false

        Text {
            id: textSelection
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
                        //autoExclusive: false
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
                        //autoExclusive: false
                        anchors.left: parent.left
                        anchors.leftMargin: 200
                    }
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

                    RadioButton {
                        id: radioButtonUnknown
                        x: 141
                        y: 255
                        text: qsTr("Unknown")
                        anchors.verticalCenter: parent.verticalCenter
                        //autoExclusive: false
                        anchors.left: parent.left
                        anchors.leftMargin: 200
                    }
                }
            }

            TableView {
                id: tabViewSelect
                width: 400
                height: 400
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

