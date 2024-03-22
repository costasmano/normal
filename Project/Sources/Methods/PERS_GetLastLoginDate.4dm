//%attributes = {}
//Method: PERS_GetLastLoginDate
//Description
// Get the last login date for a user in the [Personnel] table. Can be used in quick reports.
// Parameters
// $0 : $LastLogin_d
// $1 : $UserPID (optional) if not passed use the current record  personID
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jun 22, 2022, 15:30:03
	// ----------------------------------------------------
	Mods_2022_06
	
	C_DATE:C307(PERS_GetLastLoginDate; $0)
	C_LONGINT:C283(PERS_GetLastLoginDate; $1)
End if 
//

C_DATE:C307($0; $lastlogin_d)
C_LONGINT:C283($PID_L)
$lastlogin_d:=!00-00-00!
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$PID_L:=$1
Else 
	$PID_L:=[Personnel:42]Person ID:1
End if 

C_TEXT:C284($loginData_txt)
Begin SQL
	select 
	[Personnel].[MachineName_txt]
	from [Personnel]
	where
	[Personnel].[Person ID] = :$PID_L
	into :$loginData_txt ;
End SQL

If ($loginData_txt#"")
	C_BOOLEAN:C305(4D_ERROR_B)
	4D_ERROR_B:=False:C215
	C_TEXT:C284($lastOnError)
	$lastOnError:=Method called on error:C704
	ON ERR CALL:C155("4D_Errors")
	C_OBJECT:C1216($LoginData_o)
	$LoginData_o:=JSON Parse:C1218($loginData_txt)
	If (OB Is defined:C1231($LoginData_o; "stations"))
		$lastlogin_d:=Date:C102($LoginData_o.stations[0].lastdate)
	End if 
	
	ON ERR CALL:C155($lastOnError)
End if 

$0:=$lastlogin_d
//End PERS_GetLastLoginDate