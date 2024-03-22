//%attributes = {"invisible":true}
//Method: USR_GetUserGroupMemberships
//Description
// get all group memberships for a user
// Parameters
// $0 : $memberships_c : collection with membership info
// $1 : $UserID_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Oct 21, 2022, 18:43:52
	Mods_2022_10
	// ----------------------------------------------------
	
	C_COLLECTION:C1488(USR_GetUserGroupMemberships; $0)
	C_LONGINT:C283(USR_GetUserGroupMemberships; $1)
	
End if 
//
C_COLLECTION:C1488($0)
C_LONGINT:C283($1)

$0:=New collection:C1472

C_LONGINT:C283($userId; $numlogin)
C_TEXT:C284($name; $strartup; $pw)
ARRAY LONGINT:C221($membership; 0)
C_DATE:C307($lastlogin)
$userId:=$1
C_TEXT:C284($methodonError)
$methodonError:=Method called on error:C704
C_BOOLEAN:C305(4DError_b)
4DError_b:=False:C215
ON ERR CALL:C155("4D_Errors")
GET USER PROPERTIES:C611($userId; $name; $strartup; $pw; $numlogin; $lastlogin; $membership)
ON ERR CALL:C155($methodonError)

If (Not:C34(4DError_b))
	
	ARRAY TEXT:C222($ugroupnames; 0)
	ARRAY TEXT:C222($ugroupmain; 0)  // either "m" for direct membership, or "s" for submemberships
	ARRAY LONGINT:C221($ugroupnums; 0)
	C_LONGINT:C283($loop_L; $owner; $numPrimary)
	C_TEXT:C284($grname)
	$numPrimary:=Size of array:C274($membership)
	ARRAY TEXT:C222($ugroupnames; $numPrimary)
	ARRAY TEXT:C222($ugroupmain; $numPrimary)  // either "m" for direct membership, or "s" for submemberships
	ARRAY LONGINT:C221($ugroupnums; $numPrimary)
	
	For ($loop_L; 1; Size of array:C274($membership))
		GET GROUP PROPERTIES:C613($membership{$loop_L}; $grname; $owner)
		$ugroupnames{$loop_L}:=$grname
		$ugroupnums{$loop_L}:=$membership{$loop_L}
		$ugroupmain{$loop_L}:="m"
	End for 
	
	For ($loop_L; 1; Size of array:C274($membership))
		USR_AddGroupMemberships(->$ugroupnums; $membership{$loop_L})
	End for 
	
	ARRAY TEXT:C222($ugroupnames; Size of array:C274($ugroupnums))
	ARRAY TEXT:C222($ugroupmain; Size of array:C274($ugroupnums))
	For ($loop_L; ($numPrimary+1); Size of array:C274($ugroupnums))
		GET GROUP PROPERTIES:C613($ugroupnums{$loop_L}; $grname; $owner)
		$ugroupnames{$loop_L}:=$grname
		$ugroupmain{$loop_L}:="s"
	End for 
	
	ARRAY TO COLLECTION:C1563($0; $ugroupnums; "groupid"; $ugroupnames; "groupname"; $ugroupmain; "main")
	
Else 
	$0.push(New object:C1471("error"; "Invalid UserID"))
End if 

//End USR_GetUserGroupMemberships   