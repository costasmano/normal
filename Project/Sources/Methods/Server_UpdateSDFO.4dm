//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/18/07, 14:11:33
	// ----------------------------------------------------
	// Method: Server_UpdateSDFO
	// Description
	//  ` Run an update for AASHTO and the SD FO status.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
	// Modified by: Costas Manousakis-(Designer)-(5/20/13 11:10:44)
	Mods_2013_05
	//  `added Server_SetItem75 and more initialization commands
End if 
Startup_PL

ARRAY POINTER:C280(ptr_Changes; 0; 0)

C_TIME:C306($vTMStartTime; $vTMEndTime)
$vTMStartTime:=Current time:C178(*)
InitPrefs

INIT_UI_GV

ut_RetrieveTOWNDATADoc

Server_SetItem75

ALL RECORDS:C47([Bridge MHD NBIS:1])
RecalcAASHTO(False:C215)
HI_CalcBridgeHIFields(False:C215)
REDUCE SELECTION:C351([Bridge MHD NBIS:1]; 0)
InitFOSDFields(False:C215)
ut_SetNextRunTimeStamp(Current method name:C684)