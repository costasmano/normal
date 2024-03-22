//Method: Object Method: [Bridge MHD NBIS];"Bridge Input".bAddInvInsp
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 06/20/13, 14:39:03
	//----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(4/19/2007 11:25:27)
	Mods_2007_CM07
	Mods_2012_03  //r003 `Add code to use list box for Inventory button on 
	//Modified by: Charles Miller (3/29/12 14:33:25)
	Mods_2013_06  //r001 ` 
	// Add code to alow for add, delete and duplicate 
	//[InventoryPhotoInsp] and [InventoryPhotos]
	//Modified by: Charles Miller (6/20/13 13:15:13)
	// Modified by: Costas Manousakis-(Designer)-(8/29/13 17:18:38)
	Mods_2013_08
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2022-09-15 18:20:31)
	Mods_2022_09_bug
	//  `set vsForward
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (INV_InvInspRWAccess)
			OBJECT SET ENABLED:C1123(bAddInvInsp; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(bAddInvInsp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Right click:C712) | (Macintosh control down:C544)  // Mods_2013_08
			ButtonpopupText:="Add;Duplicate;"
		Else 
			ButtonpopupText:=""
		End if 
		vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; ""; <>CurrentUser_PID)
		INSP_DuplicateInventoryPhotos
		INV_GetBINInventoryPhotos([Bridge MHD NBIS:1]BIN:3)
		UNLOAD RECORD:C212([InventoryPhotoInsp:112])
		UNLOAD RECORD:C212([InventoryPhotos:113])
		
End case 
//End Object Method: [Bridge MHD NBIS];"Bridge Input".bAddInvInsp