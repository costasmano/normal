//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/12/07, 19:48:11
	// ----------------------------------------------------
	// Method: PRJ_BPGM_PrintSelection
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(10/7/09 10:34:59)
	Mods_2009_10
	//added Set Print option, Print Settings and the ">" param in the Print Selection command
End if 

C_TEXT:C284(PRJ_BPGM_PrintTitle; $Title_txt)
$Title_txt:=Request:C163("Enter Report Title"; PRJ_BPGM_PrintTitle)
If (OK=1)
	PRJ_BPGM_PrintTitle:=f_TrimStr($Title_txt; True:C214; True:C214)
	FORM SET OUTPUT:C54([PRJ_ProjectDetails:115]; "BridgeProgram.prt")
	SET PRINT OPTION:C733(Scale option:K47:3; 50)
	PRINT SETTINGS:C106
	PRINT SELECTION:C60(Current form table:C627->; >)
	FORM SET OUTPUT:C54([PRJ_ProjectDetails:115]; "BridgeProgram")
End if 