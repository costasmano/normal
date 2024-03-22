
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/10/15, 12:32:12
//----------------------------------------------------
//Method: Form Method: [LSS_Inspection]LSS_PhotoLog
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/10/15 12:32:14)
	// Modified by: Costas Manousakis-(Designer)-(11/5/18 14:45:18)
	Mods_2018_11
	//  `removed border from Lss_CommentsPrint_pct object 
	// Modified by: Costas Manousakis-(Designer)-(1/23/19 11:06:17)
	Mods_2019_01_bug
	//  `use INSP_FitPictToFormObj - CallReference #600
End if 
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		vPageNo:=vPageNo+1
		INSP_FitPictToFormObj("Lss_CommentsPrint_pct"; ->Lss_CommentsPrint_pct)
		
End case 
//End Form Method: [LSS_Inspection]LSS_PhotoLog

