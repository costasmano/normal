//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/13/06, 14:33:25
	// ----------------------------------------------------
	// Method: INV_GetBINInventoryPhotos
	// Description
	// get the inventory photos for a BIN
	// 
	// Parameters
	// $1 : BIN ( optional) : string(3)
	// ----------------------------------------------------
	Mods_2007_CM02
	// Modified by: Costas Manousakis-(Designer)-(5/3/12 10:34:08)
	Mods_2012_05
	//  `Unload the current record of [InventoryPhotoInsp] after the sort
	Mods_2013_06  //r001 ` Add code to alow for add, delete and duplicate 
	//[InventoryPhotoInsp] and [InventoryPhotos]
	//Modified by: Charles Miller (6/20/13 13:15:13)
End if 
C_TEXT:C284($1; $BIN)  // Command Replaced was o_C_STRING length was 3
If (Count parameters:C259=1)
	$BIN:=$1
Else 
	$BIN:=[Bridge MHD NBIS:1]BIN:3
End if 
QUERY:C277([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]BIN:2=$BIN)
ORDER BY:C49([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]InvPhotoDate_D:3; <; [InventoryPhotoInsp:112]InvPhotoInspID_L:1; <)
UNLOAD RECORD:C212([InventoryPhotoInsp:112])