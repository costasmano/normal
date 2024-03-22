// ----------------------------------------------------
// Form Method: PRJ_Details.inc
// User name (OS): cjmiller
// Date and time: 12/14/06, 12:13:51
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		ut_SetStringOrTextFilter(->[PRJ_StructuralReview:119]SR_Comments_txt:5)
		
	Else 
		PRJ_SetProjectChangesMade(->[PRJ_StructuralReview:119]; ->[PRJ_StructuralReview:119]SR_ModifiedBy_s:8; ->[PRJ_StructuralReview:119]SR_ModifiedTimeStamp_s:9)
End case 
//End Form Method: PRJ_Details.inc