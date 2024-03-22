//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 43b

C_TEXT:C284(item43b)  // Command Replaced was o_C_STRING length was 2//This must not be a local variable!

item43b:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)
POPUPMENUC(->aItem43bDes; ->aItem43b; ->item43b)
If (Form event code:C388=On Clicked:K2:4)
	[Bridge MHD NBIS:1]Item43:75:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 1; 1)+item43b
	PushChange(1; ->[Bridge MHD NBIS:1]Item43:75)
End if 
