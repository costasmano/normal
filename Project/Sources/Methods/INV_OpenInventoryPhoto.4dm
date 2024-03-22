//%attributes = {"invisible":true}
//Method: INV_OpenInventoryPhoto
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 08/15/17, 15:37:09
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08_bug
	// Modified by: Costas Manousakis-(Designer)-(6/21/18 15:34:27)
	Mods_2018_06_bug
	//  `make sure photo table is in RW mode before modifying it - it gets set to RO in the form method if INV_InventInspLocked
	// Modified by: Costas Manousakis-(Designer)-(2023-10-27 16:55:25)
	Mods_2023_10
	//  `removed clear set("userset") - not needed -caused errors when trying to use UserSet later when adding BINs
End if 
//
If (Not:C34(InDoubleClick_B))
	InDoubleClick_B:=True:C214
	C_BOOLEAN:C305(INV_InventInspLocked)
	FORM SET INPUT:C55([InventoryPhotos:113]; "Input")
	C_LONGINT:C283($LBCol_L; $LBRow_L)
	LISTBOX GET CELL POSITION:C971(*; "InventoyPhotos_LB"; $LBCol_L; $LBRow_L)
	If ($LBRow_L>0)
		
		GOTO SELECTED RECORD:C245([InventoryPhotos:113]; $LBRow_L)
		
		If (Read only state:C362([InventoryPhotos:113]))
			UNLOAD RECORD:C212([InventoryPhotos:113])
			READ WRITE:C146([InventoryPhotos:113])
			LOAD RECORD:C52([InventoryPhotos:113])
		End if 
		MODIFY RECORD:C57([InventoryPhotos:113])
		LISTBOX SELECT ROW:C912(*; "InventoyPhotos_LB"; 0; lk remove from selection:K53:3)
		//CLEAR SET("UserSet") // Start of Mods_2023_10
		REDRAW:C174(SelectListBox)
		INV_CreatePhotosList
		
	Else 
		If (Not:C34(INV_InventInspLocked))
			ADD RECORD:C56([InventoryPhotos:113]; *)
			INV_CreatePhotosList
		End if 
	End if 
	InDoubleClick_B:=False:C215
End if 

//End INV_OpenInventoryPhoto