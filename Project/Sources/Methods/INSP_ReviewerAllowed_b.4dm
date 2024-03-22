//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: INSP_ReviewerAllowed_b
// Description
//  ` Determine whether the current user is allowed to do a review
// 
// Parameters
// $0 : $Allowed_b (boolean)
// $1 : $Groupname_txt
// $2 : $InspDBIE_L
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/25/11, 08:54:07
	// First Release
	Mods_2011_10
End if 
C_BOOLEAN:C305($0; $Allowed_b)
$Allowed_b:=False:C215
C_TEXT:C284($1; $Groupname_txt)
$Groupname_txt:=$1
$InspDBIE_L:=-1
C_LONGINT:C283($InspDBIE_L)
If (Count parameters:C259>1)
	C_LONGINT:C283($2)
	$InspDBIE_L:=$2
End if 

$Allowed_b:=(GRP_UserInGroup($Groupname_txt)=1) | (User in group:C338(Current user:C182; "Design Access Group"))
If ($InspDBIE_L>0)
	$Allowed_b:=$Allowed_b | ($InspDBIE_L=<>CurrentUser_PID)
End if 

$0:=$Allowed_b