// EditPage : functions for Display and edit of Data
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
        x = String(p1.surName).substring(0,name.length).toLowerCase()

        if ( (gender === "" || gender === p1.gender) &&
                ( x === name) &&
                (from === "" || from < p1.birthYear) &&
                (to === "" || to > p1.birthYear)     ) {
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
    var parentFamily
    var p1
    var person = persons[actualId]
//### person related data
    labelPid.text = "Person Id : " +    person.pid

    rectangleGender.color=   ( person.gender === "M") ? "cyan" : "pink"

    textFieldGivenName.text= person.givenName
    textFieldSurName.text= person.surName
    textFieldBirthDate.text= person.birthDate
    textFieldBirthPlace.text= person.birthPlace
    textFieldDeathDate.text= person.deathDate
    textFieldDeathPlace.text= person.deathPlace
    textFieldOccupation.text= person.occupation

    textEditPnote.text= person.note

//### family related data
    parents.clear()
    partners.clear()
    childs.clear()

    if (person.childOfFamily !== 0){
 //       families[person.childOfFamily].prt()
        parentFamily = families[person.childOfFamily]
        p1 = persons[parentFamily.husband]
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
            textFieldMarryDate.text= partnerFamily.marriageDate
            textFieldMarryPlace.text= partnerFamily.marriagePlace
            textFieldDivorceDate.text= partnerFamily.divorceDate
            textFieldDivorcePlace.text= partnerFamily.divorcePlace

            if (person.gender === "F"){ p1 = persons[partnerFamily.husband]}
            else {                      p1 = persons[partnerFamily.wife]}
            partners.append({"pid": p1.pid,
                                "givenName": p1.givenName.concat(blank).substr(0,30),
                                "surName"  : p1.surName.concat(blank).substr(0,30),
                                "bYear" : p1.birthYear,
                                "dYear" :p1.deathYear})
        } //todo : support for multiple families

        for ( i=0 ; i< partnerFamily.children.length ; i++){
            xx = partnerFamily.children[i]
            p1 = persons[xx]
            childs.append({"pid": p1.pid,
                              "givenName": p1.givenName.concat(blank).substr(0,30),
                              "surName"  : p1.surName.concat(blank).substr(0,30),
                              "bYear" : p1.birthYear,
                              "dYear" :p1.deathYear})
        }
    }
}
