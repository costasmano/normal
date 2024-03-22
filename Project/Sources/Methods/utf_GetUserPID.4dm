//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/12/06, 19:48:18
	// ----------------------------------------------------
	// Method: Method: utf_GetUserPID
	// Description
	// get the Personnel ID of current user
	// 
	// Parameters
	// $0: Integer : PID
	// $1 : 4D Password system UserName : optiona
	// ----------------------------------------------------
	
	Mods_2006_CM07
End if 
C_LONGINT:C283($0; $PID)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($UserID_4D)
C_TEXT:C284($1; $UserName)  // Command Replaced was o_C_STRING length was 32
If (Count parameters:C259=1)
	$UserName:=$1
	$UserID_4D:=utf_GetUserID($UserName)
Else 
	$UserID_4D:=<>CurrentUser_UID
End if 
READ ONLY:C145([Personnel:42])
QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=$UserID_4D)
If (Records in selection:C76([Personnel:42])=1)
	$PID:=[Personnel:42]Person ID:1
Else 
	$PID:=-1
End if 
$0:=$PID
READ WRITE:C146([Personnel:42])
