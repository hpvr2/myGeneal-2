import QtQuick 2.0

Item {                                  // Definition of a family object

    property int pid: 0
    property int husband : 0            //todo : use object directly
    property int wife : 0               //todo : use object directly

    property string marriageDate: ""
    property string marriagePlace  : ""

    property string divorceDate  : ""
    property string divorcePlace  : ""

    property var     children     : []   //todo : use object directly

    property string note  : ""

    function prt(){
        console.log(pid + " " + husband+  " " + wife + " " + marriageDate + marriagePlace +" Childs " + children)
    }
}


