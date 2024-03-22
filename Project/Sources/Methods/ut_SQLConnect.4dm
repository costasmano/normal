//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 06/21/10, 13:42:01
// ----------------------------------------------------
// Method: ut_SQLConnect
//ut_SQLConnect ($UserName;$Password;$ServerIP)
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------
//$1 user name
//$2 password
//$3 server

// Modified by: Charles Miller (6/21/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:15:39) 
	//Ugrade to v11
	//Modified by: Charles Miller (5/10/11 16:28:15)
End if 
C_TEXT:C284($1; $2; $3; $UserName; $ServerIP; $Password)
$UserName:=$1
$Password:=$2
$ServerIP:=$3

ut_Message("Logging on…"+<>sCR)
ON ERR CALL:C155("SQL_ERROR")  //
ARRAY LONGINT:C221(SQLErrorNumbers_al; 0)
ARRAY TEXT:C222(SQL_InternalCodes_atxt; 0)
ARRAY TEXT:C222(SQL_InternalDescriptions_atxt; 0)



SQL LOGIN:C817("IP:"+$ServerIP; $UserName; $Password; *)
If (Not:C34(SQLError_b))
	SQLConnectionMade_b:=True:C214
End if 
ON ERR CALL:C155("4D_Errors")  //

