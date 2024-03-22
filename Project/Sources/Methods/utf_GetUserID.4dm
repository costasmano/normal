//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/04/05, 14:52:07
	// ----------------------------------------------------
	// Method: utf_GetUserID
	// Description
	// Get the user ID of a User from the 4D Password System
	//
	// Parameters
	// ----------------------------------------------------
	
	Mods_2005_CM18
End if 
C_LONGINT:C283($0; $UserID_L)
C_TEXT:C284($1; $UserName_S)  // Command Replaced was o_C_STRING length was 80
ARRAY TEXT:C222($arr_Usernames_txt; 0)
ARRAY LONGINT:C221($arr_UserIDS_L; 0)
If (Count parameters:C259=1)
	$UserName_S:=$1
Else 
	$UserName_S:=Current user:C182
End if 
GET USER LIST:C609($arr_Usernames_txt; $arr_UserIDS_L)
C_LONGINT:C283($Array_Pos)
$Array_Pos:=Find in array:C230($arr_Usernames_txt; $UserName_S)
If ($Array_Pos>0)
	$UserID_L:=$arr_UserIDS_L{$Array_Pos}
Else 
	$UserID_L:=0
End if 

$0:=$UserID_L