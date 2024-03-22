//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 108B

POPUPMENUC(->aItem108bD; ->aItem108b; ->[Bridge MHD NBIS:1]Item108B:81)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[Bridge MHD NBIS:1]Item108B:81)
End if 
