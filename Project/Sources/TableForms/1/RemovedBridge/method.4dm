//Method: [Bridge MHD NBIS];"RemovedBridge"
//Description
// Dialog displayed when bridge is changed to REM in the ID input form
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/24/20, 17:36:59
	// ----------------------------------------------------
	//Created : 
	Mods_2020_02_bug
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET TITLE:C194(*; "Item7"; [Bridge MHD NBIS:1]Item7:65)
		OBJECT SET TITLE:C194(*; "Item6A_1"; "ITEM 6A: OTHER ")
		GOTO OBJECT:C206(*; "Item6A_2")
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 

//End [Bridge MHD NBIS];"RemovedBridge"