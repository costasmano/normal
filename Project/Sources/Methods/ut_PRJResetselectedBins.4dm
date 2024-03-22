//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJResetselectedBins
// User name (OS): cjmiller
// Date and time: 01/04/07, 16:59:48
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 

QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34#"")


READ ONLY:C145(*)
READ WRITE:C146([PRJ_ProjectDetailsIncludedBINS:122])

C_LONGINT:C283($Loop_l; $Count_l)

For ($Loop_l; 1; Records in selection:C76([PRJ_ProjectDetails:115]))
	
	
	PRJ_CreateIncludedBINRecord([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34; Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6))
	
	NEXT RECORD:C51([PRJ_ProjectDetails:115])
	
End for 
//End ut_PRJResetselectedBins