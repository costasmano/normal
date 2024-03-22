If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2021-12-30 14:38:34)
	Mods_2021_12_bug
	//  `fixes for saving correctly comments other than GENERAL REMARKS
	
End if 
//This area does not use the On load event.  
C_LONGINT:C283($CommentIndx_L)

$CommentIndx_L:=TINInspCommentTypes_atxt  //index of comment dropdown


If (TINInspCommentTypes_atxt{$CommentIndx_L}="GENERAL REMARKS")
	INSP_Comments_WP_OM(New object:C1471("WPAreaname"; OBJECT Get name:C1087(Object current:K67:2); "fieldptr"; ->[TIN_Inspections:184]Comments:23; "formEvent"; Form event code:C388; "changeStack"; 1))
Else 
	
	//we are in one of the [TIN_Insp_Comments] records - need special handling
	Case of 
		: (Form event code:C388=On Load:K2:1)
			//not active
		: (Form event code:C388=On Losing Focus:K2:8)
			//hanlde on losing focus here - need to save any changes
			NTI_SaveAndUpdateComments_WP(False:C215)
		: (Form event code:C388=On Unload:K2:2)
			//the two calls save the same zoom for [TIN_Inspections]Comments and [TIN_Insp_Comments]Comment_blb
			INSP_Comments_WP_OM(New object:C1471("WPAreaname"; OBJECT Get name:C1087(Object current:K67:2); "fieldptr"; ->[TIN_Insp_Comments:188]Comment_blb:9; "formEvent"; Form event code:C388; "changeStack"; 3))
			INSP_Comments_WP_OM(New object:C1471("WPAreaname"; OBJECT Get name:C1087(Object current:K67:2); "fieldptr"; ->[TIN_Inspections:184]Comments:23; "formEvent"; Form event code:C388; "changeStack"; 1))
		Else 
			//other events here
			INSP_Comments_WP_OM(New object:C1471("WPAreaname"; OBJECT Get name:C1087(Object current:K67:2); "fieldptr"; ->[TIN_Insp_Comments:188]Comment_blb:9; "formEvent"; Form event code:C388; "changeStack"; 3))
			
	End case 
	
End if 
//End [ElementsSafety].Safety ElmInput.WriteProArea