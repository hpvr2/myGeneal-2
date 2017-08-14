// EditPage : functions for Display and edit of Data

function isEmpty(obj) {  for (var o in obj) if (o) return false;  return true;}

function select(selCase,gender,name,from,to){  // selection list ( filtered ) for persons

    name = name.toLowerCase()

    var p1
    var x = ""
    var blank = "                                        "
    var y
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
        y = p1.yb
        if (p1.yb === "9999")  y = "----" ; else y = p1.yb
        if ( (gender === "" || gender === p1.gender) &&  // gender not specified or matching
                ( x === name) &&                         // surname starting with name ( in lowercase )
                (from === 0 | p1.yb === "9999"| from <p1.yb ) &&  // from earlier than birthyear
                (to === ""  | p1.yb === "9999" | to > p1.yb)     )   // to later than birthyear
        {
            selectOther.append({ "pid": p1.pid, "givenName": p1.gn, "surName"  : p1.sn,
                                   "bYear" : y, "dYear" : p1.yd})
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
function splitPNote(note){                     // split person note on screen
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
function splitFNote(note){                     // split family note on screen
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
function setRelatives(id){                     // set person and family data in screen
    var person = {}
    person = persons[id]
    person.prt("start setRelatives")
    showPersonData(person)
    showParentData(person)
    showPartnerData(person)
}
function showPersonData(person){               // part 1 of set Relatives
    //### display person related data ****  part 1 *************************************************
    labelPid.text = "Id : " +    person.pid

    textFieldGivenName.text = person.givenName
    textFieldGivenName.font.bold = true
    textFieldGivenName.textColor =  ( person.gender === "M") ? standard.maleColor : standard.femaleColor

    textFieldSurName.text   = person.surName
    textFieldSurName.font.bold = true
    textFieldSurName.textColor =  ( person.gender === "M") ? standard.maleColor : standard.femaleColor

    textFieldBirthDate.text = person.birthDate
    textFieldBirthPlace.text= person.birthPlace
    textFieldDeathDate.text = person.deathDate
    textFieldDeathPlace.text= person.deathPlace
    textAge.text ="estimated Age : " + person.age()

    textFieldOccupation.text= person.occupation

    textEditPnote.clear()
    splitPNote(person.note)

}
function showParentData(person){               // part 2 of set Relatives
    //### display parent related data
    parents.clear()
    var p1
    //    person.prt("show Parents")
    p1=person.father()
    if ( p1.pid === "0" ) {
        parents.append({   "pid"       : "-1", "givenName" : "select father", "surName"   : "",
                           "bYear"     : "", "dYear"     : ""})
    }
    else {
        parents.append({ "pid": p1.pid, "givenName": p1.givenName, "surName"  : p1.surName,
                           "bYear" : p1.birthYearStr(), "dYear" : p1.deathYearStr()} )
    }
    p1=person.mother()
    if ( p1.pid === "0" ) {
        parents.append({   "pid"       : "-2", "givenName" : "select mother", "surName"   : "",
                           "bYear"     : "", "dYear"     : ""})
    }
    else {
        parents.append({ "pid": p1.pid, "givenName": p1.givenName, "surName"  : p1.surName,
                           "bYear" : p1.birthYearStr(), "dYear" : p1.deathYearStr()} )
    }
}
function showPartnerData(person){              // part 3 of set Relatives
    //### display family related data ******  part 3   *****************************************************************
    var p1
    if (actualFam >= person.parentInFamily.length){ actualFam = 0  }   //TODO

    partners.clear()
    childs.clear()
    textFieldMarryDate.text    = ""
    textFieldMarryPlace.text   = ""
    textFieldDivorceDate.text  = ""
    textFieldDivorcePlace.text = ""
    //
    for ( var i=0; i< person.parentInFamily.length; i++){
        if (person.parentInFamily[i] !== ""){
            family= families[person.parentInFamily[i]]
            showFamilyData(person,family,i)}
    }
    partners.append({   "pid"       : "-1", "givenName" : "select new partner", "surName"   : "",
                        "bYear"     : "", "dYear"     : ""})
}
function showFamilyData(person,family,i){      // part 4 of set Relatives
    var p1,name
    //   partnerFamily              = families[fam]
    //   family.prt("Family Data")
    if (person.gender === "F"){ p1 = persons[family.husband]}
    else {                      p1 = persons[family.wife   ]}
    //    p1.prt("p1")
    name  = p1.surName
    if ( i === actualFam ) {
        actualFamId = family.pid
        name = name + "  <== actual"
    }
    partners.append({"pid"      : p1.pid, "givenName": p1.givenName, "surName"  : name ,
                        "bYear" : p1.birthYearStr(), "dYear" : p1.deathYearStr()} )

    if ( i === actualFam ) {
        textFieldMarryDate.text    = family.marriageDate
        textFieldMarryPlace.text   = family.marriagePlace
        textFieldDivorceDate.text  = family.divorceDate
        textFieldDivorcePlace.text = family.divorcePlace
        //***********************************************************************************************************
        for (var i in family.children){
            if (family.children[i] !== ""){
                p1 = persons[family.children[i]]
                //            p1.prt("child")
                childs.append({   "pid"       : p1.pid, "givenName" : p1.givenName, "surName"   : p1.surName,
                                  "bYear" : p1.birthYearStr(), "dYear" : p1.deathYearStr()} )
            }}
        childs.append({   "pid"       : "-1", "givenName" : "select new child", "surName"   : "",
                          "bYear"     : "", "dYear"     : ""})


    }

}
function saveScreen(){                         // save person data modified on screen
    persons[actualId].givenName  = textFieldGivenName.text
    persons[actualId].surName    = textFieldSurName.text
    persons[actualId].birthDate  = textFieldBirthDate.text
    persons[actualId].birthPlace = textFieldBirthPlace.text
    persons[actualId].deathDate  = textFieldDeathDate.text
    persons[actualId].deathPlace = textFieldDeathPlace.text
    persons[actualId].occupation = textFieldOccupation.text
    persons[actualId].note       = textEditPnote.text

    if ( actualFamId !== 0) {
        families[actualFamId].marriageDate =textFieldMarryDate.text
        families[actualFamId].marriagePlace =textFieldMarryPlace.text
        families[actualFamId].divorceDate =textFieldDivorceDate.text
        families[actualFamId].divorcePlace =textFieldDivorcePlace.text
    }
}
function addFamily (){                         // add new family
    var pLast = persons[lastId]
    var pAct = persons[actualId]
    var creatorF = Qt.createComponent("Family.qml")   // define factory for family
    var family = creatorF.createObject(appWindow)
    // define new family id
    if (unusedFamilies.length === 0 ){ family.pid = families.length }
    else { family.pid = unusedFamilies[0]  ;  unusedFamilies.splice(0,1) }
    if ( pAct.gender === "M" ) {
        family.husband = pAct.pid
        family.wife = pLast.pid }
    else {
        family.husband = pAct.pid
        family.wife = pLast.pid }
    families[family.pid]=family
    persons[pLast.pid].parentInFamily.push(family.pid)
    persons[pAct.pid].parentInFamily.push(family.pid)


    setRelatives(actualId)
}
function addPerson (p1,p2){                    // add new person / child / partner / parent
    // p1 : gender , p2 : surname
    var creatorP = Qt.createComponent("Person.qml")   // define factory for person
    var person = creatorP.createObject(appWindow)
    // define new person id
    if (unusedPersons.length === 0 ){ person.pid = persons.length }
    else { person.pid = unusedPersons[0]  ;  unusedPersons.splice(0,1) }
    // set or default gender & given name
    if (p1==="") p1 = "M" ;
    person.gender = String(p1)

    if ( p1 === "M") {person.givenName = "* male *" }
    else {person.givenName = "* female *"}
    // set or default surname
    if (p2 === "" ) p2 = "-new person-" ;
    person.surName = p2
    // for childs set family realtion
    if ( selectCase=== "child" ){
        families[family.pid].children.push(person.pid)
        person.childOfFamily = family.pid
    }
    if ( selectCase=== "partner" ){
        families[family.pid].prt()
    }


    persons[person.pid]= person
    persons[person.pid].prt("persons pid")
    actualId = person.pid
    setRelatives(actualId)
}
function discoParents(id){                     // disconnect person id from parents
    var famId = persons[id].childOfFamily // parent family id
    var x = families[famId].children
    var y = parseInt(x.indexOf(String(id)))

    families[famId].children.splice(y,1)       // drop entry
    persons[id].childOfFamily = 0

}
function connParents(id,famId){                //    connect person id to family famId
    persons[id].childOfFamily = famId
    families[famId].children.push(id)
}
function deleteFamily(){                       // delete family
    var family = families[actualFamId]
    for ( var i in family.children){
        var id = family.children[i]
        persons[id].prt("before child")
        persons[id].childOfFamily = ""
        persons[id].prt("after child")
    }

    person = persons[family.husband]
    person.prt("before parent")
    var i = person.parentInFamily.indexOf(family.parentInFamily)
    person.parentInFamily.splice(i,1)

    person = persons[family.wife]
    var i = person.parentInFamily.indexOf(family.parentInFamily)
    person.parentInFamily.splice(i,1)

    var creatorF = Qt.createComponent("Family.qml")   // define factory for family
    family = creatorF.createObject(appWindow)
    families[actualFamId] = family
    families[actualFamId].prt("after delete")
    unusedFamilies.push(actualFamId)
}




