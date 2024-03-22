//Method: Object Method: [Contract_Project_Maintenance].PreservDecision.bCancel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/05/12, 16:49:19
	// ----------------------------------------------------
	//Created : 
	Mods_2012_07
End if 
//
If (Modified record:C314([Contract_Project_Maintenance:100]))
	C_LONGINT:C283($Option_L)
	$Option_L:=ut_3Option_Confirm("Bridge Decision Flowchart has been modified!"; "Save and Exit"; "Exit NO Save"; "Cancel")
	Case of 
		: ($Option_L=1)
			SAVE RECORD:C53([Contract_Project_Maintenance:100])
			ACCEPT:C269
		: ($Option_L=2)
			CANCEL:C270
		: ($Option_L=3)
	End case 
Else 
	CANCEL:C270
End if 

//End Object Method: [Contract_Project_Maintenance].PreservDecision.bCancel