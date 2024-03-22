//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/25/07, 11:27:59
	// ----------------------------------------------------
	// Method: Server_ArchiveLogFile
	// Description
	// Archive 20000 Archive log records
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
End if 
Startup_PL
ArchiveLogFile("2"; "20000"; "1")

ut_SetNextRunTimeStamp(Current method name:C684)
