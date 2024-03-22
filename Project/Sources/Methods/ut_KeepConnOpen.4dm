//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/05/11, 08:47:18
	// ----------------------------------------------------
	// Method: ut_KeepConnOpen
	// Description
	//  ` Attempt to keep a connection open.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_10
End if 
C_BOOLEAN:C305(<>fQuit)
C_TIME:C306($timecheck_t)
While (Not:C34(<>fQuit))
	$timecheck_t:=Current time:C178(*)
	IDLE:C311
	DELAY PROCESS:C323(Current process:C322; 10*60)
	IDLE:C311
End while 