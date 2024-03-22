//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/13/06, 15:38:59
	// ----------------------------------------------------
	// Method: Method: INV_GetReviewInventoryPhotos
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM02
End if 
QUERY:C277([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]Approved_I:6#BMS Approved)
ORDER BY:C49([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]ApproveDate_D:8; <)
