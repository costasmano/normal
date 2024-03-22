//%attributes = {"invisible":true,"executedOnServer":true}
//Method: Server_ReturnResourceStructure
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/20/18, 15:51:34
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11
End if 
//

C_TEXT:C284($ResourcePath_txt)

C_BLOB:C604($0)

$ResourcePath_txt:=Get 4D folder:C485(Current resources folder:K5:16)


ARRAY TEXT:C222($Documents_atxt; 0)
C_BOOLEAN:C305($Locked_b; $Invisible_B)
C_DATE:C307($Created_d; $Modified_d)
C_TIME:C306($Created_tm; $Modified_tm)
DOCUMENT LIST:C474($ResourcePath_txt; $Documents_atxt; Recursive parsing:K24:13+Ignore invisible:K24:16)



VARIABLE TO BLOB:C532($Documents_atxt; $0)

//End Server_ReturnResourceStructure