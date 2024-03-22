//%attributes = {}
//GP GetDeficTrans

//Deficiency Description.
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/18/11 13:12:00)
	Mods_2011_10
	//  `Added Optional param2
End if 

C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 5
C_BOOLEAN:C305($SD_b; $FO_b)

If (Count parameters:C259>0)
	C_BOOLEAN:C305($1; $2)
	$SD_b:=$1
	$FO_b:=$2
Else 
	$SD_b:=[Bridge MHD NBIS:1]StructDef:103
	$FO_b:=[Bridge MHD NBIS:1]FunctObs:106
End if 


Case of 
	: (($SD_b) & ($FO_b))
		$0:="SD,FO"  //This should never occur!
	: ($SD_b)
		$0:="SD"
	: ($FO_b)
		$0:="FO"
	Else 
		$0:=""
End case 