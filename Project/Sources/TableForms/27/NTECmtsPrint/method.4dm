If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/10/07, 16:44:51
	// ----------------------------------------------------
	// Method: Form Method: [Inspections];"NTECmtsPrint"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM04
	// Modified by: Costas Manousakis-(Designer)-(1/23/19 11:17:44)
	Mods_2019_01_bug
	//  `use INSP_FitPictToFormObj - CallReference #600
End if 
Case of 
		
	: (Form event code:C388=On Header:K2:17)
		vPageNo:=vPageNo+1
		
	: (Form event code:C388=On Printing Detail:K2:18)
		vPageNo:=vPageNo+1
		INSP_FitPictToFormObj("CommentsPreview"; ->CommentsPrevw_P)
End case 