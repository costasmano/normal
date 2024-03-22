//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 42A

C_TEXT:C284(item42a)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!

item42a:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 1; 1)
POPUPMENUC(->aItem42aDes; ->aItem42a; ->item42a)
If (Form event code:C388=On Clicked:K2:4)
	[Bridge MHD NBIS:1]Item42:85:=item42a+Substring:C12([Bridge MHD NBIS:1]Item42:85; 2)
	PushChange(1; ->[Bridge MHD NBIS:1]Item42:85)
End if 
