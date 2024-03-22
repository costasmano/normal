//%attributes = {"invisible":true}
//  ` Temp_Brkey2Cat
//  `Translate 1st 3 chars of Brkey to Bridge category for new item 8 coding
//
//  ` Jan-2001
//
//C_STRING(3;$brA)
//C_STRING(3;$cat)
//
//$brA:=$1
//
//Case of 
//: ($bra="BLD")
//$cat:="BLD"
//: ($bra="BRI")
//$cat:="BRI"
//: ($bra="CLO")
//$cat:="CLO"
//: ($bra="CLP")
//$cat:="CLP"
//: ($bra="CUL")
//$cat:="CUL"
//: ($bra="DES")
//$cat:="DES"
//: ($bra="DNA")
//$cat:="DUM"
//: ($bra="DNB")
//$cat:="DUM"
//: ($bra="DRE")
//$cat:="REM"
//: ($bra="DTL")
//$cat:="DUM"
//: ($bra="DUM")
//$cat:="DUM"
//: ($bra="PED")
//$cat:="PED"
//: ($bra="RRO")
//$cat:="RRO"
//: ($bra="TEB")
//$cat:="BRI"
//: ($bra="TEC")
//$cat:="CUL"
//: ($bra="TED")
//$cat:="TRO"
//: ($bra="TEE")
//$cat:="TRO"
//: ($bra="TEH")
//$cat:="BRI"
//: ($bra="TEP")
//$cat:="PED"
//: ($bra="TER")
//$cat:="RRO"
//: ($bra="TET")
//$cat:="TRO"
//: ($bra="UTL")
//$cat:="UTL"
//
//Else 
//$cat:=""
//
//End case 
//
//$0:=$cat