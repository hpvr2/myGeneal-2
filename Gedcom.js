// Gedcom : functions for reading and writing GEDCOM Files
//*************************************************************************************
function fillINDI(id,person0){
    //    print("completing from : "+persons.length +" to: "+id)
    for (var j = persons.length; j <= id; j++) { // fill array with dummy
        persons.push(person0)                           // TODO : store empty position for later use
        //        print("WRITING RECORD : "+j  )
    }
}//*************************************************************************************
function fillFAM(id,family0){
    //    print("completing from : "+persons.length +" to: "+id)
    for (var j = families.length; j <= id; j++) { // fill array with dummy
        families.push(family0)                           // TODO : store empty position for later use
        //        print("WRITING RECORD : "+j  )
    }
}

//#####################################################
function parseHEADER(a){                                // Extract HEADER data from GEDCOM array "a"
    var header = []                                  // array of header records
    // ****************************************************************************************
    for (var i = 0; i < a.length; i++) {                // first loop : store header
        var line =a[i]
        var token = line.split(" ");

        if ( token[2] === "INDI"){                              // first person Record found
            console.log("start of INDI Part found in line "+i +": "+ line);
            startIndi = i
            break                                           // stop this loop
        }
        else {header.push(line)
        }
    }
    return header
}
// ****************************************************
//#######################################################
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

    for ( var i1 = startIndi ; i1< a.length; i1++)  {     //  Read person Records

        var line =a[i1]
        var token = line.split(" ");

        if (token[2] === "FAM" ) {                  // all person data read
            console.log ("start of FAMILY part , line : "+ i1 +": "+ line)
            startFam = i1
            fillINDI((person.pid,person0))
            persons[person.pid] =person            // store last person
            // stop this loop
            break
        }
        else {
            switch ( token[2] ){
            case "INDI" :{                              // next person Record found
                var xx = token[1].match(/\d+/g)[0]      // temp person.pid
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
                    case "christian" : {
                        person.christianDate = tempDate
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
                    case "christian" : { person.christianPlace = line.substr(line.indexOf("PLAC")+5) ; break }
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
    print("end of parseINDI")
    return persons
}
//##############################################################################
function parseFAM(a){                                   // Extract family data from GEDCOM array "a"
    print("start of parseFAM")

    var creatorF = Qt.createComponent("Family.qml")   // define factory for family
    var family0 = creatorF.createObject(appWindow)    // dummy first family
    var families = []                                  // array of all families
    families.push(family0)
    var family = creatorF.createObject(appWindow)     // actual family

    var i = 0
    var dateFlag = "none"

    // ****************************************************************************************
    for ( var i1 = startFam ; i< a.length; i1++)  {     // third loop ; Read FAM Records

        var line =a[i1]
        var token = line.split(" ");

        if ( token[2] === "FAM"){   // next FAM Record found
            var xx = token[1].match(/\d+/g)[0]      // temp family.pid
            fillFAM(xx,family0)
            families[family.pid] = family           // store last family
            family = creatorF.createObject(appWindow)        // new family
            family.pid = xx

        }
        else{
            // ****************************************************************************************
            switch(token[1]){
            case "HUSB" : {
                family.husband = token[2].match(/\d+/g)[0] ; break }
            case "WIFE" : {
                family.wife = token[2].match(/\d+/g)[0] ; break }
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
            case "SOUR" :
            case "TRLR" : {
                startTrailer = i1
                console.log ("Trailor part to be written, line : "+ i1)  //todo: store data for later use
                fillFAM(family.pid,family0)
                families[family.pid] = family            // store last family
                return families
            }

            default :console.log("unkown : "+line)
            }
        }
    }



    return families
}

//##########################################################
function writeNote(note){
    var cmd = "1 NOTE "

    var j=0
    var text = ""
    while (note.length> 0){
        j = note.indexOf("\n")          // is there a nl ?
        if (j==0) {                     // special case : line starts with nl, ignore
            note = note.substr(1)
            continue
        }
        if ( j== -1 || j> 70){                  // no or too long , split at position 70
            j = Math.min(70,note.length)
            text = text + cmd + note.substr(0,j) +"\n"
            note = note.substr(j)
            cmd = "1 CONC "
        }
        else {                     // nl found
            text = text + cmd + note.substr(0,j)  +"\n"
            note = note.substr(j+1)
            cmd = "1 CONT "
        }


    }
    return text
}
//#######################################
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
    //    ######################
    for (var i1 in persons){
        person = persons[i1]
        //     person.prt()
        if (person.pid != 0){
            text = text +"0 @I" + person.pid + "@ INDI\n"
            text = text +"1 NAME " +person.givenName + "/" + person.surName + "/\n"
            text = text +"2 GIVN " + person.givenName + "\n"
            text = text +"2 SURN " + person.surName + "\n"
            text = text +"1 SEX " + person.gender + "\n"
            if (person.birthDate != "" ){
                text = text +"1 BIRT\n"
                text = text +"2 DATE " + person.birthDate + "\n"
                if (person.birthPlace != "" ){ text = text +"2 PLAC "+person.birthPlace + "\n"}
            }
            if ( person.christianDate != "" ){ text = text +"1 CHR\n"
                text = text +"2 DATE "+person.christianDate + "\n"
                if (person.christianPlace != "" ){ text = text +"2 PLAC "+person.christianPlace + "\n" }
            }
            if (person.deathDate != "" ){
                text = text +"1 DEAT\n"
                text = text +"2 DATE " + person.deathDate  +"\n"
                if ( person.deathPlace != "" ){ text = text +"2 PLAC " + person.deathPlace + "\n"}
            }
            for ( var i2 in person.parentInFamily){
                if (i2  !== 0){ text = text +"1 FAMS @F" + person.parentInFamily[i2] + "@\n"}
            }
            if (person.childOfFamily != 0){
                text = text +"1 FAMC @F" + person.childOfFamily + "@\n"
            }
            if ( person.occupation != "" ){ text = text +"1 OCCU " + person.occupation + "\n"
            }
            if ( person.note !== "" ){  text = text + writeNote(String(person.note).trim()) }
        }
        //    ######################

    }
    //    ######################
    for ( i1 in families){
        var family = families[i1]
        if ( family.pid     !== 0){ text = text + "0 @F" + family.pid + "@ FAM\n"     }
        if (family.husband !== 0 ){ text = text + "1 HUSB @I" + family.husband + "@\n" }
        if (family.wife    !== 0 ){ text = text + "1 WIFE @I" + family.wife    + "@\n" }
        if (family.marriageDate !== "" ){
            text = text + "1 MARR\n"
            if (family.marriageDate  !== "" ){ text = text + "2 DATE " + family.marriageDate  + "\n" }
            if (family.marriagePlace !== "" ){ text = text + "2 PLAC " + family.marriagePlace  + "\n" }
        }
        if (family.divorceDate !== "" ){
            text = text + "1 DIV\n"
            if (family.divorceDate  !== "" ){ text = text + "2 DATE " + family.divorceDate  + "\n" }
            if (family.divorcePlace !== "" ){ text = text + "2 PLAC " + family.divorcePlace  + "\n" }
        }
        for (  i2 in family.children){
            if (i2  !== 0){ text = text +"1 CHIL @I" + family.children[i2] + "@\n"}
        }
        if ( family.note !== "" ){  text = text + writeNote(String(family.note).trim()) }
    }
    //    ######################
    text = text + '0 @S4@ SOUR\n'
    text = text + '1 TITL LDS Microfilm, Rohrbronn\n'
    text = text + '0 @S6@ SOUR\n'
    text = text + '1 TITL Euregio\n'
    text = text + '1 REPO @R1@\n'
    text = text + '0 @S20@ SOUR\n'
    text = text + '1 TITL (see notes)\n'
    text = text + '0 @S37@ SOUR\n'
    text = text + '1 TITL LDS Microfilm, Rohrbronn\n'
    text = text + '0 @R1@ REPO\n'
    text = text + '1 NAME Euregio Familienbuch\n'
    text = text + '0 TRLR\n'
    // print(text)
    var fileid = "file:///C:/Users/hans-/Documents/QML-Geneal/myGeneal-2/Data/all-test.ged"
    // print(fileid)
    console.log(genealFile.fileExists(fileid))

    var x = genealFile.writeFile(fileid,text)

}
//######################################
