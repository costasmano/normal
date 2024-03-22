//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/09, 09:12:38
	// ----------------------------------------------------
	// Method: INSP_ElmtDescUtil
	// Description
	//  `Utility to load and clear arrays used in labels of parent elements when printing comments.
	//  `Called after getting all elements with "LOAD" parameter, and at end of printing routine with "CLEAR"
	// 
	// Parameters
	// $1 : $Task_txt ("LOAD" | "CLEAR")
	// ----------------------------------------------------
	
	Mods_2009_03
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="LOAD")
		ARRAY TEXT:C222(INSPPR_ElmDesc_atxt; 0)
		ARRAY INTEGER:C220(INSPPR_ElmNo_ai; 0)
		SELECTION TO ARRAY:C260([ElementsSafety:29]ElementNo:1; INSPPR_ElmNo_ai; [ElementsSafety:29]Description:22; INSPPR_ElmDesc_atxt)
		
	: ($Task_txt="CLEAR")
		ARRAY TEXT:C222(INSPPR_ElmDesc_atxt; 0)
		ARRAY INTEGER:C220(INSPPR_ElmNo_ai; 0)
		
End case 