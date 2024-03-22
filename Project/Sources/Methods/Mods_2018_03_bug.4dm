//%attributes = {"invisible":true}
//Method: Mods_2018_03
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 03/06/18, 13:28:16
	// ----------------------------------------------------
	//Created : 
	Mods_2018_03_bug
End if 
//Add code using a semapphore to make sure no duplicate [LSS_Inventory]LSS_StructureNumber_s are created
//Compiler_LSS 
//LSS_CheckForSave 
//LSS_VerifyNewInventoryNumber
//Method: Object Method: [LSS_Inventory].New_InventoryItem.bValidate
//Method: Object Method: [LSS_Inventory].Edit_SIN.Button
//Method: [LSS_Inventory].Edit_SIN.VerifyButton


//Fix issue where if you delete an [LSS_Inventory] record a blank row was displayed and LSS_InventoryRow_L could be greater than records in selection
// Method: Object Method: [LSS_Inventory];"ListBoxOuput".List Box
//Method: Object Method: [LSS_Inventory].Input.bDelete

//**********`Modified by: Costas Manousakis-(Designer)-(3/27/18)
// Modified Forms : 
// [LSS_Inventory];"Edit_SIN"
//  `fixed min and max numbers for kilo and mile points
// [LSS_Inventory];"New_InventoryItem"
//  `fixed min and max numbers for kilo and mile points




//End Mods_2018_03_bug