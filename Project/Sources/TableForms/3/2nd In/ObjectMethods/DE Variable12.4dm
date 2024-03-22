//[NBIS Secondary];"2nd In"
//Popupmenu for Item 43a

C_TEXT:C284(item43a)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!

item43a:=Substring:C12([NBIS Secondary:3]Item43:24; 1; 1)
POPUPMENUC(->aItem43aDes; ->aItem43a; ->item43a)
If (Form event code:C388=On Clicked:K2:4)
	[NBIS Secondary:3]Item43:24:=item43a+Substring:C12([NBIS Secondary:3]Item43:24; 2)
	PushChange(1; ->[NBIS Secondary:3]Item43:24)
End if 