import QtQuick 2.0

Item {                                          // Definition of a person object

    property int pid: 0
    property string gname : ""
    property string sname : ""
    property string gender: ""
    property string occu  : "not known"

    property string birthdate  : "not known"
    property string birthplace  : "not known"

    property string deathdate  : "not known"
    property string deathplace  : "not known"

    property string marriagedate  : "not known"
    property string marriageplace  : "not known"

    property string divorcedate  : "not known"
    property string divorceplace  : "not known"

    property string christiandate  : "not known"
    property string christianplace  : "not known"

    property string note  : ""

    property int childOfFamily : 0                  //todo : use object directly
    property var parentInFamily : [0]               //todo : use object directly


    function prt(){
        console.log(pid + " " + gname+  " " + sname + " FAMC "+ childOfFamily + " FAMS " + parentInFamily)
    }


}
