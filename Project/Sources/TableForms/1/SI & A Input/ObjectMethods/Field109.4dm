If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(9/1/10 12:36:34)
	Mods_2010_09
	//  `Added more color changes to fields being set to editable/noneditable
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
End if 
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; Self:C308)
	If ([Bridge MHD NBIS:1]Item103:124=True:C214)
		OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item70:140; True:C214)
		OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item70:140; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // comments at the end ` **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item70;<>Color_Editable)
	Else 
		OBJECT SET ENTERABLE:C238([Bridge MHD NBIS:1]Item70:140; False:C215)
		OBJECT SET RGB COLORS:C628([Bridge MHD NBIS:1]Item70:140; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Bridge MHD NBIS]Item70;<>Color_not_editable)
	End if 
End if 