//[ElementsSafety];"Safety ElmInput"
//Popupmenu for Priority

POPUPMENUC(->aUORCAT_; ->aUORCode_; ->[ElementsSafety:29]Priority:20)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(2; ->[ElementsSafety:29]Priority:20)
End if 