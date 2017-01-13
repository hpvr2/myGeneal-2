import QtQuick 2.0

Item {                                  // Definition of a family object

    property int pid: 0
    property int husband : 0            //todo : use object directly
    property int wife : 0               //todo : use object directly

    property string marriagedate: ""
    property int    marriageyear  : 0    //todo : extract year
    property string marriageplace  : ""

    property string divorcedate  : ""
    property string divorceplace  : ""

    property var     children     : []   //todo : use object directly

    property string note  : ""

    function prt(){
        console.log(pid + " " + husband+  " " + wife + " " + marriagedate + " Childs " + children)
    }


}


