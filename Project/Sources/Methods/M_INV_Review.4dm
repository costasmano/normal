//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/13/06, 14:57:38
	// ----------------------------------------------------
	// Method: M_INV_Review
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM02
End if 
C_LONGINT:C283($Lpid)
If (False:C215)
	P_INV_Review
End if 

$Lpid:=LSpawnProcess("P_INV_Review"; <>LStackSize; "Review Invent. Insp"; True:C214; False:C215)