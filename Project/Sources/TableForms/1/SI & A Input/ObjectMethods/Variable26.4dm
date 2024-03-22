//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 44b

C_TEXT:C284(item44b)  // Command Replaced was o_C_STRING length was 2//This must not be a local variable!

item44b:=Substring:C12([Bridge MHD NBIS:1]Item44:76; 2; 2)
POPUPMENUC(->aItem44bDes; ->aItem44b; ->item44b)
If (Form event code:C388=On Clicked:K2:4)
	[Bridge MHD NBIS:1]Item44:76:=Substring:C12([Bridge MHD NBIS:1]Item44:76; 1; 1)+item44b
	PushChange(1; ->[Bridge MHD NBIS:1]Item44:76)
End if 
