Case of 
	: (Form event code:C388=On Clicked:K2:4)
		FORM SET INPUT:C55([InventoryPhotos:113]; "Input")
		ADD RECORD:C56([InventoryPhotos:113]; *)
		INV_CreatePhotosList
End case 