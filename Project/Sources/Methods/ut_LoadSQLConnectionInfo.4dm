//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_LoadSQLConnectionInfo
// User name (OS): cjmiller
// Date and time: 12/13/05, 11:15:17
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM04
	// Modified by: Costas Manousakis-(Designer)-(8/5/14 08:46:10)
	Mods_2014_08_bug
	//  `added SQL_SCHEMA_s
End if 
C_BOOLEAN:C305($0)
C_TEXT:C284($1; $DBToConectTo_txt)
$DBToConectTo_txt:=$1
$0:=False:C215
SET QUERY DESTINATION:C396(Into current selection:K19:1)
QUERY:C277([SQL_Connections:126]; [SQL_Connections:126]SQL_DatabaseName_s:1=$DBToConectTo_txt)

Case of 
	: ([SQL_Connections:126]SQL_UserName_s:2="")
	: ([SQL_Connections:126]SQL_Password_s:3="")
	: ([SQL_Connections:126]SQL_OBDCName_s:4="")
	: ([SQL_Connections:126]SQL_DatabaseName_s:1="")
		
	Else 
		SQL_UserName_s:=[SQL_Connections:126]SQL_UserName_s:2
		SQL_Password_s:=[SQL_Connections:126]SQL_Password_s:3
		SQL_ODBCName_s:=[SQL_Connections:126]SQL_OBDCName_s:4
		SQL_DatabaseName_s:=[SQL_Connections:126]SQL_DatabaseName_s:1
		SQL_Change_d:=[SQL_Connections:126]SQL_LastUpdate_d:5
		SQL_Schema_s:=[SQL_Connections:126]SQL_SCHEMA_s:6
		$0:=True:C214
End case 
If (False:C215)
	ARRAY TEXT:C222($Usersources_atxt; 0)
	ARRAY TEXT:C222($Userdrivers_atxt; 0)
	ARRAY TEXT:C222($Systemsources_atxt; 0)
	ARRAY TEXT:C222($Systemdrivers_atxt; 0)
	
	SQL GET DATA SOURCE LIST:C989(User data source:K49:12; $Usersources_atxt; $Userdrivers_atxt)
	SQL GET DATA SOURCE LIST:C989(System data source:K49:13; $Systemsources_atxt; $Systemdrivers_atxt)
	Case of 
		: (Find in array:C230($Usersources_atxt; SQL_ODBCName_s)>0)
		: (Find in array:C230($Systemsources_atxt; SQL_ODBCName_s)>0)
			
		Else 
			$0:=False:C215
	End case 
End if 
//End ut_LoadSQLConnectionInfo