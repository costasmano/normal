//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/13/07, 14:10:49
	// ----------------------------------------------------
	// Method: M_MPA
	// Description
	// 
	// 
	// Parameters
	P_MPA
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	
End if 
C_LONGINT:C283($Lpid)

$Lpid:=LSpawnProcess("P_MPA"; <>LStackSize; "MPA"; True:C214; False:C215)