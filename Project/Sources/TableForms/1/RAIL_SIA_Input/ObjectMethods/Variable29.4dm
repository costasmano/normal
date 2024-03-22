//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 107

POPUPMENUC(->aItem107Des; ->aItem107; ->[Bridge MHD NBIS:1]Item107:79)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[Bridge MHD NBIS:1]Item107:79)
End if 