//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/07/10, 10:30:16
//----------------------------------------------------
//Method: ut_SQLMakeConnnection
//Description
//
// Parameters
// ----------------------------------------------------
//$0 longint 
//Values 1 login succeeded
//- numbers login in failed or cancel occured
//$1 User name
//$2 password - may be blank
//$3 IP address to log in to
//$4 dialog for password sceen
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (9/7/10 10:30:18)
	//Ugrade to v11
	//Modified by: Charles Miller (5/10/11 16:24:44)
End if 
SQLError_b:=False:C215
4DError_b:=False:C215
C_LONGINT:C283($0; $ErrorStatus_l)
$ErrorStatus_l:=1  //set it to succeed

C_TEXT:C284($1; $2; $3; $4; $UserName_txt; $Password_txt; $IPAddress_txt; $Dialog_txt)
$UserName_txt:=$1
$Password_txt:=$2
$IPAddress_txt:=$3
$Dialog_txt:=$4
C_BOOLEAN:C305($MakeConnection_b)
$MakeConnection_b:=True:C214

SQLConnectionMade_b:=False:C215

If ($Password_txt#"")
	
	If (Not:C34(Validate password:C638(f_GetUserID($UserName_txt); $Password_txt)))
		If (vbOnScreenMessage)
			ALERT:C41("The entered password is not valid for "+Current user:C182+"!")
		End if 
		$Password_txt:=""
		$ErrorStatus_l:=-2  // bad password
	End if 
End if 
If ($Password_txt="")
	CENTER_WINDOW(330; 200; Regular window:K27:1)
	vsDialogTxt:=$4+<>sCR+<>sCR
	vsDialogTxt:=vsDialogTxt+"          Please enter your password:"
	vsPassword:=""
	DIALOG:C40([Dialogs:21]; "Get Password")
	CLOSE WINDOW:C154
	$Password_txt:=vsPassword
	If (OK=1)
		$MakeConnection_b:=True:C214
	Else 
		$MakeConnection_b:=False:C215
	End if 
End if 
If ($MakeConnection_b)
	ut_SQLConnect($UserName_txt; $Password_txt; $IPAddress_txt)
	If (SQLError_b | 4DError_b)
		
		Case of 
			: (Find in array:C230(SQLErrorNumbers_al; 1003)>0)
				ALERT:C41("Connection to 4D SQL server not made to IP "+$IPAddress_txt+" as 4D Server running but SQL Server not started")
			: (Find in array:C230(SQLErrorNumbers_al; 1004)>0)
				ALERT:C41("Connection to 4D SQL server not made to IP "+$IPAddress_txt+" as maximum users have already connected")
			: (Find in array:C230(SQLErrorNumbers_al; 1006)>0)
				ALERT:C41("Connection to 4D SQL server not made to IP "+$IPAddress_txt+" as 4D Server not running ")
			: (Find in array:C230(SQLErrorNumbers_al; 1105)>0)
				ALERT:C41("Connection to 4D SQL server not made to IP "+$IPAddress_txt+" Bad user name or password")
				
			Else 
				ALERT:C41("Connection to 4D SQL server not made to IP "+$IPAddress_txt+" unknown error ")
		End case 
		$ErrorStatus_l:=-3
	Else 
		
		vsPassword:=$Password_txt
	End if 
Else 
	
	$ErrorStatus_l:=-4
End if 
$0:=$ErrorStatus_l
//End ut_SQLMakeConnnection

