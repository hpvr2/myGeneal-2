// EditPage : functions for Display and edit of Data
function select(gender,name,from , to){      // selection list ( filtered ) for persons

    print("Selection called : "+ gender +" "+ name + " "+ from+" "+ to   )

    name = name.toLowerCase()
    if ( from === "    ") from = 0
    var p1
    var x = ""
    var blank = "                                        "

    selection.clear()
    for ( var i in persons) {
        p1 = persons[i]
        x = String(p1.surName).substring(0,name.length).toLowerCase()

        if ( (gender === "" || gender === p1.gender) &&  // gender not specified or matching
                ( x === name) &&                         // surname starting with name ( in lowercase )
                (from < p1.birthYear) &&                 // from earlier than birthyear
                (to === "" || to > p1.birthYear)     ) { // to later than birthyear
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
function setRelatives(actualId){             // set person and family data in screen

    var blank = "                               "
    var parentFamily
    var p1
    var person = persons[actualId]
     person.prt()

//### display person related data
    labelPid.text = "Person Id : " +    person.pid

    rectangleGender.color=   ( person.gender === "M") ? "cyan" : "pink"

    textFieldGivenName.text = person.givenName
    textFieldSurName.text   = person.surName
    textFieldBirthDate.text = person.birthDate
    textFieldBirthPlace.text= person.birthPlace
    textFieldDeathDate.text = person.deathDate
    textFieldDeathPlace.text= person.deathPlace
    textFieldOccupation.text= person.occupation

    textEditPnote.text      = person.note

//### display parent related data
    parents.clear()
    person.prt()
    if (person.childOfFamily !== 0){
        parentFamily = families[familyIndex.indexOf(person.childOfFamily)]
        parentFamily.prt()
        p1 = persons[personIndex.indexOf(parentFamily.husband)]
        parents.append({ "pid": p1.pid,
                           "givenName": p1.givenName.concat(blank).substr(0,30),
                           "surName"  : p1.surName.concat(blank).substr(0,30),
                           "bYear" : p1.birthYear,
                           "dYear" :p1.deathYear} )
        p1 = persons[personIndex.indexOf(parentFamily.wife)]
        parents.append({"pid": p1.pid,
                           "givenName": p1.givenName.concat(blank).substr(0,30),
                           "surName"  : p1.surName.concat(blank).substr(0,30),
                           "bYear" : p1.birthYear,
                           "dYear" :p1.deathYear})
    }
//### display family related data
    partners.clear()
    childs.clear()

    for (var i=0 ; i< person.parentInFamily.length ; i++){
        var xx = parseInt(person.parentInFamily[i])
        if (xx !== 0){
            partnerFamily              = families[familyIndex.indexOf(xx)]
            textFieldMarryDate.text    = partnerFamily.marriageDate
            textFieldMarryPlace.text   = partnerFamily.marriagePlace
            textFieldDivorceDate.text  = partnerFamily.divorceDate
            textFieldDivorcePlace.text = partnerFamily.divorcePlace

            if (person.gender === "F"){ p1 = persons[personIndex.indexOf(partnerFamily.husband)]}
            else {                      p1 = persons[personIndex.indexOf(partnerFamily.wife   )]}
            partners.append({"pid"      : p1.pid,
                             "givenName": p1.givenName.concat(blank).substr(0,30),
                             "surName"  : p1.surName.concat(blank).substr(0,30),
                             "bYear"    : p1.birthYear,
                             "dYear"    : p1.deathYear})
        }                                                //todo : support for multiple families

        for ( i=0 ; i< partnerFamily.children.length ; i++){
            p1 = persons[personIndex.indexOf(parseInt(partnerFamily.children[i]))]
            childs.append({   "pid"       : p1.pid,
                              "givenName" : p1.givenName.concat(blank).substr(0,30),
                              "surName"   : p1.surName.concat(blank).substr(0,30),
                              "bYear"     : p1.birthYear,
                              "dYear"     : p1.deathYear})
        }
    }
}
function saveScreen(){
    var person= persons[actualId]
    person.givenName = textFieldGivenName.text
    person.surName    = textFieldSurName.text
    person.birthDate  = textFieldBirthDate.text
    person.birthPlace = textFieldBirthPlace.text
    person.deathDate  = textFieldDeathDate.text
    person.deathPlace = textFieldDeathPlace.text
    person.occupation = textFieldOccupation.text
    person.note       = textEditPnote.text

    persons[actualId]   = person

}
