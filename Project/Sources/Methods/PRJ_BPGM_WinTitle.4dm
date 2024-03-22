//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/05/07, 11:34:46
	// ----------------------------------------------------
	// Method: PRJ_BPGM_WinTitle
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 
SET WINDOW TITLE:C213(PRJ_WinTitle+"["+String:C10(Records in selection:C76([PRJ_ProjectDetails:115]))+"]")