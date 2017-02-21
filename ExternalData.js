// ExternalData : functions to handle I/O to other ( non-Gedcom ) files
function setInit(){
    var constants = {
        path : "file:///C:/Users/hans-/OneDrive/Data/", // todo : define user specific path
        infile : "Bertram.ged",

        maleColor  : "yellow",
        femaleColor : "pink",

        firstYear : 1500,
        lastYear  : 2017 ,  // todo : use actual year

        ageAtBirth_male   : 19,
        ageAtBirth_female : 16,
        maxAge_father     : 60,
        maxAge_mother     : 50,
        maxAge            : 100,
        maxAgeDelta_childs   : 40,
        maxAgeDelta_partners : 60,
    }
    return constants
}
//#########################################################
function readIni(){                       //todo:  not yet tested
    console.log("readIni called" );
    var path = "file:///C:/Users/hans-/documents/myGeneal/myGeneal.ini"
    var text = genealFile.readFile(path);          // read file and split into lines
    var a = text.split("\n");
    var i = 0
    console.log("ini")
    var line
    var token= []
    // ******** = ********************************************************************************
    for (i = 0; i < a.length; i++) {                // first loop : ignore header : todo

        line =a[i]
        line = line.replace(/\s\s+/g, ' ');print(line)
        token = line.split(" ")
        for ( i=0; i<token.length;i++){print(i+"*"+token[i])}
        //console.log(line)
        switch (token[0]){
        case "Path"               :{ path = token[1]; print("*"+token[1]);break}
        case "Infile"             :{ infile = token[1]; print(infile); break}
        case "Outfile"            :{ outfile = token[1]; break}
        // case "DebugOn"           :{ ........... break}

        case "Malecol"            : {maleColor = token[1]; break}
        case "Femalecol"          : {femaleColor = token[1]; break}
        case "Firstyear"          : {firstYear = token[1]; break}
        case "Lastyear"           : {lastYear = token[1]; break}
        case "Ageatbirth_male"    : {ageAtBirth_male = token[1]; break}
        case "Ageatbirth_female"  : {ageAtBirth_female = token[1]; break}
        case "Maxage_father"      : {maxAge_father = token[1]; break}
        case "Maxage_mother"      : {maxAge_mother = token[1]; break}
        case "Maxage"             : { maxAge = token[1]; break}
        case "Maxdelta_childs"    : {maxAgeDelta_childs = token[1]; break}
        case "Maxdelta_partners"  : {maxAgeDelta_partners = token[1]; break}
        case "Startid"            : {startid = token[1]; break}
        default                   : {console.log("invalid value : " + line)
        }
        }
    }
}

//#####################################################
function writeCSV(){
    print ("write CSV")
    var text = ""
    var nl = "\n"
    for ( var i in persons){
        var person = persons[i]
        text = text + person.pid + ";"+person.gender + ";" +person.givenName + ";" + person.surName
        text = text + ";" + person.birthDate + ";" + person.birthPlace
        text = text + ";" + person.christianDate + ";" + person.christianPlace
        text = text + ";" + person.deathDate + ";" + person.deathPlace + ";" + person.occupation
        text = text + ";" + person.childOfFamily + ";" + person.parentInFamily
        text = text + ";" + person.note.replace(/\n/g, "/*/").replace(/;/g, "/#/")+ nl
    }
    var fileid = "file:///C:/Users/hans-/documents/myGeneal/p-autosave.csv"
    // print(fileid)
    console.log(genealFile.fileExists(fileid))

    var x = genealFile.writeFile(fileid,text)
    //###########################################
    text = ""
    for (i in families) {
        var family = families[i]
        text = text + family.pid + ";" + family.husband + ";" +family.wife + ";"
        text = text + family.marriageDate + ";" + family.marriagePlace
        text = text + ";" + family.divorceDate + ";" + family.divorcePlace
        text = text + ";" + family.children + ";"
        text = text + family.note.replace(/\n/g, "/*/").replace(/;/g, "/#/")+ nl
    }
    fileid = "file:///C:/Users/hans-/documents/myGeneal/f-autosave.csv"
    // print(fileid)
    console.log(genealFile.fileExists(fileid))

    x = genealFile.writeFile(fileid,text)
}
//###########################################
function readCSV_P(fileid){
    console.log(genealFile.fileExists(fileid))
    var text = genealFile.readFile(fileid)
    var nl = "\n"
    text  = text.split(nl)
    print("Text :"+text+"*")
    var creatorP = Qt.createComponent("Person.qml")   // define factory for person
    var person = creatorP.createObject(appWindow)

    var CSV
    var x

    personIndex.length = 0
    persons.length = 0

    for (var i in  text) {
        if (text[i].length === 0 ) break
        CSV = text[i].split(";")
        person = creatorP.createObject(appWindow)

        person.pid = CSV[0]
        person.gender = CSV[1]
        person.givenName = CSV[2]
        person.surName  = CSV[3]
        person.birthDate  = CSV[4]
        x = CSV[4].split(" ")
        x =x[x.length-1]
        person.birthYear = x
        person.birthPlace = CSV[5]
        person.christianDate = CSV[6]
        person.christianPlace = CSV[7]
        person.deathDate  = CSV[8]
        x = CSV[8].split(" ")
        x =x[x.length-1]
        person.deathYear = x
        person.deathPlace  = CSV[9]
        person.occupation  = CSV[10]
        person.childOfFamily = CSV[11]
        x = CSV[12].split(",")
        person.parentInFamily.length =0
        for ( var j in x) {
            person.parentInFamily.push(x[j])
        }
        person.note =  CSV[13].replace("/*/",nl ).replace("/#/", ";")
        persons.push(person)
        personIndex.push(person.pid)
    }

    var xx =Math.max.apply(Math,personIndex)
//    print("p-max "+xx)
    for ( i = 1; i <xx; i++) {
        if ( i in personIndex ){
            if ( personIndex.indexOf(i) <=0 ) {unusedPersons.push(i)}
        }
    }
//  print(unusedPersons)

    return

}
//##############################################
function readCSV_F(fileid){
    console.log(genealFile.fileExists(fileid))
    var text = genealFile.readFile(fileid)

    var nl = "\n"
    text  = text.split(nl)

    var creatorF = Qt.createComponent("Family.qml")   // define factory for person
    var family = creatorF.createObject(appWindow)
    var CSV
    var x

    families.length = 0
    familyIndex.length = 0

    for (var i in  text) {
        if (text[i].length === 0 ) break

        CSV = text[i].split(";")

        family = creatorF.createObject(appWindow)

        family.pid = CSV[0]
        family.husband = CSV[1]
        family.wife = CSV[2]
        family.marriageDate = CSV[3]
        family.marriagePlace = CSV[4]
        family.divorceDate = CSV[5]
        family.divorcePlace = CSV[6]
        x = CSV[7].split(",")
        for ( var j in x) {
            family.children.push(x[j]) }
        family.note = CSV[8].replace("/-/",nl ).replace("/#/", ";")
        families.push(family)
        familyIndex.push(family.pid)
    }
    return
}
//##############################################
function writeHtmlP1(){
    print("starting writehtml")
    // path = "C:/Users/hans-/mygeneal/Html/"
    // toc = open(path + "index.html","wt+")

    //************************************
    for ( var i in persons){
        var person = persons[i]
        External.writeHtmlPers(i)
    }
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
    //************************************************
    // sort by name
    var sortedPersons = persons.slice()

    sortedPersons.sort(function(a, b) {
        var gnameA = a.givenName.toUpperCase(); // ignore upper and lowercase
        var gnameB = b.givenName.toUpperCase();
        var snameA = a.surName.toUpperCase();
        var snameB = b.surName.toUpperCase();

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
    for (  i in sortedPersons){
        person = sortedPersons[i]
        var initial = person.surName.substr(0,1)
        if ( person.surName.length >0 && initial >= "A" ) {
            if ( last_initial < initial){
                last_initial = initial
                text = text + "<a name='"+ last_initial + "'></a><br />"
            }
        }
        if (last_surn !== person.surName) {
            last_surn = person.surName
            text = text + "<b>" + person.surName +"</b><br />"
        }
        text = text + "<blockquote><a href='" + person.pid +".html'> " + person.givenName + "</a>" +
                "       " +  person.birthYear + " - " +person.deathYear+ "</blockquote>" + nl


    }
    //************************
    text = text + "<center><font size='-2'>Created by myGeneal <br /></font><br /></center>" + nl
    text = text + "</blockquote></blockquote>" + nl

    text = text + "</body></html>" + nl


    var fileid = "file:///C:/Users/hans-/documents/myGeneal/Html/index.html"

    var x = genealFile.writeFile(fileid,text)

}
function writeHtmlPers(i){

    var nl = "\n"
    var text = ""
    var x = ""
    var parents = null

    person = persons[i]
    if ( person.pid === 0 ) return
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
    parents = families[familyIndex.indexOf(person.childOfFamily)]
    var father = persons[personIndex.indexOf(parents.husband)]
    var mother = persons[personIndex.indexOf(parents.wife)]
    text = text + "<tr><td><b>Father  : </b></td>" +
            "<td><a href='"  + father.pid + ".html'>" + father.surName + ", "+ father.givenName + "</td>" +
            "<td> " + father.birthYear + " - " + father.deathYear  + nl

    text = text + "<tr><td><b>Mother : </b></td>" +
            "<td><a href='"  + mother.pid + ".html'>" + mother.surName + ", "+ mother.givenName + "</td>" +
            "<td> " + mother.birthYear + " - " + mother.deathYear + " <br />" + nl
    text = text + "<tr><td><br /></td></tr>" + nl
    if ( parents.children.length >= 1 ) {
        for (var j in parents.children) {
            if ( personIndex.indexOf(parseInt(parents.children[j])) === -1 ) continue
            var child = persons[personIndex.indexOf(parseInt(parents.children[j]))]
            if (person.pid === child.pid ) continue

            if ( child.gender === "M" ){ x = "Brother    : "}
            else                       { x = "Sister     : " }
            text = text + "<tr><td><b>" + x + "</b></td><td><a href='"  + child.pid + ".html'>" +
                    child.surName + ", "+ child.givenName + "</td>" +
                    "<td> " + child.birthYear + " - " + child.deathYear + " <br />" + nl

        }
    }
    //*******************************

    for (j = 0 ; j < person.parentInFamily.length; j++){
        var xx = parseInt(person.parentInFamily[j])
        if ( isNaN(xx)) break                                       // TODO : check why, only occurs in readCSV
        if (xx !== 0 && xx  !== ""){

            if (person.parentInFamily[j] <= 0)  { print("ignoring "+ parseInt(person.parentInFamily[j])) ; continue}
            var partnerFamily = families[familyIndex.indexOf(parseInt(person.parentInFamily[j]))]
            if ( person.gender === "M" ){ x = "Wife    : "
                var partner = persons[personIndex.indexOf(parseInt(partnerFamily.wife))]
            }
            else                        { x = "Husband : "
                partner =  persons[personIndex.indexOf(parseInt(partnerFamily.husband))]
            }
            text = text + " <br /> <br />" + nl
            text = text + "<tr><td><b>" + x + "</b></td><td><a href='"  + partner.pid + ".html'>" +
                    partner.surName + ", "+ partner.givenName + "</td>" +
                    "<td> " + partner.birthYear + " - " + partner.deathYear + " <br />" + nl
            text = text + " <br /> <br />" + nl
            //********************************************
            for (j=0; j< partnerFamily.children.length; j++){
                if ( isNaN(parseInt(partnerFamily.children[j]))) continue
                child = persons[personIndex.indexOf(parseInt(partnerFamily.children[j]))]
                if (child.gender === "M" ) x = "Son           : "
                else                       x = "Daughter      : "
                text = text + "<tr><td><b>" + x + "</b></td><td><a href='"  + child.pid + ".html'>" +
                        child.surName + ", "+ child.givenName + "</td>" +
                        "<td> " + child.birthYear + " - " + child.deathYear + " <br />" + nl


            }
        }
    }

    text = text + "</table>" + nl
    text = text + "<br /><hr />" + nl
    text = text + "<center><font size='-2'>Created by myGeneal <br /></font><br /></center>" + nl
    text = text + "</blockquote></blockquote>" + nl

    text = text + "</body>" + nl
    text = text + "</html>" + nl

    var fileid = "file:///C:/Users/hans-/documents/myGeneal/Html/" + person.pid +".html"
    //    print(fileid)
    //    console.log(genealFile.fileExists(fileid))

    x = genealFile.writeFile(fileid,text)
}
