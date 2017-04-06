// EditPage : functions for Display and edit of Data


function select(gender,name,from , to){      // selection list ( filtered ) for persons

    print("Selection called : "+ gender +" "+ name + " "+ from+" "+ to   )

    name = name.toLowerCase()
    if ( from === "    ") from = 0
    var p1
    var x = ""
    var blank = "                                        "
    var count = 0
    selectOther.clear()
    for ( var i in persons) {
        p1 = persons[i]

        x = String(p1.surName).substring(0,name.length).toLowerCase()

        if ( (gender === "" || gender === p1.gender) &&  // gender not specified or matching
                ( x === name) &&                         // surname starting with name ( in lowercase )
                (from < p1.birthYear) &&                 // from earlier than birthyear
                (to === "" || to > p1.birthYear)     ) { // to later than birthyear
            count++
            print(p1.pid+" " +p1.givenName+ " " +p1.surName)
            selectOther.append({ "pid": p1.pid,
                                 "givenName": p1.givenName,
                                 "surName"  : p1.surName,
                                 "bYear" : p1.birthYear,
                                 "dYear" :p1.deathYear})

            //print(selection.get(1))
        }
    }
    print(count)
    return
}
// #########################################################
function splitPNote(note){
    var nl = "\n"
    while (note.length >  0 ) {
        var x = note.indexOf(nl)
        if ( x === -1 ) x = note.length
        if ( x < 80 ) { // use variable line length
            textEditPnote.append(note.substr(0,x))
            note = note.substr(x+1)
        }
        else {
            x = note.substr(0,80).lastIndexOf(" ")
            textEditPnote.append(note.substr(0,x))
            note = note.substr(x+1)
        }
    }
}
function splitFNote(note){
    var nl = "\n"
    while (note.length >  0 ) {
        var x = note.indexOf(nl)
        if ( x === -1 ) x = note.length
        if ( x < 80 ) { // use variable line length
            textEditFnote.append(note.substr(0,x))
            note = note.substr(x+1)
        }
        else {
            x = note.substr(0,80).lastIndexOf(" ")
            textEditFnote.append(note.substr(0,x))
            note = note.substr(x+1)
        }
    }
}
function setRelatives(actualId){             // set person and family data in screen

    var blank = "                               "
    var parentFamily
    var partnerFamily
    var p1
    var person = persons[actualId]
    print(actualId)
    //### display person related data
    labelPid.text = "Person Id : " +    person.pid

    textFieldGivenName.text = person.givenName
    textFieldGivenName.font.bold = true
    textFieldGivenName.textColor =  ( person.gender === "M") ? "blue" : "red"

    textFieldSurName.text   = person.surName
    textFieldSurName.font.bold = true
    textFieldSurName.textColor =  ( person.gender === "M") ? "blue" : "red"

    textFieldBirthDate.text = person.birthDate
    textFieldBirthPlace.text= person.birthPlace

    textFieldDeathDate.text = person.deathDate
    textFieldDeathPlace.text= person.deathPlace

    textFieldOccupation.text= person.occupation

    textEditPnote.clear()
    splitPNote(person.note)

    //### display parent related data
    parents.clear()
    //    person.prt()
    if (person.childOfFamily !== 0){
        parentFamily = families[familyIndex.indexOf(person.childOfFamily)]
        //        parentFamily.prt()
        p1 = persons[personIndex.indexOf(parentFamily.husband)]
        parents.append({ "pid": p1.pid,
                           "givenName": p1.givenName,
                           "surName"  : p1.surName,
                           "bYear" : p1.birthYear,
                           "dYear" :p1.deathYear} )
        p1 = persons[personIndex.indexOf(parentFamily.wife)]
        parents.append({"pid": p1.pid,
                           "givenName": p1.givenName,
                           "surName"  : p1.surName,
                           "bYear" : p1.birthYear,
                           "dYear" :p1.deathYear})
    }
    //### display family related data
    partners.clear()
    childs.clear()
    textFieldMarryDate.text    = ""
    textFieldMarryPlace.text   = ""
    textFieldDivorceDate.text  = ""
    textFieldDivorcePlace.text = ""

    if ( actualFam >= person.parentInFamily.length) actualFam = 0

    for (var i=0 ; i< person.parentInFamily.length ; i++){
        var xx = parseInt(person.parentInFamily[i])
        if ( isNaN(xx)) break                                       // TODO : check why, only occurs in readCSV



        if (xx !== 0 && xx  !== ""){

            partnerFamily              = families[familyIndex.indexOf(xx)]

            if (person.gender === "F"){ p1 = persons[personIndex.indexOf(partnerFamily.husband)]}
            else {                      p1 = persons[personIndex.indexOf(partnerFamily.wife   )]}

            partners.append({"pid"      : p1.pid,
                                "givenName": p1.givenName,
                                "surName"  : p1.surName ,
                                "bYear"    : p1.birthYear,
                                "dYear"    : p1.deathYear})

            if ( actualFam === i) {
                print("actual "+ actualFam+ " " + i+ " "+ partnerFamily.children.length)
                textFieldMarryDate.text    = partnerFamily.marriageDate
                textFieldMarryPlace.text   = partnerFamily.marriagePlace
                textFieldDivorceDate.text  = partnerFamily.divorceDate
                textFieldDivorcePlace.text = partnerFamily.divorcePlace

                for ( var j=0 ; j< partnerFamily.children.length ; j++){
                    p1 = persons[personIndex.indexOf(parseInt(partnerFamily.children[j]))]
                    childs.append({   "pid"       : p1.pid,
                                      "givenName" : p1.givenName,
                                      "surName"   : p1.surName,
                                      "bYear"     : p1.birthYear,
                                      "dYear"     : p1.deathYear})
                }
            }
        }                                                //todo : support for multiple families

           splitPNote("\nFamily Note :\n"+partnerFamily.note)
//        textEditFnote.clear()
//        splitFNote(partnerFamily.note)
    }
}
function saveScreen(){
    print(actualId)
    print(personIndex[actualId])
    actualId = personIndex[actualId]
    var person= persons[actualId]
    person.prt()
    person.givenName  = textFieldGivenName.text
    person.surName    = textFieldSurName.text
    person.birthDate  = textFieldBirthDate.text
    person.birthPlace = textFieldBirthPlace.text
    person.deathDate  = textFieldDeathDate.text
    person.deathPlace = textFieldDeathPlace.text
    person.occupation = textFieldOccupation.text
    person.note       = textEditPnote.text

    persons[actualId]   = person

}
function addPerson (){
    var creatorP = Qt.createComponent("Person.qml")   // define factory for person
    var person = creatorP.createObject(appWindow)

    if (unusedPersons.length === 0 ){
        person.pid = persons.length

    }
    else {
        person.pid = unusedPersons[0]
        unusedPersons.splice(0,1)
    }
    personIndex.push(person.pid)
    print(personIndex[personIndex.length-1])
    print(personIndex.length)
    person.surName = "-new person-"
    persons[person.pid]= person
    person.prt()

    actualId = personIndex.length-1
    print(actualId)
    for ( var i = 1670 ; i< personIndex.length; i++) print(i + " " +personIndex[i])
    setRelatives(person.pid)
}


