//%attributes = {"invisible":true}
//  `Temp_brkey2Owner
//  ` translate 1st 3 chars of bridge key to owner code
//
//C_STRING(3;$brkeyA)
//C_STRING(3;$item8Owner)
//
//$brkeyA:=$1
//
//If (($brkeyA>="000") & ($brkeyA<="999"))
//If ($brkeyA="821")
//$Item8owner:="STA"  `Fort Devens Bridge
//Else 
//$Item8owner:="MHD"
//End if 
//Else 
//Case of 
//: ($brkeyA="CAN")
//$item8Owner:="CAN"
//: ($brkeyA="COE")
//$item8Owner:="FED"
//: ($brkeyA="DNR")
//$item8Owner:="DEM"
//: ($brkeyA="FED")
//$item8Owner:="FED"
//: ($brkeyA="MDC")
//$item8Owner:="MDC"
//: ($brkeyA="MPA")
//$item8Owner:="MPA"
//: ($brkeyA="MTA")
//$item8Owner:="MTA"
//: ($brkeyA="MUN")
//$item8Owner:="MUN"
//: ($brkeyA="NED")
//$item8Owner:="FED"
//: ($brkeyA="PRI")
//$item8Owner:="PRI"
//: ($brkeyA="RRO")
//$item8Owner:="RRY"
//: ($brkeyA="TE@")
//$item8Owner:="MBT"
//: ($brkeyA="TWN")
//$item8Owner:="MUN"
//: ($brkeyA="WRA")
//$item8Owner:="WRA"
//Else 
//$item8owner:=""
//
//End case 
//End if 
//
//$0:=$item8Owner