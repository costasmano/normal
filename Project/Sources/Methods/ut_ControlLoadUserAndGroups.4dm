//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 06/13/13, 12:56:06
//----------------------------------------------------
//Method: ut_ControlLoadUserAndGroups
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_06  //r001 ` Add update progress bar and change code to deal with adjusted user names
	//Modified by: Charles Miller (6/13/13 16:27:04)
End if 

C_TEXT:C284($SavedDocument_txt)
$SavedDocument_txt:=ut_SaveUserLogInInformation
C_TEXT:C284($FileName_txt)
ARRAY TEXT:C222($SelectedFiles_atxt; 0)

$FileName_txt:=Select document:C905(""; "*"; "Select User and Group Document to load"; 0; $SelectedFiles_atxt)

If (Size of array:C274($SelectedFiles_atxt)=1)
	C_BLOB:C604($Blob_blb)
	SET BLOB SIZE:C606($Blob_blb; 0)
	DOCUMENT TO BLOB:C525($SelectedFiles_atxt{1}; $Blob_blb)
	If (BLOB size:C605($Blob_blb)>0)
		BLOB TO USERS:C850($Blob_blb)
	End if 
	
End if 

ut_LoadUserLoginInformation($SavedDocument_txt)
//End ut_ControlLoadUserAndGroups