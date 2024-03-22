//Method: Object Method: [Bridge MHD NBIS];"Bridge Input".InventoryPhotos
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 02/21/12, 15:00:25
	//----------------------------------------------------
	Mods_2012_02  //r001
	//Modified by: Charles Miller (2/21/12 15:00:28)
	Mods_2013_06  //r001 ` Add code to alow for add, delete and duplicate 
	//[InventoryPhotoInsp] and [InventoryPhotos]
	//Modified by: Charles Miller (6/20/13 13:15:13)
	// Modified by: Costas Manousakis-(Designer)-(8/29/13 17:19:38)
	Mods_2013_08
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2022-09-15 18:18:21)
	Mods_2022_09_bug
	//  `set vsForward
End if 
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		SIA_OnDisplayDetail
		
	: (Form event code:C388=On Clicked:K2:4)
		If (INV_InvInspRWAccess)  // Mods_2013_08
			If (Right click:C712) | (Macintosh control down:C544)
				ButtonpopupText:="Add;Duplicate;"
				vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; ""; <>CurrentUser_PID)
				INSP_DuplicateInventoryPhotos
			End if 
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; ""; <>CurrentUser_PID)
		SIA_ControlDoubleClick
End case 

//End Object Method: [Bridge MHD NBIS];"Bridge Input".InventoryPhotos