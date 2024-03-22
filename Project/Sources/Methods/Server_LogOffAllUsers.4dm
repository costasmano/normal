//%attributes = {"invisible":true}
// ----------------------------------------------------
// Server_LogOffAllUsers
// User name (OS): charlesmiller
// Date and time: 07/23/09, 11:43:58
// ----------------------------------------------------
// Description
// This method will get list of alll registered clients and execute quit method
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_07  //r002 `07/23/09, 11:48:01   `Add code to automatically quit all clients
End if 


EXECUTE ON CLIENT:C651("@"; "ut_AutoQuit")
ut_SetNextRunTimeStamp(Current method name:C684)
//End Server_LogOffAllUsers