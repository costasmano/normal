//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 43a

C_TEXT:C284(item43a)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!

item43a:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 1; 1)
POPUPMENUC(->aItem43aDes; ->aItem43a; ->item43a)
If (Form event code:C388=On Clicked:K2:4)
	[Bridge MHD NBIS:1]Item43:75:=item43a+Substring:C12([Bridge MHD NBIS:1]Item43:75; 2)
	PushChange(1; ->[Bridge MHD NBIS:1]Item43:75)
End if 