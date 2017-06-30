import QtQuick 2.0

Item {                                  // Definition of a family object

    property string pid: "0"
    property var husband            //todo : use object directly
    property var wife              //todo : use object directly

    property string marriageDate: ""
    property string marriagePlace  : ""

    property string divorceDate  : ""
    property string divorcePlace  : ""

    property var     children     : ({})   //todo : use object directly

    property string note  : ""

    function prt(text){
        if ( text==="") text = "*Family"
        print(text,pid,husband.pid,wife.pid,marriageDate)
    }
}


