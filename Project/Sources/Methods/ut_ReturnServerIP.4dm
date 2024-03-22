//%attributes = {"invisible":true,"executedOnServer":true}
//Method: ut_ReturnServerIP $0 returns the server IP address
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/14/17, 11:05:16
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
End if 
//
C_TEXT:C284($0; $IPAddress_txt; $Mask)
C_LONGINT:C283($errCode)
$errCode:=IT_MyTCPAddr($IPAddress_txt; $Mask)
$0:=$IPAddress_txt
//End ut_ReturnServerIP