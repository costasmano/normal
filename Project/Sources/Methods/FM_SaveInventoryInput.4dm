//%attributes = {"invisible":true}
//Method: FM_SaveInventoryInput
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 03/31/15, 16:17:41
	//----------------------------------------------------
	
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/31/15 16:17:42)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
	// Modified by: manousakisc-(Designer)-(9/5/2023 16:59:34)
	Mods_2023_09
	//  `added updating of modified_by fields
	// Modified by: Costas Manousakis-(Designer)-(2024-03-19 17:07:08)
	Mods_2024_03_bug
	//  `disabled calls related to activity log
End if 
If (Modified record:C314([LSS_Inventory:165]))
	[LSS_Inventory:165]LSS_ModifiedBy_s:30:=<>CURRENTUSER_NAME
	[LSS_Inventory:165]LSS_ModifiedISODate_s:31:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
	C_TEXT:C284($ErrorMethodCalled_txt)
	$ErrorMethodCalled_txt:=Method called on error:C704
	ON ERR CALL:C155("LSS_ErrorMethod")
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	Compiler_Archive
	// start of Mods_2024_03_bug
	If (False:C215)
		APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_InventoryId_s")
		If (ACT_PushGroupChanges(Table:C252(->[LSS_Inventory:165]); 12; ->$FieldsToSkip_atxt))
			FlushGrpChgs(12; ->[LSS_Inventory:165]LSS_InventoryId_s:1; ->[LSS_Inventory:165]LSS_InventoryId_s:1; ->[LSS_Inventory:165]LSS_InventoryId_s:1; 0)
		End if 
		
	End if 
	// end of Mods_2024_03_bug
	SAVE RECORD:C53([LSS_Inventory:165])
	ON ERR CALL:C155($ErrorMethodCalled_txt)
	If (LSS_DuplicateRecordError_B | LSS_Error_B)
		CANCEL TRANSACTION:C241
	Else 
		VALIDATE TRANSACTION:C240
		
	End if 
End if 

//End FM_SaveInventoryInput