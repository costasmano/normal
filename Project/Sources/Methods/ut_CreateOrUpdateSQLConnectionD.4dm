//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_CreateOrUpdateSQLConnectionD
// User name (OS): cjmiller
// Date and time: 02/10/06, 11:45:22
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TEXT:C284($1; $DBToConnectTo_txt)
$DBToConnectTo_txt:=$1
QUERY:C277([SQL_Connections:126]; [SQL_Connections:126]SQL_DatabaseName_s:1=$DBToConnectTo_txt)

If (Records in selection:C76([SQL_Connections:126])=0)
	CREATE RECORD:C68([SQL_Connections:126])
	[SQL_Connections:126]SQL_DatabaseName_s:1:=$DBToConnectTo_txt
	SAVE RECORD:C53([SQL_Connections:126])
	
End if 

UNLOAD RECORD:C212([SQL_Connections:126])
READ WRITE:C146([SQL_Connections:126])
LOAD RECORD:C52([SQL_Connections:126])
If (ut_LoadRecord(->[SQL_Connections:126]))
	ALERT:C41("You must enter all "+$DBToConnectTo_txt+" connection information before you can proceed")
	C_LONGINT:C283($fwidth; $fheight)
	FORM GET PROPERTIES:C674([SQL_Connections:126]; "Connect_dlg"; $fwidth; $fheight)
	NewWindow(580; 320; 0; Plain window:K34:13; $DBToConnectTo_txt+" connection Information")
	FORM SET INPUT:C55([SQL_Connections:126]; "Connect_dlg")
	MODIFY RECORD:C57([SQL_Connections:126])
	CLOSE WINDOW:C154
	C_BOOLEAN:C305($OkToProceed_b)
	$OkToProceed_b:=ut_LoadSQLConnectionInfo($DBToConnectTo_txt)
	UNLOAD RECORD:C212([SQL_Connections:126])
	READ ONLY:C145([SQL_Connections:126])
	
End if 

//End ut_CreateOrUpdateSQLConnectionD