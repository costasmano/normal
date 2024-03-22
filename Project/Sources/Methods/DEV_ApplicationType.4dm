//%attributes = {"invisible":true}
//Method: DEV_ApplicationType
//Description
// Show text of application type
// Parameters
// $0 : $description
// $1 : $apptypecode
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/26/20, 12:57:28
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
	
	C_TEXT:C284(DEV_ApplicationType; $0)
	C_LONGINT:C283(DEV_ApplicationType; $1)
End if 
//
C_TEXT:C284($0)
C_LONGINT:C283($1)
Case of 
	: ($1=3)
		$0:="4D Desktop"
	: ($1=0)
		$0:="4D Local mode"
	: ($1=4)
		$0:="4D Remote mode"
	: ($1=5)
		$0:="4D Server"
	: ($1=1)
		$0:="4D Volume desktop"
		
End case 

//End DEV_ApplicationType