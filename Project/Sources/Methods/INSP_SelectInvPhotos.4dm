//%attributes = {"invisible":true}
//Method: INSP_SelectInvPhotos
//Description
// Select the two inventory photos that will be printed with the current bridge inspection
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/29/18, 10:44:59
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10
	// Modified by: Costas Manousakis-(Designer)-(4/21/21 13:05:32)
	Mods_2021_04
	//  `force ob get to return Is long
End if 
//

C_OBJECT:C1216(SelectInvPhotoData_o)
C_LONGINT:C283($ApprPhotoID_L; $ElevPhotoID_L)
C_POINTER:C301($ApprPhotoIDfield_ptr; $ElevPhotoIDfield_ptr)

$ApprPhotoIDfield_ptr:=->[Inspections:27]InvPhotoApproach_L:227
$ElevPhotoIDfield_ptr:=->[Inspections:27]InvPhotoElevation_L:228

$ApprPhotoID_L:=$ApprPhotoIDfield_ptr->
$ElevPhotoID_L:=$ElevPhotoIDfield_ptr->

//get currently selected photo ids
OB SET:C1220(SelectInvPhotoData_o; "ApprPhotoID"; $ApprPhotoID_L)
OB SET:C1220(SelectInvPhotoData_o; "ElevPhotoID"; $ElevPhotoID_L)

C_LONGINT:C283($WinID_L)
$WinID_L:=Open form window:C675("SelectInvPhoto"; Plain form window:K39:10)
DIALOG:C40("SelectInvPhoto")

If (OK=1)
	$ApprPhotoID_L:=OB Get:C1224(SelectInvPhotoData_o; "ApprPhotoID"; Is longint:K8:6)
	$ElevPhotoID_L:=OB Get:C1224(SelectInvPhotoData_o; "ElevPhotoID"; Is longint:K8:6)
	//update the field and log as a link
	$ApprPhotoIDfield_ptr->:=$ApprPhotoID_L
	$ElevPhotoIDfield_ptr->:=$ElevPhotoID_L
	
	If ($ApprPhotoID_L>0)
		LogLink($ApprPhotoIDfield_ptr; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[InventoryPhotos:113]InvPhoto_ID:1)
	Else 
		LogChanges($ApprPhotoIDfield_ptr; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
	End if 
	
	If ($ElevPhotoID_L>0)
		LogLink($ElevPhotoIDfield_ptr; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[InventoryPhotos:113]InvPhoto_ID:1)
	Else 
		LogChanges($ElevPhotoIDfield_ptr; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
	End if 
	
End if 
//End INSP_SelectInvPhotos