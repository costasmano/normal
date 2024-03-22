//%attributes = {"invisible":true}
//Method: ut_openBrInspManual2015
//Description
//  ` open link to the Bridge Inspection manual
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/18/15, 12:10:59
	// ----------------------------------------------------
	//Created : 
	Mods_2015_11
End if 
//
C_TEXT:C284($manual_txt)

$manual_txt:="http://www.massdot.state.ma.us/highway/DoingBusinessWithUs/ManualsPublicationsForms/BridgeInspectionHandbook.aspx"
$manual_txt:=ut_GetSysParameter("BRGINSPMANUAL"; $manual_txt)
OPEN URL:C673($manual_txt; *)
//End ut_openBrInspManual2015