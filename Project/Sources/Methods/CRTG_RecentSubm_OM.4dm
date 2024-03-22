//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/23/10, 21:40:54
	// ----------------------------------------------------
	// Method: CRTG_RecentSubm_OM 
	// Description
	//  ` Most Recent submission object method
	// 
	// Parameters
	// $1 : FldPtr
	// ----------------------------------------------------
	
	Mods_2010_09
End if 
C_POINTER:C301($1)
PushChange(1; $1)
[Conslt Rating:63]MostRecentSub:49:=MaxDate([Conslt Rating:63]RepSubmit1:23; [Conslt Rating:63]RepSubmit2:31; [Conslt Rating:63]RepSubmit3:41; [Conslt Rating:63]RepSubmit4:52)
PushChange(1; ->[Conslt Rating:63]MostRecentSub:49)