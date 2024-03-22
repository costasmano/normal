If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/10/06, 20:48:24
	// ----------------------------------------------------
	// Method: Form Method: Input
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM02
	// Modified by: Costas Manousakis-(Designer)-(3/20/17 16:53:54)
	Mods_2017_03
	//  `enabled contextual menu on picture variable - enabled on after edit event on picture variable
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		INV_SetHelpMsg_Photo
		C_PICTURE:C286(DE_InvPhoto)
		InitChangeStack(2)
		If (Is new record:C668([InventoryPhotos:113]))
			[InventoryPhotos:113]InvPhotoInsp_ID:2:=[InventoryPhotoInsp:112]InvPhotoInspID_L:1
			Inc_Sequence("InventoryPhoto"; ->[InventoryPhotos:113]InvPhoto_ID:1)
			[InventoryPhotos:113]Sequence_I:5:=5
			PushChange(2; ->[InventoryPhotos:113]Sequence_I:5)
		End if 
		
		If (BLOB size:C605([InventoryPhotos:113]InvPhoto_X:4)>0)
			BLOB TO PICTURE:C682([InventoryPhotos:113]InvPhoto_X:4; DE_InvPhoto)
		Else 
			DE_InvPhoto:=DE_InvPhoto*0
		End if 
		INV_LockUnLockCurrRec(INV_InventInspLocked; Current form table:C627)
		If (INV_InventInspLocked)
			//READ ONLY([InventoryPhotos])
		Else 
			Case of 
				: ([InventoryPhotos:113]Sequence_I:5<=4)
					OBJECT SET ENABLED:C1123(*; "DE bDeletePhoto@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
					//MOVE OBJECT(bDeletePhoto;0;0;1;1;*)
					OBJECT SET ENTERABLE:C238(*; "DE PhotoDescr_txt"; False:C215)
					OBJECT SET RGB COLORS:C628(*; "DE PhotoDescr_txt"; Col_paletteToRGB(Abs:C99(<>Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE PhotoDescr_txt"; <>Color_Not_editable)
				: ([InventoryPhotos:113]Sequence_I:5>4)
					OBJECT SET ENTERABLE:C238(*; "DE PhotoDescr_txt"; True:C214)
					OBJECT SET ENABLED:C1123(bDeletePhoto; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				Else 
					OBJECT SET ENTERABLE:C238(*; "DE PhotoDescr_txt"; True:C214)
					OBJECT SET ENABLED:C1123(bDeletePhoto; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			End case 
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		
	: (Form event code:C388=On Unload:K2:2)
		DE_InvPhoto:=DE_InvPhoto*0
		INV_SetHelpMsg_Insp
End case 