//%attributes = {"invisible":true,"executedOnServer":true}
//Method: SYSUTIL_GetServerInfo
//Description
// get  infromation about the server execute on server
// Parameters
// $0: $infoObject
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/26/20, 12:35:47
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
	C_OBJECT:C1216(SYSUTIL_GetServerInfo; $0)
End if 
//

C_OBJECT:C1216($0)
OB SET:C1220($0; "ServerIP"; ut_ReturnServerIP\
; "ServerPort"; Get database parameter:C643(35)\
; "ServerMachineName"; Current machine:C483\
; "ServerCurrentUser"; Current system user:C484\
; "ServerStructurefile"; Structure file:C489\
; "ServerDatafile"; Data file:C490)

//End SYSUTIL_GetServerInfo