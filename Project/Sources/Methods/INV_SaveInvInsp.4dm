//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/27/06, 19:00:22
	// ----------------------------------------------------
	// Method: INV_SaveInvInsp
	// Description
	// Save the current inventory inspection.
	// 
	// Parameters
	// $1 : Prompt : boolean : Prompt to save changes - default : false
	// ----------------------------------------------------
	Mods_2007_CM02
End if 
C_BOOLEAN:C305($1; $Prompt_b)
If (Count parameters:C259=1)
	$Prompt_b:=$1
Else 
	$Prompt_b:=False:C215
End if 
If ($Prompt_b)
	C_BOOLEAN:C305($vSaveInvInsp_b)
	Case of 
		: (INV_InventInspLocked)
			$vSaveInvInsp_b:=False:C215
		Else 
			If (Modified record:C314([InventoryPhotoInsp:112]))
				CONFIRM:C162("Save any changes made to this Inspection?"; "Save"; "Don't Save")
				$vSaveInvInsp_b:=(OK=1)
			Else 
				$vSaveInvInsp_b:=False:C215
			End if 
			
	End case 
	If ($vSaveInvInsp_b)
		FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1)
		SAVE RECORD:C53([InventoryPhotoInsp:112])
		VALIDATE TRANSACTION:C240  //validate all changes made in include forms etc.
		FLUSH CACHE:C297  //make sure all is saved...
	Else 
		CANCEL TRANSACTION:C241
	End if 
Else 
	FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1)
	SAVE RECORD:C53([InventoryPhotoInsp:112])
	VALIDATE TRANSACTION:C240  //validate all changes made in include forms etc.
	FLUSH CACHE:C297  //make sure all is saved...
End if 
