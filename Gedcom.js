// Gedcom : functions for reading and writing GEDCOM Files
//*************************************************************************************
function parseHEADER(a){           // Extract HEADER data from GEDCOM array "a"

    textEditHeader.clear()
    var text = ""
    for (var i = 0; i < a.length; i++) {                // first loop : store header
        var line =a[i].trim()
        var token = line.split(" ");

        if ( token[2] === "INDI"){                              // first person Record found
            //            console.log("start of INDI Part found in line "+i +": "+ line);
            startIndi = i
            break                                           // stop this loop
        }
        else {header.push("\n" + line )
            textEditHeader.append(line)
            text = text + line + "\n"
        }
    }

    var fileid = standard.path + "/header-data.ged"
    console.log(genealFile.fileExists(fileid))

    var x = genealFile.writeFile(fileid,text)
    return
}
function parseTRAILER(a){          // Extract Trailer data from GEDCOM array "a"

    textEditTrailer.clear()
    var text = ""
    for (var i = startTrailer; i < a.length; i++) {                // first loop : store trailer
        var line =a[i].trim()
        var token = line.split(" ");

        trailer.push("\n" + line )
        textEditTrailer.append(line)
        text = text + line + "\n"

    }

    var fileid = standard.path + "/trailer-data.ged"
    console.log(genealFile.fileExists(fileid))

    var x = genealFile.writeFile(fileid,text)
    return
}
function parseINDI(a){             // Extract Person data from GEDCOM array "a"
    var creatorP = Qt.createComponent("Person.qml")   // define factory for person
    var creatorF = Qt.createComponent("Family.qml")   // define factory for family

    var person = creatorP.createObject(appWindow)     // actual person
    var person0 = creatorP.createObject(appWindow)     // empty person
    person0.pid= "0"
    persons[0]=person0

    var nl = "\n"
    var dateFlag = "none"
    var tempDate = ""
    var line
    var token = []


    for ( var i1 = startIndi ; i1< a.length; i1++)  {     //  Read person Records

        line =a[i1].trim()
        token = line.split(" ");

        if (token[2] === "FAM" ) {                  // all person data read
            //            console.log ("start of FAMILY part , line : "+ i1 +": "+ line)
            startFam = i1
            // cleanup person note : splitNote(person.note)

            persons[person.pid] = person       // store last person
            if ( parseInt(person.pid) > maxid ) maxid = parseInt(person.pid)

            break
        }
        else {
            switch ( token[2] ){
            case "INDI" :{                              // next person Record found
                var xx = token[1].match(/\d+/g)[0]      // temp person.pid
                persons[person.pid] = person                    // store last person
                person = creatorP.createObject(appWindow) // new person
                person.pid = xx                           // use temp stored id
                if ( parseInt(xx) > maxid ) maxid = parseInt(xx)

                break
            }
            // ****************************************************************************************
            default : {
                switch(token[1]){
                case "GIVN" : person.givenName  = line.substr(line.indexOf("GIVN")+5) ; break
                case "SURN" : person.surName    = line.substr(line.indexOf("SURN")+5) ; break
                case "SEX"  : person.gender     = line.substr(line.indexOf("SEX")+4)  ; break
                case "OCCU" : person.occupation = line.substr(line.indexOf("OCCU")+5) ; break
                case "NOTE" : person.note       = line.substr(line.indexOf("NOTE")+5) ; break
                case "CONC" : person.note  = person.note + line.substr(line.indexOf("CONC")+5); break
                case "CONT" :
                    if (line.substr(line.indexOf("CONT")+5).length > 0){
                        person.note = person.note + nl+ line.substr(line.indexOf("CONT")+5) }
                    break

                case "FAMC" :
                    var id =token[2].match(/\d+/g)[0]
                    person.childOfFamily =  id
                    break
                case "FAMS" :
                    id =token[2].match(/\d+/g)[0]
                    person.parentInFamily.push(id)
                    break  //TODO

                case "BIRT" : dateFlag = "birth"     ; break
                case "DEAT" : dateFlag = "death"     ; break
                case "CHR"  : dateFlag = "christian" ; break

                case "DATE" :                          // todo : add suport for sorted date
                    tempDate = line.substr(line.indexOf("DATE")+5)
                    switch(dateFlag ){
                    case "birth"     : person.birthDate     = tempDate ; break
                    case "christian" : person.christianDate = tempDate ; break
                    case "death"     : person.deathDate     = tempDate ; break
                    default : console.log("unkown dateFlag : "+dateFlag)
                    }
                    break

                case "PLAC" :
                    var xplace = line.substr(line.indexOf("PLAC")+5)
                    switch(dateFlag ){
                    case "birth"     : person.birthPlace     = xplace ; break
                    case "christian" : person.christianPlace = xplace ; break
                    case "death"     : person.deathPlace     = xplace ; break
                    default :
                        console.log("unkown dateFlag : "+dateFlag)
                    }
                    break


                case "NAME" :
                    break                             // the NAME record is not used
                default :
                    console.log("unknown : "+line)
                }
            }
            }
        }

    }
    for ( var i=0; i<maxid; i++){if (!( i in persons )) unusedPersons.push(i) }
}
function parseFAM(a){              // Extract family data from GEDCOM array "a"

    var creatorF = Qt.createComponent("Family.qml")   // define factory for family
    var family = creatorF.createObject(appWindow)     // actual family
    var family0 = creatorF.createObject(appWindow)     // actual family

    var dateFlag = "none"
    var nl ="\n"

    // ****************************************************************************************
    for ( var i1 = startFam ; i1< a.length; i1++)  {     // third loop ; Read FAM Records

        var line =a[i1].trim()
        var token = line.split(" ");

        if ( token[1] === "TRLR" || token[2] === "SOUR" ){   //end of FAM part
            families[family.pid] =family            // store last family
            if ( parseInt(family.pid) > maxidFam ) maxidFam = parseInt(family.pid)

            startTrailer = i1

            break
        }
        else{
            switch(token[2]){
            case "FAM" :                              // next family Record found
                var xx = token[1].match(/\d+/g)[0]      // temp family.pid
                families[family.pid] =family            // store last family
                family = creatorF.createObject(appWindow) // new person
                family.pid = xx                           // use temp stored id
                if ( parseInt(xx) > maxidFam ) maxidFam = parseInt(xx)

                break

            default :

                switch(token[1]){
                case "HUSB" : family.husband      = token[2].match(/\d+/g)[0] ; break
                case "WIFE" : family.wife         = token[2].match(/\d+/g)[0] ; break
                case "CHIL" : family.children.push(token[2].match(/\d+/g)[0]) ; break
                case "MARR" : dateFlag = "marriage" ;   break
                case "DIV"  : dateFlag = "divorce"  ;   break

                case "NOTE" : family.note = line.substr(line.indexOf(token[1])+5); break
                case "CONC" : family.note = family.note + line.substr(line.indexOf(token[1])+5); break
                case "CONT" :
                    if (line.substr(line.indexOf("CONT")+5).length > 0){
                        family.note = family.note + nl+ line.substr(line.indexOf("CONT")+5)}
                    break
                case "DATE" :                              // todo : add suport for sorted date
                    var xdate = line.substr(line.indexOf("DATE")+5)
                    switch(dateFlag ){
                    case "marriage" : family.marriageDate = xdate ; break
                    case "divorce"  : family.divorceDate  = xdate ; break
                    default :
                        console.log("unkown dateFlag : "+dateFlag)
                    }
                    break
                case "PLAC" :
                    var xplace = line.substr(line.indexOf("PLAC")+5)
                    switch(dateFlag ){
                    case "marriage" : family.marriagePlace = xplace ; break
                    case "divorce"  : family.divorcePlace  = xplace ; break
                    default :
                        console.log("unkown dateFlag : "+dateFlag)
                    }
                    break
                default :
                    console.log("unkown : "+line)
                }
            }
        }
    }
    for ( var i=0; i<maxidFam; i++){ if ( !( i in families ))  unusedFamilies.push(i) }

}
function writeNote(note){          // write a note in gedcom format
    var cmd = "1 NOTE "

    var j=0
    var text = ""
    var nl = "\n"
    while (note.length> 0){
        j = note.indexOf(nl)          // is there a nl ?
        if (j==0) {                     // special case : line starts with nl, ignore
            note = note.substr(1)
            continue
        }
        if ( j== -1 || j> 70){                  // no or too long , split at position 70
            j = Math.min(70,note.length)
            text = text + cmd + note.substr(0,j) +nl
            note = note.substr(j)
            cmd = "1 CONC "
        }
        else {                     // nl found
            text = text + cmd + note.substr(0,j)  +nl
            note = note.substr(j+1)
            cmd = "1 CONT "
        }
    }
    return text
}
function writeGedcom(){            // write GEDCOM file
    var i = 0
    var text
    var nl = "\n"

    text = textEditHeader.text
    //    ######################
    for (var i1 in persons){                                    // write INDI part

        person = persons[i1]
        //        person.prt()
        if ( i1 >0){
            text = text +"0 @I" + person.pid + "@ INDI" + nl
            text = text +"1 NAME " +person.givenName + "/" + person.surName + "/" + nl
            text = text +"2 GIVN " + person.givenName + nl
            text = text +"2 SURN " + person.surName + nl
            text = text +"1 SEX " + person.gender + nl
            if (person.birthDate != "" ){
                text = text +"1 BIRT" + nl
                text = text +"2 DATE " + person.birthDate + nl
                if (person.birthPlace != "" ){ text = text +"2 PLAC "+person.birthPlace + nl}
            }
            if ( person.christianDate != "" ){ text = text +"1 CHR" + nl
                text = text +"2 DATE "+person.christianDate + nl
                if (person.christianPlace != "" ){ text = text +"2 PLAC "+person.christianPlace + nl }
            }
            if (person.deathDate != "" ){
                text = text +"1 DEAT" + nl
                text = text +"2 DATE " + person.deathDate  +nl
                if ( person.deathPlace != "" ){ text = text +"2 PLAC " + person.deathPlace + nl}
            }
            for (var ii= 0; ii<person.parentInFamily.length;ii++){
                text = text +"1 FAMS @F" + person.parentInFamily[ii] + "@" + nl}

            if (person.childOfFamily !== ""){
                text = text +"1 FAMC @F" + person.childOfFamily + "@" + nl
            }
            if ( person.occupation != "" ){ text = text +"1 OCCU " + person.occupation + nl
            }
            if ( person.note !== "" ){  text = text + writeNote(String(person.note).trim()) }
        }
        //    ######################

    }
    //    ######################
    for ( i1 in families){                                      // write FAM part
        if ( i1 > 0 ){
            var family = families[i1]
            text = text + "0 @F" + family.pid + "@ FAM" + nl
            if (family.husband !== "" ){ text = text + "1 HUSB @I" + family.husband + "@" + nl }
            if (family.wife    !== ""){ text = text + "1 WIFE @I" + family.wife    + "@" + nl }
            if (family.marriageDate !== "" ){
                text = text + "1 MARR" + nl
                if (family.marriageDate  !== "" ){ text = text + "2 DATE " + family.marriageDate  + nl }
                if (family.marriagePlace !== "" ){ text = text + "2 PLAC " + family.marriagePlace  + nl }
            }
            if (family.divorceDate !== "" ){
                text = text + "1 DIV" + nl
                if (family.divorceDate  !== "" ){ text = text + "2 DATE " + family.divorceDate  + nl }
                if (family.divorcePlace !== "" ){ text = text + "2 PLAC " + family.divorcePlace  + nl }
            }
            for ( ii=0; ii<family.children.length;ii++){
                text = text +"1 CHIL @I" + family.children[ii] + "@" + nl
            }
            if ( family.note !== "" ){  text = text + writeNote(String(family.note).trim()) }
        }


    }
    //    ######################
    text = text + textEditTrailer.text
    var fileid = standard.path + "/output.ged"
    console.log(genealFile.fileExists(fileid))

    var x = genealFile.writeFile(fileid,text)

}
