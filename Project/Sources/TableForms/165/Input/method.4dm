
// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 09/11/14, 16:32:09
// ----------------------------------------------------
// Method: Form Method: [LSS_Inventory];"Input"
// Description
// 
//
// Parameters
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(9/9/15 14:50:34)
	Mods_2015_09_bug
	//  `added button "Edit Tools" that shows a menu to either edit the mile point or edit the last 5 digits of the SIN number
	// Modified by: Costas Manousakis-(Designer)-(11/12/15 10:39:41)
	Mods_2015_11
	//  `increased size of  LSS_Inventory]LSS_AssetNo_txt field.
	// Modified by: Costas Manousakis-(Designer)-(10/4/18 16:25:11)
	Mods_2018_10
	//  `added dropdown for [LSS_Inventory]LSS_Owner_s
	// Modified by: Costas Manousakis-(Designer)-(2/12/19 12:13:34)
	Mods_2019_02_bug
	//  `renamed Import insp button to LSS_ImportInspection, cleared var name
	
	// Modified by: manousakisc (4/28/2023)
	Mods_2023_LSSNew
	//added status , pinfo fields, relabeled/rearranged year blt,remove,rehab info
	// changed help message for Map button
	
End if 

If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
// ----------------------------------------------------

FM_InventoryInput