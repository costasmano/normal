//%attributes = {"shared":true}
//Method: QR_LegacyOwner
//Description
// Legacy Owner 
// Parameters
// $0 ; $Owner_txt
// $1 : $LegacyOwner_txt
// $2 : $CurrentOwner_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/10/12
	// ----------------------------------------------------
	//Created : 
	Mods_2012_09
End if 
//
C_TEXT:C284($1; $2; $0)

If ($1="")
	$0:=$2
Else 
	$0:=$1
End if 

//End QR_LegacyOwner