//%attributes = {"invisible":true}
// Method: CRTG_LetterInfo
// Description
//  ` Load required variables for Cons Insp and Rating Letters
// 
// Parameters
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/18/11, 16:54:08
	// ----------------------------------------------------
	// First Release
	Mods_2011_10
End if 

GetDBIEccInfo(->asDistrict)
GetBIEinfo
GetInspContact
C_TEXT:C284(vWriterInitial)  // Command Replaced was o_C_STRING length was 30
vWriterInitial:=vInspContactInitial+"/"+Lowercase:C14(vInspContactInitial)
GetBridgeEngineer

GetRtgOvrLoadEng