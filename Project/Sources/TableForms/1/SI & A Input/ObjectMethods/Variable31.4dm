//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 108A

POPUPMENUC(->aItem108aD; ->aItem108a; ->[Bridge MHD NBIS:1]Item108A:80)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[Bridge MHD NBIS:1]Item108A:80)
End if 
