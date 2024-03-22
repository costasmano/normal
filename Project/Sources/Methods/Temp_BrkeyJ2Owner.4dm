//%attributes = {"invisible":true}
//  `Temp_brkeyJ2Owner
//  `Translate char J of Brkey to new owner code for item 8 coding
//  `jan-2001
//
//C_STRING(1;$jchar)
//C_STRING(3;$ownercode)
//
//$jchar:=$1
//
//Case of 
//: ($jchar="A")
//$ownercode:="FED"
//: ($jchar="D")
//$ownercode:="DEM"
//: ($jchar="F")
//$ownercode:="FED"
//: ($jchar="M")
//$ownercode:="MTA"
//: ($jchar="P")
//$ownercode:="MDC"
//: ($jchar="R")
//$ownercode:="RRY"
//: ($jchar="S")
//$ownercode:="MHD"
//: ($jchar="T")
//$ownercode:="MUN"
//: ($jchar="Z")
//$ownercode:="PRI"
//
//Else 
//$ownercode:=""
//
//End case 
//
//$0:=$ownercode