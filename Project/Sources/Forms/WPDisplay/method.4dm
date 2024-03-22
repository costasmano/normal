//Method: "WPDisplay"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/03/20, 19:15:10
	// ----------------------------------------------------
	//Created : 
End if 
//

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_OBJECT:C1216(INSP_Comments_WP)
		C_POINTER:C301($area_)
		C_TEXT:C284(WPDisplaymenuContext)
		$area_:=OBJECT Get pointer:C1124(Object named:K67:5; "WriteProArea")
		$area_->:=INSP_Comments_WP
		// create a contextual menu for 4D Write Pro area (See example 6)
		WPDisplaymenuContext:=Create menu:C408
		
		APPEND MENU ITEM:C411(WPDisplaymenuContext; ak copy:K76:54)
		SET MENU ITEM PROPERTY:C973(WPDisplaymenuContext; -1; Associated standard action name:K28:8; ak copy:K76:54)
		
		APPEND MENU ITEM:C411(WPDisplaymenuContext; ak select all:K76:57)
		SET MENU ITEM PROPERTY:C973(WPDisplaymenuContext; -1; Associated standard action name:K28:8; ak select all:K76:57)
		
		
	: (Form event code:C388=On Unload:K2:2)
		// release menu
		RELEASE MENU:C978(WPDisplaymenuContext)
		
End case 





//End WPDisplay