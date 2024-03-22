//[NBIS Secondary];"2nd In"
//Popupmenu for Item 43b

C_TEXT:C284(item43b)  // Command Replaced was o_C_STRING length was 2//This must not be a local variable!

item43b:=Substring:C12([NBIS Secondary:3]Item43:24; 2; 2)
POPUPMENUC(->aItem43bDes; ->aItem43b; ->item43b)
If (Form event code:C388=On Clicked:K2:4)
	[NBIS Secondary:3]Item43:24:=Substring:C12([NBIS Secondary:3]Item43:24; 1; 1)+item43b
	PushChange(1; ->[NBIS Secondary:3]Item43:24)
End if 
