//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/23/10, 21:47:34
	// ----------------------------------------------------
	// Method: CRTG_RecentAction_OM
	// Description
	//  ` Recent Action object method for Rating review section
	// 
	// Parameters
	// $1 : $FldPtr
	// ----------------------------------------------------
	
	Mods_2010_09
End if 
C_POINTER:C301($1)
PushChange(1; $1)
CRTG_RecentAction(->[Conslt Rating:63]RecentAction:71; ->[Conslt Rating:63]IsRtgHere:70)
PushChange(1; ->[Conslt Rating:63]IsRtgHere:70)
PushChange(1; ->[Conslt Rating:63]RecentAction:71)