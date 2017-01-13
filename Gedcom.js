// Gedcom
function readIni(fileid){                       //todo:  not yet tested
    console.log("readIni called" );

    var text = genealFile.readFile(fileid);          // read file and split into lines
    var a = text.split("\r\n");
    var i = 0
    // ****************************************************************************************
    for (i = 0; i < a.length; i++) {                // first loop : ignore header : todo

        var line =a[i]
        var token = line.split(" ");
        console.log(line)
        switch (token[0]){
            //case "Path"               :{ path = token[1]; break}
        case "Infile"             :{ infile = token[1]; break}
        case "Outfile"            :{ outfile = token[1]; break}
        // case "DebugOn"           :{ ........... break}

        case "Malecol"            : {malecol = token[1]; break}
        case "Femalecol"          : {femalecol = token[1]; break}
        case "Firstyear"          : {firstyear = token[1]; break}
        case "Lastyear"           : {lastyear = token[1]; break}
        case "Ageatbirth_male"    : {ageatbirth_male = token[1]; break}
        case "Ageatbirth_female"  : {ageatbirth_female = token[1]; break}
        case "Maxage_father"      : {maxage_father = token[1]; break}
        case "Maxage_mother"      : {maxage_mother = token[1]; break}
        case "Maxage"             : { maxage = token[1]; break}
        case "Maxdelta_childs"    : {maxdelta_childs = token[1]; break}
        case "Maxdelta_partners" : {maxdelta_partners = token[1]; break}
        case "Startid"            : {startid = token[1]; break}
        default                   : {console.log("invalid value : " + line)
        }
        }
    }
}
//*************************************************************************************
function parseGedcom(fileid) {                  // Extract Person and Family data from GEDCOM File


    var creatorP = Qt.createComponent("Person.qml")  // define factory for person
    var creatorF = Qt.createComponent("Family.qml")  // define factory for family

    var person0 = creatorP.createObject(appWindow)        // dummy first person
    var family0 = creatorF.createObject(appWindow)        // dummy first family

    var persons = []                                 // array of all persons
    var families = []                                // array of all families

    var person = creatorP.createObject(appWindow)
    var family= creatorF.createObject(appWindow)

    // console.log("parseGedcom2 called" );

    var text = genealFile.readFile(fileid);          // read file and split into lines
    var a = text.split("\r\n");

    var i = 0
    var dateFlag = "none"

    // ****************************************************************************************
    for (i = 0; i < a.length; i++) {                // first loop : ignore header
                                                    //todo : store data for  later use

        var line =a[i]
        var token = line.split(" ");

        if ( token[2] === "INDI"){                              // first INDI Record found
            //console.log("start of indiPart found in line "+i +": "+ line);

            person.pid = token[1].match(/\d+/g)[0]              // extract pid

            for (var j = persons.length; j < person.pid; j++) { // fill array with dummy
                persons.push(person0)                           // TODO : store empty position for later use
            }

            break                                           // stop this loop
        }
    }
    // ****************************************************************************************

    for ( var i1 = i+1 ; i1< a.length; i1++)  {     // second loop ; Read INDI Records

        line =a[i1]
        token = line.split(" ");

        if (token[2] === "FAM" ) {                  // all person data read
            console.log ("start of FAMILY part , line : "+ i1 +": "+ line)
            persons[person.pid] = person            // store last person
            persons[person.pid].prt()               // debug output

            family = creatorF.createObject(appWindow)
            family.pid = token[1].match(/\d+/g)[0]              // extract family id
            for (var j = families.length; j < family.pid; j++) {   // fill array with dummy families
                families.push(family0)                          //todo:  store empty position for later use
            }

                                                                    // stop this loop
            break
        }
        else {
            switch ( token[2] ){
            case "INDI" :{                              // next INDI Record found
                persons[person.pid] = person            // store last person
                var xx = token[1].match(/\d+/g)[0]      // temp person.pid
                for (j = persons.length; j < xx; j++) { // fill array with dummy
                    persons.push(person0)               //TODO : store empty position for later use
                }

                if ( person.pid <= persons.length) { persons[person.pid] = person }
                else {persons.push(person) }             // insert or push person in persons
                persons[person.pid].prt()                // debug output

                person = creatorP.createObject(appWindow)   //  // new person
                person.pid = xx
                break
            }
            // ****************************************************************************************
            default : {
                switch(token[1]){
                case "GIVN" : {person.gname = line.substr(line.indexOf("GIVN")+5) ; break }
                case "SURN" : {person.sname = line.substr(line.indexOf("SURN")+5) ; break }
                case "SEX"  : {person.gender = line.substr(line.indexOf("SEX")+4) ; break }
                case "OCCU" : {person.occu = line.substr(line.indexOf("OCCU")+5) ; break }

                case "NOTE" : {person.note = line.substr(line.indexOf("NOTE")+5) ; break }
                case "CONT" : {person.note = person.note + "\n" + line.substr(line.indexOf("CONT")+5) ; break }
                case "CONC" : {person.note = person.note + line.substr(line.indexOf("CONC")+5) ; break }

                case "FAMC" : { person.childOfFamily =  token[2].match(/\d+/g)[0]  ; break }
                case "FAMS" : { person.parentInFamily.push(token[2].match(/\d+/g)[0]) ; break }

                case "BIRT" : {dateFlag = "birth" ; break }
                case "DEAT" : {dateFlag = "death" ; break }
                case "CHR"  : {dateFlag = "christian" ; break }

                case "DATE" : {                         // todo : add suport for sorted date
                    switch(dateFlag ){
                    case "birth" : { person.birthdate = line.substr(line.indexOf("DATE")+5) ; break }
                    case "death" : { person.deathdate = line.substr(line.indexOf("DATE")+5) ; break }
                    default : console.log("unkown dateFlag : "+dateFlag)
                    }
                    break
                }
                case "PLAC" : {
                    switch(dateFlag ){
                    case "birth" : { person.birthplace = line.substr(line.indexOf("PLAC")+5) ; break }
                    case "death" : { person.deathplace = line.substr(line.indexOf("PLAC")+5) ; break }
                    default : console.log("unkown dateFlag : "+dateFlag)
                    }
                    break
                }

                case "NAME" : break                             // the NAME record is not used
                default : console.log("unkown : "+line)
                }
                // ****************************************************************************************
                // todo
            }
            }
        }
    }
    // ****************************************************************************************
    dateFlag = ""
    for ( var i2 = i1+1 ; i1< a.length; i1++)  {     // third loop ; Read FAM Records

        line =a[i1]
        token = line.split(" ");

        if (token[2] === "TRLR" ) {                   // end of FAM loop
            console.log ("Trailor part to be written, line : "+ i1)  //todo: store data for later use
            families[family.pid] = family            // store last family
            break
        }  // todo
        else {
            switch ( token[2] ){
            case "FAM" :{                              // next FAM Record found
                families[family.pid] = family           // store last family
                var xx = token[1].match(/\d+/g)[0]      // temp family.pid
                for (j = families.length; j < xx; j++) { // fill array with dummy
                    families.push(family0)               // TODO : store empty position for later use
                }

                if ( family.pid <= families.length) { families[family.pid] = family }
                else {families.push(family) }           // insert or push family in families
                families[family.pid].prt()              // debug output

                family = creatorF.createObject(appWindow)        // new family
                family.pid = xx
                break
            }
            // ****************************************************************************************


            // ****************************************************************************************
            default : {
                switch(token[1]){
                case "HUSB" : {family.husband = token[2].match(/\d+/g)[0] ; break }
                case "WIFE" : {family.wife = token[2].match(/\d+/g)[0] ; break }
                case "CHIL"  :{family.children.push(token[2].match(/\d+/g)[0]) ; break }
                case "MARR" : {dateFlag = "marriage" ; break }
                case "DIV" : {dateFlag = "divorce" ; break }

                case "DATE" : {                              // todo : add suport for sorted date
                    switch(dateFlag ){
                    case "marriage" : { family.marriagedate = line.substr(line.indexOf("DATE")+5) ; break }
                    case "divorce" : { family.divorcedate = line.substr(line.indexOf("DATE")+5) ; break }
                    default : console.log("unkown dateFlag : "+dateFlag)
                    }
                    break
                }
                case "PLAC" : {
                    switch(dateFlag ){
                    case "marriage" : { family.marriageplace = line.substr(line.indexOf("PLAC")+5) ; break }
                    case "divorce" : { family.divorceplace = line.substr(line.indexOf("PLAC")+5) ; break }
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


}


// forth  loop ; Read TRLR Records : TODO



