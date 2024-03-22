//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/24/05, 09:17:57
	// ----------------------------------------------------
	// Method: G_Insp_FmtSTOWN
	// Description
	// Format the sTOWN object in Inspection print forms.
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(2/28/11 10:18:14)
	Mods_2011_02
	//  `Set the format of sTown to "" - fix for v11 conversion
	// Modified by: Costas Manousakis-(Designer)-(6/13/14 17:31:06)
	Mods_2014_06_bug
	//  `replaced the logic with a call to ut_FitPrintFormObject
End if 
OBJECT SET FORMAT:C236(sTown; "")
ut_FitPrintFormObject(->sTown; 11; 8)