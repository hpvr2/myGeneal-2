import QtQuick 2.0

Item {                                          // Definition of a person object

    property int pid: 0
    property string givenName : ""
    property string surName : ""
    property string gender: ""
    property string occupation  : ""

    property string birthDate  : ""
    property string birthPlace  : ""
    property string birthYear    : "    "

    property string deathDate  : ""
    property string deathPlace  : ""
    property string deathYear    : "    "

    property string divorceDate  : ""
    property string divorcePlace  : ""

    property string christianDate  : ""
    property string christianPlace  : ""

    property string note  : ""

    property int childOfFamily : 0                  //todo : use object directly
    property var parentInFamily : []               //todo : use object directly


    function prt(){
        console.log(pid + " " + givenName+  " " + surName + " FAMC "+ childOfFamily + " FAMS " + parentInFamily)
    }


}
