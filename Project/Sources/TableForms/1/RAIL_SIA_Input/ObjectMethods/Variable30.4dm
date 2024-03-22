//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 44a

C_TEXT:C284(item44a)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!

item44a:=Substring:C12([Bridge MHD NBIS:1]Item44:76; 1; 1)
POPUPMENUC(->aItem44aDes; ->aItem44a; ->item44a)
If (Form event code:C388=On Clicked:K2:4)
	[Bridge MHD NBIS:1]Item44:76:=item44a+Substring:C12([Bridge MHD NBIS:1]Item44:76; 2)
	PushChange(1; ->[Bridge MHD NBIS:1]Item44:76)
End if 
