//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_ResetSQLLastUpdateDate
// User name (OS): cjmiller
// Date and time: 03/02/06, 12:19:58
// ----------------------------------------------------
// Description
// This method will reset last update date to todays date for a particluar sql connection
//when written there were 2 tish and pontis
//
// Parameters
//$1 Connection  to query  [SQL_Connections] with
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
C_TEXT:C284($1; $DBToConnectTo_txt)
$DBToConnectTo_txt:=$1
QUERY:C277([SQL_Connections:126]; [SQL_Connections:126]SQL_DatabaseName_s:1=$DBToConnectTo_txt)
ut_LoadRecord(->[SQL_Connections:126])
[SQL_Connections:126]SQL_LastUpdate_d:5:=Current date:C33(*)
SAVE RECORD:C53([SQL_Connections:126])
UNLOAD RECORD:C212([SQL_Connections:126])

//End ut_ResetSQLLastUpdateDate