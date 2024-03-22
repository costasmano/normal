
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/18/14, 16:24:33
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].New_InventoryItem.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/18/14 16:24:34)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
	Mods_2018_03_bug  //Add code using a semapphore to make sure no duplicate [LSS_Inventory]LSS_StructureNumber_s are created
	// Modified by: manousakisc-(Designer)-(9/6/2023 14:12:34)
	Mods_2023_09
	//  `added update of created by fields.
End if 


LSS_CheckForSave
C_LONGINT:C283($MaxNumber_L; $Count_L)
$Count_L:=LSS_VerifyNewInventoryNumber(->$MaxNumber_L)
If ($Count_L>0)
	LSS_SIN_2_L:=0
	ALERT:C41("Resetting Inventory number")
	LSS_SetInventoryNumber
	OBJECT SET ENABLED:C1123(*; "bValidate"; False:C215)
	
Else 
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	C_TEXT:C284($ErrorMethodCalled_txt)
	$ErrorMethodCalled_txt:=Method called on error:C704
	ON ERR CALL:C155("LSS_ErrorMethod")
	APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_InventoryId_s")
	If (Is new record:C668([LSS_Inventory:165]))
		LogNewRecord(->[LSS_Inventory:165]LSS_InventoryId_s:1; ->[LSS_Inventory:165]LSS_InventoryId_s:1; ->[LSS_Inventory:165]LSS_InventoryId_s:1; 0; "LSS_Inventory")
		[LSS_Inventory:165]LSS_CreatedBy_s:27:=<>CURRENTUSER_NAME
		[LSS_Inventory:165]LSS_CreatedISODate_s:29:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
	End if 
	If (ACT_PushGroupChanges(Table:C252(->[LSS_Inventory:165]); 1; ->$FieldsToSkip_atxt))
		FlushGrpChgs(1; ->[LSS_Inventory:165]LSS_InventoryId_s:1; ->[LSS_Inventory:165]LSS_InventoryId_s:1; ->[LSS_Inventory:165]LSS_InventoryId_s:1; 0)
		SAVE RECORD:C53([LSS_Inventory:165])
		ACCEPT:C269
	End if 
	ON ERR CALL:C155($ErrorMethodCalled_txt)
	If (LSS_DuplicateRecordError_B | LSS_Error_B)
		CANCEL TRANSACTION:C241
		CANCEL:C270
	Else 
		VALIDATE TRANSACTION:C240
	End if 
End if 
If (Test semaphore:C652(LSS_InventorySemaphore_txt))
	CLEAR SEMAPHORE:C144(LSS_InventorySemaphore_txt)
End if 
//End Object Method: [LSS_Inventory].New_InventoryItem.bValidate