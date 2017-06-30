import QtQuick 2.0

Item {                                          // Definition of a person object

    property string pid: "0"
    property string givenName : ""
    property string surName : ""
    property string gender: ""
    property string occupation  : ""

    property string birthDate  : ""
    property string birthPlace  : ""

    property string deathDate  : ""
    property string deathPlace  : ""

    property string divorceDate  : ""
    property string divorcePlace  : ""

    property string christianDate  : ""
    property string christianPlace  : ""

    property string note  : ""

    property var childOfFamily                   //todo : use object directly
    property var parentInFamily : ({})               //todo : use object directly


    function prt(text){    // print person main data
        if (text==="") text="person"
        print(text,pid,givenName,surName,"FAMC",childOfFamily.pid,"FAMS")
 //       for (var i in parentInFamily){print("Partner Family",parentInFamily[i].pid)}
    }

//    function father(){   // return father-person
//        if ( childOfFamily === 0 ) return( persons[0])
//        return(persons[families[childOfFamily].husband])
//    }
//    function mother(){   // return mother-person
//        if ( childOfFamily === 0 ) return( persons[0])
//        return(persons[families[childOfFamily].wife])
//    }
    function age(){
        var yb = yearOf(birthDate)
        if (isNaN(yb)) yb = -1
        var yd = yearOf(deathDate)
        if (isNaN(yd)) yd = -1
        if (yb === -1) return("* unknown *")
        if (yd === -1) yd = 2017   // todo
        if ((yd-yb) > standard.maxAge) return("* assumed dead *")
        else return (String(yd - yb))
    }
    function yearOf(gedDate){
        var tempYear = gedDate.split(" ")
        tempYear =tempYear[tempYear.length-1]
        if (isNaN(tempYear) | tempYear ==="") return( "----" )
        else return(tempYear)
    }
}
