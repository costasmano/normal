//Method: Object Method: [Contract_Project_Maintenance].PreservationInput.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/07/12, 12:03:48
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(8/27/12 09:24:14)
	Mods_2012_08  //initialize adt and detour to -1
End if 
//
If ([Contract_Project_Maintenance:100]District:8="")
	CONFIRM:C162("A Bridge Number and/or a District must be specified!"; "Cancel"; "Try again")
	If (OK=1)
		CANCEL:C270
	End if 
Else 
	[Contract_Project_Maintenance:100]BridgeNo:4:=vBridgeNo
	[Contract_Project_Maintenance:100]ADT_L:14:=-1
	[Contract_Project_Maintenance:100]Detour_L:16:=-1
	SAVE RECORD:C53([Contract_Project_Maintenance:100])
	ACCEPT:C269
End if 

//End Object Method: [Contract_Project_Maintenance].PreservationInput.bValidate