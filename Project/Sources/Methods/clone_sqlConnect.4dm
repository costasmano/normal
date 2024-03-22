//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/02/14, 21:41:37
//----------------------------------------------------
//Method: clone_sqlConnect
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_TEXT:C284($1; $2; $3; $UserName; $ServerIP; $Password)
$UserName:=$1
$Password:=$2
$ServerIP:=$3

ON ERR CALL:C155("clone_SQLError")  //
ARRAY LONGINT:C221(SQLErrorNumbers_al; 0)
ARRAY TEXT:C222(SQL_InternalCodes_atxt; 0)
ARRAY TEXT:C222(SQL_InternalDescriptions_atxt; 0)



SQL LOGIN:C817("IP:"+$ServerIP; $UserName; $Password; *)
If (Not:C34(SQLError_b))
	SQLConnectionMade_b:=True:C214
End if 
ON ERR CALL:C155("clone_4DError")  //


//End clone_sqlConnect

