// ExternalData : functions to handle I/O to other ( non-Gedcom ) files

function setInit(){          // set init values
    var c = {
        path : "file:///C:/Users/hans-/Documents/myGeneal",
   //     infile : "Bertram.ged",

        maleColor         : "blue",
        femaleColor       : "red",

        firstYear         : 1500,
        lastYear          : 20+ Qt.formatDateTime(new Date(), "yyMMdd").substring(0,2) ,  // actual year

        ageAtBirth_male   : 19, // TODO : not used  uptonow
        ageAtBirth_female : 16,
        maxAge_father     : 60,
        maxAge_mother     : 50,
        maxAge            : 100,
        maxAgeDelta_childs   : 40,
        maxAgeDelta_partners : 50,
    }
    return c
}
function readIni(){          // read init values ( TODO not active )
    console.log("readIni called" );
    var path = standard.path+"/myGeneal.ini"
    var text = genealFile.readFile(path);          // read file and split into lines
    var a = text.split("\n");
    var i = 0
    console.log("ini")
    var line
    var token= []
    // ******** = ********************************************************************************
    for (i = 0; i < a.length; i++) {                // first loop : ignore header : todo

        line =a[i]
        line = line.replace(/\s\s+/g, ' ')
        token = line.split(" ")
        switch (token[0]){
        case "Path"               : path = token[1];break
        case "Infile"             : infile = token[1]; break
        case "Outfile"            : outfile = token[1]; break
        // case "DebugOn"           : ........... break}

        case "Malecol"            : maleColor = token[1]; break
        case "Femalecol"          : femaleColor = token[1]; break
        case "Firstyear"          : firstYear = token[1]; break
        case "Lastyear"           : lastYear = token[1]; break
        case "Ageatbirth_male"    : ageAtBirth_male = token[1]; break
        case "Ageatbirth_female"  : ageAtBirth_female = token[1]; break
        case "Maxage_father"      : maxAge_father = token[1]; break
        case "Maxage_mother"      : maxAge_mother = token[1]; break
        case "Maxage"             : maxAge = token[1]; break
        case "Maxdelta_childs"    : maxAgeDelta_childs = token[1]; break
        case "Maxdelta_partners"  : maxAgeDelta_partners = token[1]; break
        case "Startid"            : startid = token[1]; break
        default                   : console.log("invalid value : " + line)
        }
    }
}
function writeCSV(){         // write CSV files
    var text = ""
    var nl = "\n"
    for ( var i in persons){
        var person = persons[i]
        text = text + person.pid + ";"+person.gender + ";" +person.givenName + ";" + person.surName
        text = text + ";" + person.birthDate + ";" + person.birthPlace
        text = text + ";" + person.christianDate + ";" + person.christianPlace
        text = text + ";" + person.deathDate + ";" + person.deathPlace + ";" + person.occupation
        text = text + ";" + person.childOfFamily +  ";"
        for ( i in person.parentInFamily) {
            if (person.parentInFamily[i] !== ""){
                text = text + person.parentInFamily[i]+ " "}
        }
        text = text + ";" + person.note.replace(/\n/g, "XNLX").replace(/;/g, "XSEMIX")+ nl
    }
//    console.log(genealFile.fileExists(standard.path+"/p-autosave.csv"))

    var x = genealFile.writeFile(standard.path+"/p-autosave.csv",text)
    //###########################################
    text = ""
    for (var i in families) {
        var family = families[i]
        text = text + family.pid + ";" + family.husband + ";" +family.wife + ";"
        text = text + family.marriageDate + ";" + family.marriagePlace
        text = text + ";" + family.divorceDate + ";" + family.divorcePlace+ ";"
        //        print("child-list",family.children)
        for ( i in family.children) {
            text = text  +family.children[i] +" "
        }

        text = text + ";"+ family.note.replace(/\n/g, "XNLX").replace(/;/g, "XSEMIX")+ nl
    }
//    console.log(genealFile.fileExists(standard.path+"/f-autosave.csv"))

    x = genealFile.writeFile(standard.path+"/f-autosave.csv",text)


}
function readCSV_P(fileid){  // read CSV file Persons
    console.log(genealFile.fileExists(fileid))
    var text = genealFile.readFile(fileid)
    var nl = "\n"
    text  = text.split(nl)

    var creatorP = Qt.createComponent("Person.qml")   // define factory for person
    var person = creatorP.createObject(appWindow)
    var creatorF = Qt.createComponent("Family.qml")   // define factory for family

    var person0 = creatorP.createObject(appWindow)     // empty person
    person0.pid= "0"


    var family0 = creatorF.createObject(appWindow)

    persons[0]=person0

    var CSV
    var x

    //persons.length = 0
    unusedPersons.length = 0


    for (var i in  text) {
        if (text[i].length === 0 ) break
        CSV = text[i].split(";")
        person = creatorP.createObject(appWindow)

        person.pid = CSV[0]
        if ( parseInt(person.pid) > maxid ) maxid = parseInt(person.pid)

        person.gender = CSV[1]
        person.givenName = CSV[2]
        person.surName  = CSV[3]
        person.birthDate  = CSV[4]
        person.birthPlace = CSV[5]
        person.christianDate = CSV[6]
        person.christianPlace = CSV[7]
        person.deathDate  = CSV[8]
        person.deathPlace  = CSV[9]
        person.occupation  = CSV[10]
        var id = CSV[11]
        person.childOfFamily = id

        x = CSV[12].split(" ")
        for ( var ii in x){
            if (x[ii] !== "" ) person.parentInFamily.push(x[ii])   }        person.note =  CSV[13].replace(/XNLX/g,nl ).replace(/XSEMIX/g, ";")
        persons[person.pid]=person
    }
    for ( var i=0; i<maxid; i++){if (!( i in persons )) unusedPersons.push(i) }

    for (  i in persons){

        personsSort[i]= {
            pid :  persons[i].pid,
            yb: persons[i].birthYearStr(),
            yd: persons[i].deathYearStr(),
            gn: persons[i].givenName,
            sn: persons[i].surName,
            gender:persons[i].gender}
    }

    personsSort.sort(function(a, b){return a.yb - b.yb});
    return

}
function readCSV_F(fileid){  // read CSV file families
    console.log(genealFile.fileExists(fileid))
    var text = genealFile.readFile(fileid)
    var nl = "\n"
    text  = text.split(nl)
    var creatorF = Qt.createComponent("Family.qml")   // define factory for person
    var family = creatorF.createObject(appWindow)
    var CSV
    var x
    var maxidFam = 0

    for (var i in  text) {
        if (text[i].length === 0 ) break

        CSV = text[i].split(";")

        family = creatorF.createObject(appWindow)

        family.pid = CSV[0]
        if ( parseInt(family.pid) > maxidFam ) maxidFam = parseInt(family.pid)

        family.husband = CSV[1]
        family.wife = CSV[2]
        family.marriageDate = CSV[3]
        family.marriagePlace = CSV[4]
        family.divorceDate = CSV[5]
        family.divorcePlace = CSV[6]
        x = CSV[7].split(" ")
        for ( var ii in x){
            if ( x[ii] !== "0"){
                 if (x[ii] !== "" ) family.children.push(x[ii])  }

        }
        family.note = CSV[8].replace(/XNLX/g,nl ).replace(/XSEMIX/g, ";")
        families[family.pid]=family
    }
    for ( i=0; i<maxidFam; i++){ if ( !( i in families ))  unusedFamilies.push(i) }

    return
}
function htmlHead1(){        // html header of index file

    //*************************************
    var nl = "\n"
    var text = ""
    text = text +"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN'>" + nl
    text = text +"<html>" + nl
    text = text +"<!-- *** File generated by myGeneal  *** -->" + nl

    text = text +"<head>" + nl
    text = text +"<meta http-equiv='CONTENT-TYPE' content='text/html; charset=iso-8859-1' />" + nl
    text = text +"<meta name='GENERATOR' content='myGeneal' />" + nl
    text = text +"<meta name='DESCRIPTION' content='myGeneal : Family files' />" + nl
    text = text +"<title>Family Index</title>" + nl
    text = text +"<style type='text/css'>" + nl
    text = text +"body { font-family:'Times New Roman',Times,serif; }" + nl
    text = text +"a:hover { color:#cc0000; }" + nl
    text = text +"</style></head>" + nl

    text = text +"<body text='#000000' link='#0000ee' alink='#0000ee' vlink='#551a8b' bgcolor='#ffffff' background='back.jpg'>" + nl
    text = text +"<center><font size='7'><b>Family Index</b></font><br /><br />Hans-Peter von Reth<br /></center>" + nl
    text = text +"<blockquote><blockquote>" + nl
    text = text +"<hr />" + nl
    text = text +"<center>" + nl
    text = text +"<a href='#UNKNOWN'><b>?</b></a> <a href='#A'><b>A</b></a> <a href='#B'><b>B</b></a>" +
            "<a href='#C'><b>C</b></a> <a href='#D'><b>D</b></a> <a href='#E'><b>E</b></a> " +
            "<a href='#F'><b>F</b></a> <a href='#G'><b>G</b></a> <a href='#H'><b>H</b></a> " +
            "<a href='#I'><b>I</b></a> <a href='#J'><b>J</b></a> <a href='#K'><b>K</b></a> " +
            "<a href='#L'><b>L</b></a> <a href='#M'><b>M</b></a> <a href='#N'><b>N</b></a> " +
            "<a href='#O'><b>O</b></a> <a href='#P'><b>P</b></a> <a href='#Q'><b>Q</b></a> " +
            "<a href='#R'><b>R</b></a> <a href='#S'><b>S</b></a> <a href='#T'><b>T</b></a> " +
            "<a href='#U'><b>U</b></a> <a href='#V'><b>V</b></a> <a href='#W'><b>W</b></a> " +
            "<a href='#X'><b>X</b></a> <a href='#Y'><b>Y</b></a> <a href='#Z'><b>Z</b></a> " +
            "<a href='#v'><b>v</b></a> " + nl
    text = text +"</center><hr />" + nl

    return text
}
function writeHtmlP1(){      // write html index file
    //************************************
    var nl = "\n"

    for ( var i in persons){
        var person = persons[i]
        External.writeHtmlPers(i)
    }

    //************************************************
    var text = htmlHead1()   // header
    // sort by name
    //    var sortedPersons = persons.slice()
    personsSort.sort(function(a, b){return a.yb - b.yb});
    personsSort.sort(function(a, b) {
        var gnameA = a.gn.toUpperCase(); // ignore upper and lowercase
        var gnameB = b.gn.toUpperCase();
        var snameA = a.sn.toUpperCase();
        var snameB = b.sn.toUpperCase();

        if (snameA < snameB) {  return -1 }
        if (snameA > snameB) {  return 1  }
        else {
            if (gnameA < gnameB) {  return -1 }
            if (gnameA > gnameB) {  return 1  }
        }

        return 0 // must be the same
    })
    //*********************************
    text = text + "<a name='UNKNOWN'> </a><b><font size='5'>.</font><font size='4'>..</font></b>" + nl

    var last_initial = " "
    var last_surn = " "
    var initial
    for (  i in personsSort){
        //        print("sort",personsSort[i].pid,personsSort[i].gn,personsSort[i].sn)
        person = personsSort[i]
        if (person.pid !== "0" ){
            if (person.sn.length > 0 ) initial = person.sn.substr(0,1)
            else initial= ""
            if ( person.sn.length >0 && initial >= "A" ) {
                if ( last_initial < initial){
                    last_initial = initial
                    text = text + "<a name='"+ last_initial + "'></a><br />"
                }
            }
            if (last_surn !== person.sn) {
                last_surn = person.sn
                text = text + "<b>" + person.sn +"</b><br />"
            }
            text = text + "<blockquote><a href='" + person.pid +".html'> " + person.gn + "</a>" +
                    "       " +   person.yb + " - " + person.yd+ "</blockquote>" + nl

        }
    }
    //************************
    text = text + "<center><font size='-2'>Created by myGeneal <br /></font><br /></center>" + nl
    text = text + "</blockquote></blockquote>" + nl

    text = text + "</body></html>" + nl


    var fileid = standard.path +"/Html/index.html"

    var x = genealFile.writeFile(fileid,text)

}
function writeHtmlPers(i){   // write html person file

    var nl = "\n"
    var text = ""
    var x = ""
    var parents = null

    person = persons[i]
//    person.prt("write html person :")
    if ( person.pid === "0" ) return

    text = text + "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN'>" + nl
    text = text + "<html>" + nl
    text = text + "<!-- *** File generated by myGeneal  *** -->" + nl
    text = text + "<head>" + nl
    text = text + "<meta http-equiv='CONTENT-TYPE' content='text/html; charset=iso-8859-1' />" + nl

    text = text + "<meta name='DESCRIPTION' content='PyGeneal Excerpt :"+ person.surName +" , " + person.givenName +"'  />" + nl
    text = text + "<title>" + person.surName +" , " + person.givenName +"</title>" + nl
    text = text + "<style type='text/css'>body{font-family:'Times New Roman',Times,serif; } a:hover { color:#cc0000; }</style>" + nl
    text = text + "</head>" + nl
    text = text + "<body text='#000000' link='#0000ee' alink='#0000ee' vlink='#551a8b' bgcolor='#ffffff' background='../back.jpg'>" + nl

    text = text + "<center>" + nl
    text = text + "<blockquote><blockquote><a href='index.html'><font size='2'><div align='right'>[zurück zur Startseite]" + nl
    text = text + "</div></font></a></blockquote></blockquote>" + nl
    text = text + "</center> <blockquote><blockquote>" + nl

    text = text + "<a name='" + person.pid +" '> </a>" + nl
    text = text + "<h2>" + person.surName +" , " + person.givenName + "</h2>" + nl
    text = text + "<hr />" + nl
    text = text + "<br />" + nl

    text = text + "<tr><td><b>Born        : </b></td><td>" + person.birthDate + " in : " + person.birthPlace + "</td> <br />" + nl
    text = text + "<tr><td><b>Died        : </b></td><td>" + person.deathDate + " in : " + person.deathPlace + "</td> <br />" + nl
    text = text + "<tr><td><b>Occupation  : </b></td><td>" + person.occupation + "</td> <br /><br />" + nl
    text = text + "<table border='0'>" + nl

//    print("*"+person.childOfFamily+"*")

    if (person.childOfFamily !== ""){
        parents = families[person.childOfFamily]
//        parents.prt("parents")
        if (parents.husband !== ""){
            var father = persons[parents.husband]
//            father.prt("father")
            text = text + "<tr><td><b>Father  : </b></td>" +
                    "<td><a href='"  + father.pid + ".html'>" + father.surName + ", "+ father.givenName + "</td>" +
                    "<td> " + father.birthYearStr() + " - " + father.deathYearStr() + nl

        }

        if ( parents.wife !== "" ){
            var mother = persons[parents.wife]
//            mother.prt("mother")
            text = text + "<tr><td><b>Mother : </b></td>" +
                    "<td><a href='"  + mother.pid + ".html'>" + mother.surName + ", "+ mother.givenName + "</td>" +
                    "<td> " + mother.birthYearStr() + " - " + mother.deathYearStr() + nl

        }

        text = text + "<tr><td><br /></td></tr>" + nl

        for (var j in parents.children) {
            if (parents.children[j] !== "0" & parents.children[j] !== ""){
                var child = persons[parents.children[j]]
//                child.prt("child")
                if (person.pid !== child.pid ) {
                    if ( child.gender === "M" ){ x = "Brother    : "}
                    else                       { x = "Sister     : " }
                    text = text + "<tr><td><b>" + x + "</b></td><td><a href='"  + child.pid + ".html'>" +
                            child.surName + ", "+ child.givenName + "</td>" +
                            "<td> " + child.birthYearStr() + " - " + child.deathYearStr()+ " <br />" + nl
                }
            }
        }
        //*******************************
    }
//    print("parentin",person.parentInFamily)
    for (j in  person.parentInFamily){
        var xx = person.parentInFamily[j]
//        print(j,xx)

        if (person.parentInFamily[j] === "0" | person.parentInFamily[j] === "")  {
            print("ignoring "+ parseInt(person.parentInFamily[j])) ; continue}
        var partnerFamily = families[person.parentInFamily[j]]
//        partnerFamily.prt("")
        if ( person.gender === "M" ){ x = "Wife    : "
            var partnerId = partnerFamily.wife
        }
        else                        { x = "Husband : "
            partnerId =  partnerFamily.husband
        }
//        print("partnerId",partnerId)
        if ( partnerId !== "") {
            var partner = persons[partnerId]
//            partner.prt("partner")
            text = text + " <br /> <br />" + nl
            text = text + "<tr><td><b>" + x + "</b></td><td><a href='"  + partner.pid + ".html'>" +
                    partner.surName + ", "+ partner.givenName + "</td>" +
                    "<td> " + partner.birthYearStr() + " - " + partner.deathYearStr() + " <br />" + nl
            text = text + " <br /> <br />" + nl
        }
        //********************************************
        for (j in partnerFamily.children){
            if (partnerFamily.children[j] !== ""){
                child = persons[partnerFamily.children[j]]
//                child.prt("child")
                if (child.gender === "M" ) x = "Son           : "
                else                       x = "Daughter      : "
                text = text + "<tr><td><b>" + x + "</b></td><td><a href='"  + child.pid + ".html'>" +
                        child.surName + ", "+ child.givenName + "</td>" +
                        "<td> " + child.birthYearStr() + " - " + child.deathYearStr() + " <br />" + nl
            }

        }

    }

    text = text + "</table>" + nl
    text = text + "<br /><hr />" + nl
    text = text + "<center><font size='-2'>Created by myGeneal <br /></font><br /></center>" + nl
    text = text + "</blockquote></blockquote>" + nl

    text = text + "</body>" + nl
    text = text + "</html>" + nl


    var fileid = standard.path + "/Html/" + person.pid +".html"
//    console.log(genealFile.fileExists(fileid))

    x = genealFile.writeFile(fileid,text)




}

