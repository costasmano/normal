//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/13/06, 12:28:01
	// ----------------------------------------------------
	// Method: INV_CreatePhotosList
	// Description
	// Create the list of arrays for the photos
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM02
	Mods_2018_05  //set to read only when appropriate
	//Modified by: Chuck Miller (5/8/18 14:42:32)
	
End if 
//ARRAY LONGINT(InventPhotoID_aL;0)
//ARRAY TEXT(InventPhotoDesc_atxt;0)
//ARRAY INTEGER(InventPhotoSeq_aI;0)
If (INV_InventInspLocked)
	UNLOAD RECORD:C212([InventoryPhotos:113])
	READ ONLY:C145([InventoryPhotos:113])
End if 
QUERY:C277([InventoryPhotos:113]; [InventoryPhotos:113]InvPhotoInsp_ID:2=[InventoryPhotoInsp:112]InvPhotoInspID_L:1)
ORDER BY:C49([InventoryPhotos:113]; [InventoryPhotos:113]Sequence_I:5; >; [InventoryPhotos:113]PhotoDescr_txt:3; >)
//SELECTION TO ARRAY([InventoryPhotos]Sequence_I;InventPhotoSeq_aI;[InventoryPhotos]PhotoDescr_txt;InventPhotoDesc_atxt;[InventoryPhotos]InvPhoto_ID;InventPhotoID_aL)