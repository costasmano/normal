//Method: [Bridge MHD NBIS];"Bridge Input".InvImport
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/01/18, 15:16:35
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11  //ADD ability to export and then import
	//[InventoryPhotos]
	//Modified by: Chuck Miller (11/1/18 16:05:50)
	// Modified by: Costas Manousakis-(Designer)-(2022-09-15 18:20:31)
	Mods_2022_09_bug
	//  `set vsForward
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET VISIBLE:C603(*; "InvImport"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "InvImport"; False:C215)
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; ""; <>CurrentUser_PID)
		INSP_ImportInventoryPhotos
		
End case 

//End   //Method: [Bridge MHD NBIS];"Bridge Input".InvImport