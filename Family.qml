import QtQuick 2.0

Item {                                  // Definition of a family object

    property string pid: "0"
    property string husband  : ""        //todo : use object directly
    property string wife     : ""          //todo : use object directly

    property string marriageDate: ""
    property string marriagePlace  : ""

    property string divorceDate  : ""
    property string divorcePlace  : ""

    property var     children     : []  //todo : use object directly

    property string note  : ""

    function prt(text){
        if ( text==="") text = "*Family"
        print(text,pid,husband,wife,marriageDate,children)
    }

}


