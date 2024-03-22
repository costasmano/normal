//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 108C

POPUPMENUC(->aItem108cD; ->aItem108c; ->[Bridge MHD NBIS:1]Item108C:82)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[Bridge MHD NBIS:1]Item108C:82)
End if 
