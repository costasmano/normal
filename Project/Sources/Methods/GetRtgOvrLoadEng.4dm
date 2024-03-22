//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: GetRtgOvrLoadEng
// Description
//  ` Get the ratings and overload engineer info;  Loads variables :
//  ` vROEngineer;vROEngrName;vROEngrInitials;vROEngrActing;vROEngrEmail;vROEngrPhone

// Parameters
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/18/11, 16:58:20
	Mods_2011_10
End if 
C_TEXT:C284(vROEngineer; vROEngrName; $vEOEngrsuffix; vROEngrInitials; vROEngrActing; vROEngrEmail; vROEngrPhone)

C_LONGINT:C283($EngID_L)
$EngID_L:=GRP_GetGroupMembInfo("RatingsAndOverloadEngineer"; ->vROEngrName; ->vROEngrInitials; ->$vEOEngrsuffix; ->vROEngrPhone; ->vROEngrEmail; ->vROEngrActing)
vROEngineer:=vROEngrName+$vEOEngrsuffix
