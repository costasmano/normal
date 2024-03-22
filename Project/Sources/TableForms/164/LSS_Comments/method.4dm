
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/10/15, 12:34:26
//----------------------------------------------------
//Method: Form Method: [LSS_Inspection]LSS_Comments
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/10/15 12:34:28)
	// Modified by: Costas Manousakis-(Designer)-(1/23/19 10:16:05)
	Mods_2019_01_bug
	//  `use INSP_FitPictToFormObj - CallReference #600
End if 
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		vPageNo:=vPageNo+1
		INSP_FitPictToFormObj("Lss_CommentsPrint"; ->Lss_CommentsPrint_pct)
End case 
//End Form Method: [LSS_Inspection]LSS_Comments

