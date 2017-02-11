// ExternalData : functions to handle I/O to other ( non-Gedcom ) files
function setInit(){
    var constants = {
        path : "file:///C:/Users/hans-/Documents/QML-Geneal/myGeneal-2/Data/", // todo : define user specific path
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
    var path = "file:///C:/Users/hans-/Documents/QML-Geneal/myGeneal-2/Data/myGeneal.ini"
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
    var fileid = "file:///C:/Users/hans-/Documents/QML-Geneal/myGeneal-2/Data/p-autosave.csv"
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
    fileid = "file:///C:/Users/hans-/Documents/QML-Geneal/myGeneal-2/Data/f-autosave.csv"
    // print(fileid)
    console.log(genealFile.fileExists(fileid))

    x = genealFile.writeFile(fileid,text)
}
//###########################################
function readCSV_P(){
    //var fileid = "file:///C:/Users/hans-/Documents/QML-Geneal/myGeneal-2/Data/p-autosave.csv"
    var fileid = "file:///C:/Users/hans-/Documents/QML-Geneal/myGeneal-2/Data/myGeneal.ini"
    print(fileid)
    console.log(genealFile.fileExists(fileid))
    var text = genealFile.readFile(fileid)
    print(text)
    console.log("from file : " + text)

    text  = text.split("\n")
    print("as lines "+ text)
    var creatorP = Qt.createComponent("Person.qml")   // define factory for person
    var person = creatorP.createObject(appWindow)

    var CSV
    var x
    for (var i in  text) {
        CSV = text[i].split(";")
        print("CSV "+CSV)
        person = creatorP.createObject(appWindow)

        person.pid = CSV[0]
        person.gender = CSV[1]
        person.givenName = CSV[2]
        person.surName  = CSV[3]
        person.birthDate  = CSV[4]
        //    person.birthYear = self.datesort(person.bdate)
        person.birthPlace = CSV[5]
        person.christianDate = CSV[6]
        person.christianPlace = CSV[7]
        person.deathDate  = CSV[8]
        person.deathPlace  = CSV[9]
        person.occupation  = CSV[10]
        person.childOfFamily = CSV[11]
        x = CSV[12].split(",")
        for ( var j in x) {
            person.parentInFamily.push(x[j]) }
        person.note =  CSV[13].replace("/-/",nl ).replace("/#/", ";")

        persons.push(person)
    }
    //    for ( var j=0; j<persons.length;j++) {print(person[j].pid)}
    return


    //        if i > 0 and person.id == 0 : self.empty_indi.append(i)



}
//##############################################
function readCSV_F(){
    var fileid = "file:///C:/Users/hans-/Documents/QML-Geneal/myGeneal-2/Data/f-autosave.csv"
    print(fileid)
    console.log(genealFile.fileExists(fileid))
    var text = genealFile.readFile(fileid)
    print(text)
    console.log("from file : " + text)
    var nl = "\n"
    text  = text.split(nl)
    print("as lines "+ text)
    var creatorF = Qt.createComponent("Family.qml")   // define factory for person

    var CSV
    var x
    for (var i in  text) {
        CSV = text[i].split(";")

        family = creatorF.createObject(appWindow)

        family.pid = CSV[0]
        family.husband = CSV[1]
        family.wife = CSV[2]
        family.marriagDate = CSV[3]
        family.marriagePlace = CSV[4]
        family.divorceDate = CSV[5]
        family.divorcePlace = CSV[6]
        x = CSV[7].split(",")
        for ( var j in x) {
            family.children.push(x[j]) }
        family.note = CSV[8].replace("/-/",nl ).replace("/#/", ";")

        families.push(person)
    }
    //    for ( var j=0; j<persons.length;j++) {print(person[j].pid)}
    return
}
