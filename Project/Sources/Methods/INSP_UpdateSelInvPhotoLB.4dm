//%attributes = {"invisible":true}
//Method: INSP_UpdateSelInvPhotoLB
//Description
// Update the listbox of photos in the SelectInvPhoto dialog 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/29/18, 16:36:05
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10
End if 
//
ORDER BY:C49([InventoryPhotos:113]; [InventoryPhotos:113]Sequence_I:5; >)
C_OBJECT:C1216($progress_o)
//start the bar
$progress_o:=ProgressNew("Loading Inventory photos"; Records in selection:C76([InventoryPhotos:113]); False:C215; " Inv photo"; 3)
ARRAY BLOB:C1222($BlobPhotos_ablb; 0)
SELECTION TO ARRAY:C260([InventoryPhotos:113]PhotoDescr_txt:3; v_113_003_atxt; [InventoryPhotos:113]InvPhoto_ID:1; v_113_001_aL; [InventoryPhotos:113]InvPhoto_X:4; $BlobPhotos_ablb)
ARRAY PICTURE:C279(INVPHOTOINSPAPPR_AP; Size of array:C274(v_113_003_atxt))
C_PICTURE:C286($temp_p)
C_LONGINT:C283($loop_L; $pictSize_L)
For ($loop_L; 1; Size of array:C274(INVPHOTOINSPAPPR_AP))
	//update progress
	UpdateProgressNew($progress_o; $loop_L)
	BLOB TO PICTURE:C682($BlobPhotos_ablb{$loop_L}; $temp_p; "image/jpeg")
	$pictSize_L:=Picture size:C356($temp_p)
	If ($pictSize_L>0)
		CREATE THUMBNAIL:C679($temp_p; $temp_p; 250; 250; Scaled to fit prop centered:K6:6)
	End if 
	INVPHOTOINSPAPPR_AP{$loop_L}:=$temp_p
End for 
//quit progress
Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))

//End INSP_UpdateSelInvPhotoLB