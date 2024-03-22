//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/09/12, 16:09:03
//----------------------------------------------------
//Method: LB_StoredQuickReports
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/9/12 16:09:04)
	
End if 
C_TEXT:C284($func_txt; $Title_txt; $Okbtn_txt; $IconName_txt)
$func_txt:=[LB_QueryTable:147]QueryName_s:1
$Title_txt:="Select a Report"
$Okbtn_txt:=""  //use the default
$IconName_txt:="OSX report"
TMPL_Do_Template_Choise($func_txt; $Title_txt; $Okbtn_txt; $IconName_txt)

//End LB_StoredQuickReports