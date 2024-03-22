If (False:C215)
	//Object Method: [InventoryPhotos];"Input".DE_InvPhoto
	
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(3/20/17 16:52:16)
	Mods_2017_03
	//  `added on after edit for the picture var because contextual menu was enabled
End if 
C_BOOLEAN:C305(vbPictureChanged)
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_PICTURE:C286(DE_InvPhoto)
		If (BLOB size:C605([InventoryPhotos:113]InvPhoto_X:4)>0)
			BLOB TO PICTURE:C682([InventoryPhotos:113]InvPhoto_X:4; DE_InvPhoto)
		Else 
			DE_InvPhoto:=DE_InvPhoto*0
		End if 
		C_TEXT:C284(vPictStats)
		C_LONGINT:C283($vPicHoff; $vPicVoff; $vPicmode; $vPicW; $vPicH)
		PICTURE PROPERTIES:C457(DE_InvPhoto; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
		vPictStats:=String:C10($vPicW)+"x"+String:C10($vPicH)+<>sCR
		vPictStats:=vPictStats+"("+String:C10(Picture size:C356(DE_InvPhoto); "##,###,### Bytes")+")"
		vbPictureChanged:=False:C215
	: ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On After Edit:K2:43))
		//PICTURE TO BLOB(DE_InvPhoto;[InventoryPhotos]InvPhoto;"jpeg")
		PICTURE PROPERTIES:C457(DE_InvPhoto; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
		vbPictureChanged:=True:C214
		vPictStats:=String:C10($vPicW)+"x"+String:C10($vPicH)+<>sCR
		vPictStats:=vPictStats+"("+String:C10(Picture size:C356(DE_InvPhoto); "##,###,### Bytes")+")"
	: (Form event code:C388=On Clicked:K2:4)
		
	: (Form event code:C388=On Drag Over:K2:13)
		//_O_DRAG AND DROP PROPERTIES(SrcObject; SrcElement; scrProcess)
		
	: (Form event code:C388=On Drop:K2:12)
		
End case 
