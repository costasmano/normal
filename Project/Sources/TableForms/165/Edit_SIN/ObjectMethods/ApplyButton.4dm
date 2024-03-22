//Method: Object Method: [LSS_Inventory].Edit_SIN.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/03/15, 12:22:58
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09_bug
	Mods_2018_03_bug  //Add code using a semapphore to make sure no duplicate [LSS_Inventory]LSS_StructureNumber_s are created
	Mods_2018_11  //Fix issue where LSS_VerifyNewInventoryNumber was called with no pointer and added alert
	
	//Modified by: Chuck Miller (11/8/18 15:37:11)
	
End if 
//

C_TEXT:C284($msg_txt; $LSS_InventorySemaphore_txt)
$msg_txt:="Change "+LSS_SIN_Label_txt+" from "+String:C10([LSS_Inventory:165]LSS_IdentificationNumber_L:5)+" to "+String:C10(v_165_005_L)+" and"+<>sCR
$msg_txt:=$msg_txt+"Structure number from "+[LSS_Inventory:165]LSS_StructureNumber_s:6+" to "+v_165_006_txt+"?"
CONFIRM:C162($msg_txt)
If (Ok=1)
	[LSS_Inventory:165]LSS_StructureNumber_s:6:=v_165_006_txt
	[LSS_Inventory:165]LSS_IdentificationNumber_L:5:=v_165_005_L
	C_LONGINT:C283($Count_L)
	
	LSS_CheckForSave
	C_LONGINT:C283($MaxNumber_L)
	$Count_L:=LSS_VerifyNewInventoryNumber(->$MaxNumber_L)
	If ($Count_L>0)
		[LSS_Inventory:165]LSS_StructureNumber_s:6:=Old:C35([LSS_Inventory:165]LSS_StructureNumber_s:6)
		[LSS_Inventory:165]LSS_IdentificationNumber_L:5:=Old:C35([LSS_Inventory:165]LSS_IdentificationNumber_L:5)
		v_165_006_txt:=[LSS_Inventory:165]LSS_StructureNumber_s:6
		v_165_005_L:=[LSS_Inventory:165]LSS_IdentificationNumber_L:5
		
		C_TEXT:C284($msg_txt)
		$msg_txt:="Another structure of type "+[LSS_Inventory:165]LSS_InventoryType_s:28+" exists on Route "+Substring:C12([LSS_Inventory:165]LSS_Route_s:9; 1; 5)+" in District "+String:C10([LSS_Inventory:165]LSS_District_L:3)
		$msg_txt:=$msg_txt+" with "+LSS_SIN_Label_txt+String:C10($MaxNumber_L; " ######")+" !!!"+<>sCR+"Value has been reset."
		ALERT:C41($msg_txt)
	Else 
		FM_SaveInventoryInput
		START TRANSACTION:C239
		
		ACCEPT:C269
	End if 
	If (Test semaphore:C652(LSS_InventorySemaphore_txt))
		CLEAR SEMAPHORE:C144(LSS_InventorySemaphore_txt)
	End if 
End if 
//End Object Method: [LSS_Inventory].Edit_SIN.Button