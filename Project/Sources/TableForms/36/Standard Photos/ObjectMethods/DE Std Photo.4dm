If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(9/15/08 11:52:19)
	Mods_2008_CM_5404  // ("IMAGESTORE")
	//Don't compress the image after it is loaded
	// Modified by: Costas Manousakis-(Designer)-(2/12/12 20:15:34)
	Mods_2012_02
	//  `Add the on After Edit event
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		SET CURSOR:C469(4)  //spinning wheel while loading
		
	: ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On After Edit:K2:43))
		PushChange(2; Self:C308)
		C_TEXT:C284(vPictStats)
		C_LONGINT:C283($vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
		PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
		vPictStats:=String:C10($vPicW)+"x"+String:C10($vPicH)+<>sCR
		vPictStats:=vPictStats+"("+String:C10(Picture size:C356([Standard Photos:36]Std Photo:3); "##,###,### Bytes")+")"
		vbPictureChanged:=True:C214
End case 