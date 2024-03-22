//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/31/06, 14:57:12
	// ----------------------------------------------------
	// Method: Server_UpdateArrayLoaders
	// Description
	// Run methods on server that update if necessary documents on server
	// that store arrays used in startup.
	// Parameters
	ut_UpdateArrayLoaders
	// ----------------------------------------------------
	
	Mods_2006_CM03
End if 
C_LONGINT:C283($Lpid)
$Lpid:=New process:C317("ut_UpdateArrayLoaders"; 0; "Update Arrays")