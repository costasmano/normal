
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/29/12, 14:39:41
//----------------------------------------------------
//Method: Object Method: [Bridge MHD NBIS].Bridge Input.bInventory
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CM02
	//DIALOG([Bridge MHD NBIS];"InventoryPhoto")
	Mods_2012_03  //r003 `Add code to use list box for Inventory button on 
	//Modified by: Charles Miller (3/29/12 14:11:06)
	// Modified by: Costas Manousakis-(Designer)-(5/4/12 16:10:12)
	Mods_2012_05
	//  `use SIA_NewOpenModule
End if 

SIA_NewOpenModule("InventoryPhotos"; 8)
//End Object Method: [Bridge MHD NBIS].Bridge Input.bInventory