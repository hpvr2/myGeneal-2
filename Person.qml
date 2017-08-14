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

    property string childOfFamily : ""                  //todo : use object directly
    property var parentInFamily : []               //todo : use object directly


    function prt(text){    // print person main data
        if (text==="") text="person"
        print(text,pid,givenName,surName,"FAMC",childOfFamily,"FAMS",parentInFamily)
    }

    function father(){   // return father-person
        if ( childOfFamily === "") return( persons[0])
        return(persons[families[childOfFamily].husband])
    }
    function mother(){   // return mother-person
        if ( childOfFamily === ""  ) return( persons[0])
        return(persons[families[childOfFamily].wife])
    }
    function age(){
        var yb = birthYear()
        var yd = deathYear()
        if (yb === 0) return("* unknown *")
        if (yd === 0) yd = 2017   // todo
        if ((yd-yb) > standard.maxAge) return("* assumed dead *")
        else return (String(yd - yb))
    }
    function birthYearStr(){
        var tempYear = " " + birthDate
        tempYear = tempYear.split(" ")
        tempYear =tempYear[tempYear.length-1]
        if (isNaN(tempYear) | tempYear ==="") return( "9999" )
        else return (tempYear)
    }
    function deathYearStr(){
        var tempYear = " " + deathDate
        tempYear = tempYear.split(" ")
        tempYear =tempYear[tempYear.length-1]
        if (isNaN(tempYear) | tempYear ==="") return( "----" )
        else return (tempYear)
    }
    function birthYear(){
        var tempYear = birthDate.split(" ")
        tempYear =tempYear[tempYear.length-1]
        if (isNaN(tempYear) | tempYear ==="") return( 0 )
        else return(parseInt(tempYear))
    }
    function deathYear(){
        var tempYear = deathDate.split(" ")
        tempYear =tempYear[tempYear.length-1]
        if (isNaN(tempYear) | tempYear ==="") return( 0 )
        else return(parseInt(tempYear))
    }

    function yearOf(gedDate){
        var tempYear = gedDate.split(" ")
        tempYear =tempYear[tempYear.length-1]
        if (isNaN(tempYear) | tempYear ==="") return( "----" )
        else return(tempYear)
    }
}
