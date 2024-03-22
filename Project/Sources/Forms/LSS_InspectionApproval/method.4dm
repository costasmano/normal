
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/10/15, 15:38:05
//----------------------------------------------------
//Method: Form Method: LSS_InspectionApproval
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  //Add ability to approve or reject  LSS inspections 
	//Modified by: administrator (11/10/15 16:45:30)
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		FORM GOTO PAGE:C247(LSS_Page_l)
		vtPrevRevComments:=[LSS_Inspection:164]LSS_ApprovalComments_txt:49
		vtRevComments:=""
		C_LONGINT:C283($l; $t; $r; $b; $Width_L; $Height_L)
		FORM GET PROPERTIES:C674("LSS_InspectionApproval"; $Width_L; $Height_L)
		GET WINDOW RECT:C443($l; $t; $r; $b)
		SET WINDOW RECT:C444($l; $t; $l+$Width_L+5; $t+$Height_L+5)
End case 


//End Form Method: LSS_InspectionApproval

