//[NBIS Secondary];"2nd In"
//Popupmenu for Item 42A

C_TEXT:C284(item42a)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!

item42a:=Substring:C12([NBIS Secondary:3]Item42:23; 1; 1)
POPUPMENUC(->aItem42aDes; ->aItem42a; ->item42a)
If (Form event code:C388=On Clicked:K2:4)
	[NBIS Secondary:3]Item42:23:=item42a+Substring:C12([NBIS Secondary:3]Item42:23; 2)
	PushChange(1; ->[NBIS Secondary:3]Item42:23)
End if 
