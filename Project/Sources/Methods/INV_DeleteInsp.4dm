//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/27/06, 19:48:33
	// ----------------------------------------------------
	// Method: INV_DeleteInsp
	// Description
	// Delete an Inventory inspection
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM02
	// Modified by: CJMiller-(Designer)-(8/12/13 )
	Mods_2013_08
	//  `Added  parameter to  skip canceling out of the current form
End if 
C_BOOLEAN:C305($1; $CancelForm_b)
$CancelForm_b:=$1
C_TEXT:C284($msg)
C_LONGINT:C283($numPhotos_L)
$numPhotos_L:=Records in selection:C76([InventoryPhotos:113])
Case of 
	: ($numPhotos_L>1)
		$msg:=" and "+String:C10($numPhotos_L)+" photos"
	: ($numPhotos_L=1)
		$msg:=" and "+String:C10($numPhotos_L)+" photo"
	Else 
		
End case 

$msg:="Delete this Inventory Photo Inspection"+$msg+"?"
CONFIRM:C162($msg; "Delete")
If (OK=1)
	//First delete related photos
	If (Not:C34(Is new record:C668([InventoryPhotoInsp:112])))
		FIRST RECORD:C50([InventoryPhotos:113])
		While (Not:C34(End selection:C36([InventoryPhotos:113])))
			PushGrpDelete(->[InventoryPhotos:113]InvPhoto_ID:1)
			NEXT RECORD:C51([InventoryPhotos:113])
		End while 
		FlushGrpDeletions(->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; 2)
		DELETE SELECTION:C66([InventoryPhotos:113])
		LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1)
		DELETE RECORD:C58([InventoryPhotoInsp:112])
		VALIDATE TRANSACTION:C240
		If ($CancelForm_b)
			CANCEL:C270
		End if 
	Else 
		//just cancel trans if new record
		If ($CancelForm_b)
			CANCEL:C270
		End if 
		CANCEL TRANSACTION:C241
		
	End if 
	
End if 
