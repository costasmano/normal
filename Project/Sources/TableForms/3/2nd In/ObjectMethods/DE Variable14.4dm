//[NBIS Secondary];"2nd In"
//Popupmenu for Item 42B

C_TEXT:C284(item42b)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!

item42b:=Substring:C12([NBIS Secondary:3]Item42:23; 2; 1)
POPUPMENUC(->aItem42bDes; ->aItem42b; ->item42b)
If (Form event code:C388=On Clicked:K2:4)
	[NBIS Secondary:3]Item42:23:=Substring:C12([NBIS Secondary:3]Item42:23; 1; 1)+item42b
	PushChange(1; ->[NBIS Secondary:3]Item42:23)
End if 