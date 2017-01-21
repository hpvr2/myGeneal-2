// Gedcom
function select(gender,name,from , to){
    print("Selection called : "+ gender +" "+ name + " "+ from+" "+ to   )
    selection.clear()
    name = name.toLowerCase()
    if ( from === "    ") from = 0
    var p1
    var x = ""
    var blank = "                                        "
    for ( var i in persons) {
        p1 = persons[i]
//        p1.prt()
        x = String(p1.surName).substring(0,name.length).toLowerCase()

//        print(x)
        if ( (gender === "" || gender === p1.gender) &&
            ( x === name) &&
                (from === "" || from < p1.birthYear) &&
                    (to === "" || to > p1.birthYear)
                ) {
            selection.append({"pid": p1.pid,
                           "givenName": p1.givenName.concat(blank).substr(0,30),
                           "surName"  : p1.surName.concat(blank).substr(0,30),
                           "bYear" : p1.birthYear,
                           "dYear" :p1.deathYear})
           }

    }
return
}
// #########################################################
function setRelatives(actualId){
    var blank = "                               "

    person = persons[actualId]

    parents.clear()
    partners.clear()
    childs.clear()

    if (person.childOfFamily !== 0){
        parentFamily = families[person.childOfFamily]
        var p1 = persons[parentFamily.husband]
        parents.append({ "pid": p1.pid,
                           "givenName": p1.givenName.concat(blank).substr(0,30),
                           "surName"  : p1.surName.concat(blank).substr(0,30),
                           "bYear" : p1.birthYear,
                           "dYear" :p1.deathYear}
                       )
        p1 = persons[parentFamily.wife]
        parents.append({"pid": p1.pid,
                           "givenName": p1.givenName.concat(blank).substr(0,30),
                           "surName"  : p1.surName.concat(blank).substr(0,30),
                           "bYear" : p1.birthYear,
                           "dYear" :p1.deathYear})
    }

    for (var i=0 ; i< person.parentInFamily.length ; i++){
        var xx = person.parentInFamily[i]
        if (xx !== 0){
            partnerFamily= families[xx]

            if (person.gender === "F"){ p1 = persons[partnerFamily.husband]}
            else {                      p1 = persons[partnerFamily.wife]}
            partners.append({"pid": p1.pid,
                                "givenName": p1.givenName.concat(blank).substr(0,30),
                                "surName"  : p1.surName.concat(blank).substr(0,30),
                                "bYear" : p1.birthYear,
                                "dYear" :p1.deathYear})
        } //todo : support for multiple families

        for (var i=0 ; i< partnerFamily.children.length ; i++){
            var xx = partnerFamily.children[i]
            p1 = persons[xx]
            childs.append({"pid": p1.pid,
                              "givenName": p1.givenName.concat(blank).substr(0,30),
                              "surName"  : p1.surName.concat(blank).substr(0,30),
                              "bYear" : p1.birthYear,
                              "dYear" :p1.deathYear})
        }
    }
 }
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
function readIni(){                       //todo:  not yet tested
    console.log("readIni called" );
    var path = "file:///C:/Users/hans-/Documents/QML-Geneal/myGeneal-2/Data/myGeneal.ini"
    var text = genealFile.readFile(path);          // read file and split into lines
    var a = text.split("\r\n");
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
//*************************************************************************************
function fillINDI(id,person0){
//    print("completing from : "+persons.length +" to: "+id)
    for (var j = persons.length; j <= id; j++) { // fill array with dummy
        persons.push(person0)                           // TODO : store empty position for later use
//        print("WRITING RECORD : "+j  )
    }
}

function parseINDI(a){                                // Extract Person data from GEDCOM array "a"
    var creatorP = Qt.createComponent("Person.qml")   // define factory for person
    var person0 = creatorP.createObject(appWindow)    // dummy first person
    var persons = []                                  // array of all persons
    persons.push(person0)
    var person = creatorP.createObject(appWindow)     // actual person

    var i = 0
    var dateFlag = "none"
    var tempDate = ""
    var tempYear = ""
    // ****************************************************************************************
    for (i = 0; i < a.length; i++) {                // first loop : ignore header
        //todo : extra function to store data for  later use

        var line =a[i]
        var token = line.split(" ");

        if ( token[2] === "INDI"){                              // first person Record found
            console.log("start of INDI Part found in line "+i +": "+ line);

            var xx = token[1].match(/\d+/g)[0]              // extract pid
//            print("first pid :"+xx)
            person.pid = xx
            fillINDI(xx,person0)
            break                                           // stop this loop
        }
    }
    // ****************************************************************************************

    for ( var i1 = i+1 ; i1< a.length; i1++)  {     // second loop ; Read person Records

        line =a[i1]
        token = line.split(" ");

        if (token[2] === "FAM" ) {                  // all person data read
            console.log ("start of FAMILY part , line : "+ i1 +": "+ line)
//            print("last pid "+person.pid)
            fillINDI((person.pid,person0))
            persons[person.pid] =person            // store last person


            // stop this loop
            break
        }
        else {
            switch ( token[2] ){
            case "INDI" :{                              // next person Record found
                xx = token[1].match(/\d+/g)[0]      // temp person.pid

//                print("next pid "+xx)
                fillINDI(xx,person0)

                persons[person.pid] = person


                person = creatorP.createObject(appWindow)                          // new person
                person.pid = xx                           // use temp stored id
                break
            }
            // ****************************************************************************************
            default : {
                switch(token[1]){
                case "GIVN" : {person.givenName = line.substr(line.indexOf("GIVN")+5) ; break }
                case "SURN" : {person.surName = line.substr(line.indexOf("SURN")+5) ; break }
                case "SEX"  : {person.gender = line.substr(line.indexOf("SEX")+4) ; break }
                case "OCCU" : {person.occupation = line.substr(line.indexOf("OCCU")+5) ; break }

                case "NOTE" : {person.note = line.substr(line.indexOf("NOTE")+5) ; break }
                case "CONT" : {person.note = person.note + "\n" + line.substr(line.indexOf("CONT")+5) ; break }
                case "CONC" : {person.note = person.note + line.substr(line.indexOf("CONC")+5) ; break }

                case "FAMC" : { person.childOfFamily =  parseInt(token[2].match(/\d+/g))  ; break }
                case "FAMS" : { person.parentInFamily.push(token[2].match(/\d+/g)) ; break } //TODO


                case "BIRT" : {dateFlag = "birth" ; break }
                case "DEAT" : {dateFlag = "death" ; break }
                case "CHR"  : {dateFlag = "christian" ; break }

                case "DATE" : {                         // todo : add suport for sorted date
                    tempDate = line.substr(line.indexOf("DATE")+5)
                    tempYear = tempDate.split(" ")
                    tempYear =tempYear[tempYear.length-1]
                    switch(dateFlag ){
                    case "birth" : {
                        person.birthDate = tempDate
                        person.birthYear = tempYear
                        break }
                    case "death" : {
                        person.deathDate = tempDate
                        person.deathYear = tempYear
                        break }
                    default : console.log("unkown dateFlag : "+dateFlag)
                    }
                    break
                }
                case "PLAC" : {
                    switch(dateFlag ){
                    case "birth" : { person.birthPlace = line.substr(line.indexOf("PLAC")+5) ; break }
                    case "death" : { person.deathPlace = line.substr(line.indexOf("PLAC")+5) ; break }
                    default : console.log("unkown dateFlag : "+dateFlag)
                    }
                    break
                }

                case "NAME" : break                             // the NAME record is not used
                default : console.log("unknown : "+line)
                }
                // ****************************************************************************************
                // todo
            }
            }
        }
    }
//    print("testing")
//    for (  i in persons){ print(i );persons[i].prt()   }             // debug output

    print("end of parseINDI")
    return persons
}
//##############################################################################
function parseFAM(a){                                   // Extract family data from GEDCOM array "a"
                                                        // todo use same coding style as in parseINDI

    print("start of parseFAM")

    var creatorF = Qt.createComponent("Family.qml")   // define factory for family
    var family0 = creatorF.createObject(appWindow)    // dummy first family
    var families = []                                  // array of all families
    var family = creatorF.createObject(appWindow)     // actual family

    var i = 0
    var dateFlag = "none"

    // ****************************************************************************************
    for (i = 0; i < a.length; i++) {                // first loop : ignore header and person
        // TODO : retrieve start position

        var line =a[i]
        var token = line.split(" ");

        if ( token[2] === "FAM"){                              // first FAM Record found
            console.log("start of FAM Part found in line "+i +": "+ line);

            family.pid = token[1].match(/\d+/g)[0]              // extract pid

            break                                           // stop this loop
        }
    }
    // ****************************************************************************************
    for ( var i1 = i+1 ; i< a.length; i1++)  {     // third loop ; Read FAM Records

        line =a[i1]
        token = line.split(" ");

        if (token[1] === "TRLR" ) {                   // end of FAM loop
            console.log ("Trailor part to be written, line : "+ i1)  //todo: store data for later use
            families[family.pid] = family            // store last family
            break
        }  // todo
        else {
            switch ( token[2] ){
            case "FAM" :{                              // next FAM Record found
                var xx = token[1].match(/\d+/g)[0]      // temp family.pid

                for (var j = families.length; j < xx; j++) { // fill array with dummy
                    families.push(family0)               // TODO : store empty position for later use
                }
                families[family.pid] = family           // store last family
                //families[family.pid].prt()              // debug output

                family = creatorF.createObject(appWindow)        // new family
                family.pid = xx
                break
            }

            // ****************************************************************************************
            default : {
                switch(token[1]){
                case "HUSB" : {family.husband = token[2].match(/\d+/g)[0] ; break }
                case "WIFE" : {family.wife = token[2].match(/\d+/g)[0] ; break }
                case "CHIL"  :{family.children.push(token[2].match(/\d+/g)[0]) ; break }
                case "MARR" : {dateFlag = "marriage" ; break }
                case "DIV" : {dateFlag = "divorce" ; break }

                case "NOTE" : {family.note = line.substr(line.indexOf("NOTE")+5) ; break }
                case "CONT" : {family.note = family.note + "\n" + line.substr(line.indexOf("CONT")+5) ; break }
                case "CONC" : {family.note = family.note + line.substr(line.indexOf("CONC")+5) ; break }

                case "DATE" : {                              // todo : add suport for sorted date
                    switch(dateFlag ){
                    case "marriage" : { family.marriageDate = line.substr(line.indexOf("DATE")+5) ; break }
                    case "divorce" : { family.divorceDate = line.substr(line.indexOf("DATE")+5) ; break }
                    default : console.log("unkown dateFlag : "+dateFlag)
                    }
                    break
                }
                case "PLAC" : {
                    switch(dateFlag ){
                    case "marriage" : { family.marriagePlace = line.substr(line.indexOf("PLAC")+5) ; break }
                    case "divorce" : { family.divorcePlace = line.substr(line.indexOf("PLAC")+5) ; break }
                    default : console.log("unkown dateFlag : "+dateFlag)
                    }
                    break
                }

                default :console.log("unkown : "+line)

                }
            }
            }
        }
    }

    return families
}

function writeGedcom(){

    var path = "file:///C:/Users/hans-/Documents/QML-Geneal/myGeneal-2/Data/testOutput.ged"
    var i = 0
    var text

    text = "0 HEAD\n"
    text = text +"1 SOUR myGeneal\n"
    text = text +"2 VERS 0.1\n"
    text = text +"0 @U1@ SUBM\n"
    text = text +"1 NAME Hans-Peter von Reth\n"
    text = text +"0 @SUBM@ SUBM\n"
    text = text +"1 NAME Hans-Peter von Reth\n"
    for (var i1 in persons){
        person = persons[i1]
        if (person.pid != 0){
            text = text +"0 @I" + person.pid + "@ INDI\n"
            text = text +"1 NAME " +person.givenName + "/" + person.surName + "/\n"
            text = text +"2 GIVN " + person.givenName + "\n"
            text = text +"2 SURN " + person.surName + "\n"
            text = text +"1 SEX " + person.gender + "\n"
            if (person.birthDate != " " ){
                text = text +"1 BIRT\n"
                text = text +"2 DATE " + person.birthDate + "\n"
                if (person.birthPlace != " " ){ text = text +"2 PLAC "+person.birthPlace + "\n"}
            }
            if ( person.christianDate != " " ){ text = text +"1 CHR\n"
                text = text +"2 DATE "+person.christianDate + "\n"
                if (person.christianPlace != " " ){ text = text +"2 PLAC "+person.christianPlace + "\n" }
            }
            if (person.deathDate != " " ){
                text = text +"1 DEAT\n"
                text = text +"2 DATE " + person.deathDate  +"\n"
                if ( person.deathPlace != " " ){ text = text +"2 PLAC " + person.deathPlace + "\n"}
            }
            for ( var i2 in person.parentInFamily){
                if (i2  != 0){ text = text +"1 FAMS @F" + person.parentInFamily[i2] + "@\n"}
            }
            if (person.childOfFamily != 0){
                text = text +"1 FAMC @F" + person.childOfFamily + "@\n"
            }
            if ( person.occupation != " " ){ text = text +"1 OCCU " + person.occupation + "\n"
            }
            if ( person.note != " " ) {
                var cmd = "1 NOTE "
                var x  = String(person.note)
                print( "note: " + x)
                var newline = ""
            //                # next records as CONT / CONC
                while (x.length >0){
                    var j = Math.min(70,x.length,x.indexOf("\n"))
                    newline = x.substr(0,j)
                    print("new : "+ newline)
                    x = x.substring(j)
                    print("x : "+x)
                }

            //                    i = min(70,len(x))
            //                    y=x[0:i]  #cmd y +"\n"      #TODO : add code to save format of notes
            //                    if "\n" in y :
            //                        i= y.index("\n")
            //                        y=x[0:i]
            //                        i=i+1
            //                    ged.write(cmd+y+"\n")
            //                    x = x[i:]
            //                    if i>= 70 :
            //                        cmd = "1 CONC "
            //                    else :
            //                        cmd = "1 CONT "
            }
        }
    }

    print(text)
}


//    for person in  self.persons:
//        if person.id != 0:
//            #print(person.id , person.givn, person.surn)
//

//    #########################
//    for fam in self.families:
//        if fam.id != 0:0 @F"+str(fam.id)+"@ FAM\n")
//            if fam.husb != 0:
//                text = text +"1 HUSB @I"+str(fam.husb)+"@\n")
//            if fam.wife != 0:
//                text = text +"1 WIFE @I"+str(fam.wife)+"@\n")
//            if fam.mdate != " " :
//                text = text +"1 MARR\n")
//                text = text +"2 DATE "+fam.mdate+"\n")
//                if fam.mplac != " " :
//                    text = text +"2 PLAC "+fam.mplac+"\n")
//            if fam.divdate != " " :
//                text = text +"1 DIV\n")
//                text = text +"2 DATE "+fam.divdate+"\n")
//                if fam.divplac != " " :
//                    text = text +"2 PLAC "+fam.divplac+"\n")  #TODO: add CHAN
//            if len(fam.chil) >0:
//                for x in fam.chil:
//                    if x != 0:
//                        text = text +"1 CHIL @I"+str(x)+"@\n")
//            if fam.note != " ":
//                # first record
//                cmd = "1 NOTE "
//                x =str(fam.note)
//                #print("x: ",x)
//                # next records as CONT / CONC
//                while (len(x) >0):
//                    i = min(70,len(x))
//                    y=x[0:i]  #cmd y +"\n"      #TODO : add code to save format of notes
//                    if "\n" in y :
//                        i= y.index("\n")
//                        y=x[0:i]
//                        i=i+1
//                    ged.write(cmd+y+"\n")
//                    x = x[i:]
//                    if i>= 70 :
//                        cmd = "1 CONC "
//                    else :
//                        cmd = "1 CONT "

//    ######################
//    ged.write('0 @S4@ SOUR\n')
//    ged.write('1 TITL LDS Microfilm, Rohrbronn\n')
//    ged.write('0 @S6@ SOUR\n')
//    ged.write('1 TITL Euregio\n')
//    ged.write('1 REPO @R1@\n')
//    ged.write('0 @S20@ SOUR\n')
//    ged.write('1 TITL (see notes)\n')
//    ged.write('0 @S37@ SOUR\n')
//    ged.write('1 TITL LDS Microfilm, Rohrbronn\n')
//    ged.write('0 @R1@ REPO\n')
//    ged.write('1 NAME Euregio Familienbuch\n')
//    ged.write('0 TRLR\n')
//    ged.close()

