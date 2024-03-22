//%attributes = {"invisible":true}
// Method: GetBIEinfo
// Description
// Load Bridge insp engineer info into variables
// vBIEname ; vBIEsuffix ; vBIEphone ; vBIEinitial ; vBIEActing ; vBIEEmail_txt
// Parameters

If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(1/14/08 11:09:19)
	Mods_2007_CM_5401
	//Get the correct phone number from the DB
	// Modified by: costasmanousakis-(Designer)-(9/16/08 09:22:42)
	Mods_2008_CM_5404
	//Fixed missing space after the middle name
	// Modified by: costasmanousakis-(Designer)-(10/19/11 10:01:42)
	Mods_2011_10
	//  `use method GRP_GetGroupMembInfo
	// Modified by: Costas Manousakis-(Designer)-(1/12/17 09:26:39)
	Mods_2017_01
	//  `added vBIE_FILastName_txt
End if 

C_TEXT:C284(vBIEname)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vBIEsuffix; vBIEphone; vBIEinitial; vBIEActing)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(vBIEEmail_txt; vBIE_FILastName_txt)
C_TEXT:C284($Dummy_txt)
vBIEname:="Brian B. Clang"
vBIEsuffix:=" , P.E."
vBIEphone:="(617) 973-7763"
vBIEinitial:="BBC"
vBIEActing:=""
vBIE_FILastName_txt:=""
C_LONGINT:C283($PersonID_L)
$PersonID_L:=GRP_GetGroupMembInfo("BridgeInspectionEngineer"; ->vBIEname; ->vBIEinitial; ->vBIEsuffix; ->vBIEphone; ->vBIEEmail_txt; ->vBIEActing; ->$Dummy_txt; ->vBIE_FILastName_txt)