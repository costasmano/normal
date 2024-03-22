//%attributes = {"invisible":true}
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): Designer
	// Date and time: 11/22/05, 10:27:28
	// ----------------------------------------------------
	// Method: G_LoadReportTemplates
	// Description
	// Load all the Quick Report Templates
	//
	// Parameters
	//
	//
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(3/7/2006 12:04:16)
	Mods_2006_CM03
End if 
C_TEXT:C284($func_txt; $Title_txt; $Okbtn_txt; $IconName_txt)
$func_txt:="BridgeListRpt"
$Title_txt:="Select a Report"
$Okbtn_txt:=""  //use the default
$IconName_txt:="OSX report"
TMPL_Do_Template_Choise($func_txt; $Title_txt; $Okbtn_txt; $IconName_txt)
