//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 02/09/16, 11:22:52
//----------------------------------------------------
//Method: LSS_LoadReportTemplates
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_02_bug  // Add new code to display saved quick reports for [lss_inventory]
	//Modified by: administrator (2/9/16 11:22:53)
	
End if 
C_TEXT:C284($func_txt; $Title_txt; $Okbtn_txt; $IconName_txt)
$func_txt:="AncillaryListRpt"
READ ONLY:C145([Templates:86])
READ ONLY:C145([zSpecialReports:106])
QUERY:C277([zSpecialReports:106]; [zSpecialReports:106]Purpose:1=$func_txt)
If (Records in selection:C76([zSpecialReports:106])=0)
	ALERT:C41("No Preloaded reports found!")
Else 
	$Title_txt:="Select a Report"
	$Okbtn_txt:=""  //use the default
	$IconName_txt:="OSX report"
	
	TMPL_Do_Template_Choise($func_txt; $Title_txt; $Okbtn_txt; $IconName_txt)
End if 

//End LSS_LoadReportTemplates