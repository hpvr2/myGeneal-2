// EditPage : functions for Display and edit of Data

function isEmpty(obj) {  for (var o in obj) if (o) return false;  return true;}

function select(selCase,gender,name,from,to){  // selection list ( filtered ) for persons
    print("Selection called : "+ selCase +" * "+  gender +"* *"+ name + "* *"+ from+"* *"+ to   )


    name = name.toLowerCase()

    var p1
    var x = ""
    var blank = "                                        "

    selectOther.clear()

    textFieldSelectType.text = String(selCase)
    selectCase =  String(selCase)
    selectGender = gender
    selectName = name
    selectFrom = from
    selectTo = to

    for ( var i in personsSort)    {
        p1 = personsSort[i]

        x = String(p1.sn).substring(0,name.length).toLowerCase()

        if ( (gender === "" || gender === p1.gender) &&  // gender not specified or matching
                ( x === name) &&                         // surname starting with name ( in lowercase )
                (from <p1.yb ) &&                 // from earlier than birthyear
                (to === "" || to > p1.yb)     )   // to later than birthyear
        {
            selectOther.append({ "pid": p1.pid, "givenName": p1.gn, "surName"  : p1.sn,
                                   "bYear" : p1.yb, "dYear" : p1.yd})
        }
    }
    selectInit = true
    textFieldSelectFrom.text = String(from)
    textFieldSelectTo.text = String(to)
    textFieldSelectName.text = name


    switch(selectGender){
    case "F" : radioButtonFemale.checked=true
        break
    case "M" : radioButtonMale.checked=true
        break
    case "" :  radioButtonUnknown.checked=true
    }

    selectInit = false
    return
}
function splitPNote(note){               // split person note on screen
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
function splitFNote(note){               // split family note on screen
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
function setRelatives(id){         // set person and family data in screen
    var person = {}
    person.parentInFamily = {}
    person = persons[String(id)]
    person.prt("start setRelatives")
    showPersonData(person)
    showParentData(person)
//    if (isEmpty(person.parentInFamily)) print("empty") ;     else print("not empty")
    showPartnerData(person)
}
function showPersonData(person){             // part 1 of set Relatives
    //### display person related data ****  part 1 *************************************************
    person.prt("show Person")
//    for ( var i in person.parentInFamily){print("*"+person.parentInFamily[i].pid+"*")}
 //   if (isEmpty(person.parentInFamily)) print("empty") ;     else print("not empty")

    labelPid.text = "Id : " +    person.pid

    textFieldGivenName.text = person.givenName
    textFieldGivenName.font.bold = true
    textFieldGivenName.textColor =  ( person.gender === "M") ? standard.maleColor : standard.femaleColor

    textFieldSurName.text   = person.surName
    textFieldSurName.font.bold = true
    textFieldSurName.textColor =  ( person.gender === "M") ? standard.maleColor : standard.femaleColor

    textFieldBirthDate.text = person.birthDate
    textFieldBirthPlace.text= person.birthPlace

    textFieldDeathDate.text = person.deathDate + " ( " + person.age()+ " ) "
    textFieldDeathPlace.text= person.deathPlace

    textFieldOccupation.text= person.occupation

    textEditPnote.clear()
    splitPNote(person.note)

}
function showParentData(person){             // part 2 of set Relatives
    //### display parent related data
    parents.clear()
    var p1,yb,yd
    person.prt("show Parents")
    var parentFam =families[person.childOfFamily.pid]
    if (parentFam.pid !== 0){
        p1 = parentFam.husband
        yb = String(p1.yearOf(p1.birthDate))
        yd = String(p1.yearOf(p1.deathDate))
        if ( p1.pid === 0 ) {
            parents.append({   "pid"       : -1, "givenName" : "select / add father", "surName"   : "",
                               "bYear"     : "", "dYear"     : ""})
        }
        else {
            parents.append({ "pid": p1.pid, "givenName": p1.givenName, "surName"  : p1.surName,
                               "bYear" : yb, "dYear" :yd} )
        }
        if ( p1.pid === 0 ) {
            parents.append({   "pid"       : -2, "givenName" : "select / add mother", "surName"   : "",
                               "bYear"     : "", "dYear"     : ""})
        }
        else {
            p1 = parentFam.wife
            yb = String(p1.yearOf(p1.birthDate))
            yd = String(p1.yearOf(p1.deathDate))
            parents.append({"pid": p1.pid,  "givenName": p1.givenName, "surName"  : p1.surName,
                               "bYear" :yb, "dYear" :yd})
        }
    }
}
function showPartnerData(person){             // part 3 of set Relatives
    //### display family related data ******  part 3   *****************************************************************
    var p1,yb,yd
    person.prt("show Partner")

    partners.clear()
    childs.clear()
    textFieldMarryDate.text    = ""
    textFieldMarryPlace.text   = ""
    textFieldDivorceDate.text  = ""
    textFieldDivorcePlace.text = ""
    //

    for (var i in person.parentInFamily){
//        families[person.parentInFamily[i].pid].prt("with pid")
        family =families[i]
        family.prt()
        family= families[person.parentInFamily[i].pid]
           family.prt()
        showFamilyData(person,family,i)
    }
    partners.append({   "pid"       : -1, "givenName" : "select / add new partner", "surName"   : "",
                        "bYear"     : "", "dYear"     : ""})
}

function showFamilyData(person,family,i){             // part 4 of set Relatives
    var p1,yb,yd,name
    //   partnerFamily              = families[fam]
    family.prt("Family Data")
    if (person.gender === "F"){ p1 = family.husband}
    else {                      p1 = family.wife   }
    yb = String(p1.yearOf(p1.birthDate))
    yd = String(p1.yearOf(p1.deathDate))
    name  = p1.surName
    //   if ( i === actualFam ) name = name + "  <== actual"
    partners.append({"pid"      : p1.pid, "givenName": p1.givenName, "surName"  : name ,
                        "bYear"    :yb, "dYear"    : yd})

    //   splitPNote("\nFamily Note :\n"+partnerFamily.note)

    if ( i === actualFam ) {
        print("TODO : print marry data for actual")
        textFieldMarryDate.text    = partnerFamily.marriageDate
        textFieldMarryPlace.text   = partnerFamily.marriagePlace
        textFieldDivorceDate.text  = partnerFamily.divorceDate
        textFieldDivorcePlace.text = partnerFamily.divorcePlace
        print("TODO before children")
        //***********************************************************************************************************
        for ( var j=1 ; j< partnerFamily.children.length ; j++){
            p1 = persons[parseInt(partnerFamily.children[j])]
            yb = String(p1.yearOf(p1.birthDate))
            yd = String(p1.yearOf(p1.deathDate))
            childs.append({   "pid"       : p1.pid, "givenName" : p1.givenName, "surName"   : p1.surName,
                              "bYear"     : yb, "dYear"     : yd})
        }
        childs.append({   "pid"       : -1, "givenName" : "select / add new child", "surName"   : "",
                          "bYear"     : "", "dYear"     : ""})


    }

}

function saveScreen(){                   // save person data modified on screen
    print(actualId)
    var person= persons[actualId]
    person.prt("save")
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
function addPerson (p1,p2){              // add new person / child / partner / parent
    // p1 : gender , p2 : surname
    var creatorP = Qt.createComponent("Person.qml")   // define factory for person
    var person = creatorP.createObject(appWindow)
    // define new person id
    if (unusedPersons.length === 0 ){
        person.pid = persons.length
    }
    else {
        person.pid = unusedPersons[0]
        unusedPersons.splice(0,1)
    }
    // set or default gender & given name
    if (p1==="") p1 = "M"
    person.gender = String(p1)

    if ( p1 === "M") {person.givenName = "* male *"}
    else {person.givenName = "* female *"}
    // set or default surname
    if (p2 === "" ) p2 = "-new person-"
    person.surName = p2
    // for childs set family realtion
    if ( selectCase=== "child" ){
        families[partnerFamily.pid].children.push(person.pid)
        person.childOfFamily = partnerFamily.pid
        persons[person.pid]= person
    }

}
function discoParents(id){               // disconnect person id from parents
    var famId = persons[id].childOfFamily // parent family id
    var x = families[famId].children
    var y = parseInt(x.indexOf(String(id))) ;print(y)


    print("childOf",famId,"childlist",families[famId].children,"pos",y)
    //    families[famId].prt()
    //    for (var j in families[famId].children) {
    //        var ss = parseInt(families[famId].children[j])
    //        if (ss === id) print("MATCH", ss,id)
    //        else print("mismatch",ss,id,typeof ss,typeof id)
    //        print(families[famId].children[j])}
    families[famId].children.splice(y,1)       // drop entry
    persons[id].childOfFamily = 0
    print("childOf",persons[id].childOfFamily,"childlist",families[famId].children)
    //    for (var j=0;j<families[famId].children.length;j++) print(families[famId].children[j])

}
function connParents(id,famId){          //    connect person id to family famId
    persons[id].childOfFamily = famId
    families[famId].children.push(id)
}
function discoPartner(id){
    print("TODO disconnect partner")
}
function connPartner(id,famId){
    print("TODO connect partner")
}
