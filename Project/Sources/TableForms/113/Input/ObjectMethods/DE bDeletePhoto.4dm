Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($msg)
		If ([InventoryPhotos:113]PhotoDescr_txt:3#"")
			$Msg:="Delete photo "+<>sQU+[InventoryPhotos:113]PhotoDescr_txt:3+<>sQU+" ?"
		Else 
			$Msg:="Delete this photo ?"
		End if 
		
		CONFIRM:C162($Msg; "Delete")
		If (OK=1)
			If (Not:C34(Is new record:C668([InventoryPhotos:113])))
				LogDeletion(->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhoto_ID:1; 2)
				DELETE RECORD:C58([InventoryPhotos:113])
			End if 
			CANCEL:C270
		End if 
End case 
