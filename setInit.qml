import QtQuick 2.0
import "Gedcom.js" as Gedcom

Item {
    property url path : "file:///C:/Users/hans-/OneDrive/Data/" // todo : define user specific path
    property url workPath : "file:///C:/Users/hans-/myGeneal/" // todo : define user specific path

    property string infile : "Bertram.ged"

    property string maleColor  : "none"
    property string femaleColor : "pink"

    property int firstYear : 1500
    property int lastYear  : 2017   // todo : use actual year

    property int ageAtBirth_male   : 19
    property int ageAtBirth_female : 16
    property int maxAge_father     : 60
    property int maxAge_mother     : 50
    property int maxAge            : 100
    property int maxAgeDelta_childs   : 40
    property int maxAgeDelta_partners : 60




}



