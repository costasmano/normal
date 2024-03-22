//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 42B

C_TEXT:C284(item42b)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!

item42b:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 2; 1)
POPUPMENUC(->aItem42bDes; ->aItem42b; ->item42b)
If (Form event code:C388=On Clicked:K2:4)
	[Bridge MHD NBIS:1]Item42:85:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 1; 1)+item42b
	PushChange(1; ->[Bridge MHD NBIS:1]Item42:85)
End if 