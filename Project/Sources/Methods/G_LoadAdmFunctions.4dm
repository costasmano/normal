//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/07/06, 12:07:46
	// ----------------------------------------------------
	// Method: G_LoadAdmFunctions
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_TEXT:C284($func_txt; $Title_txt; $Okbtn_txt; $IconName_txt)
$func_txt:="BMSADMIN"
$Title_txt:="Select a Function"
$Okbtn_txt:="Execute"
$IconName_txt:="OSX Toolset"
TMPL_Do_Template_Choise($func_txt; $Title_txt; $Okbtn_txt; $IconName_txt)
