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
