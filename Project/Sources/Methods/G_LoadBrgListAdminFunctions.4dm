//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/07/06, 12:07:14
	// ----------------------------------------------------
	// Method: Method: G_LoadBrgListAdminFunctions
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 

C_TEXT:C284($func_txt; $Title_txt; $Okbtn_txt; $IconName_txt)
$func_txt:="BRGLISTADM"
$Title_txt:="Select a Function"
$Okbtn_txt:="Execute"
$IconName_txt:="OSX Toolset"
TMPL_Do_Template_Choise($func_txt; $Title_txt; $Okbtn_txt; $IconName_txt)
