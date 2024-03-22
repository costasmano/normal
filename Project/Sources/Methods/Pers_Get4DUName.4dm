//%attributes = {"invisible":true}
//Method: Pers_Get4DUName
//Description
// return the 4D User name of a person in Personnel table or from PersonID passed as param 1
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/17/16, 16:13:48
	// ----------------------------------------------------
	//Created : 
	Mods_2016_06
	
	C_TEXT:C284(Pers_Get4DUName; $0)
	C_LONGINT:C283(Pers_Get4DUName; $1)
	
End if 
//
C_TEXT:C284($0)
C_LONGINT:C283($UserID_L)

C_TEXT:C284($Username_txt; $Startup_txt; $pw_txt)
C_LONGINT:C283($Numlogins_L)
C_DATE:C307($lastlogin_d)
$Username_txt:=""
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$UserID_L:=$1
Else 
	$UserID_L:=[Personnel:42]UserID_4D:12
End if 
If ($UserID_L#0)
	ON ERR CALL:C155("G_PrintError")
	GET USER PROPERTIES:C611($UserID_L; $Username_txt; $Startup_txt; $pw_txt; $Numlogins_L; $lastlogin_d)
	ON ERR CALL:C155("")
End if 
$0:=$Username_txt
//End Pers_Get4DUName