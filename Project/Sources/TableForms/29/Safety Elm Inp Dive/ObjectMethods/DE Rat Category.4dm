//[ElementsSafety];"Safety ElmInput"
//Popupmenu for AltRating

POPUPMENUC(->aRatCAT3_; ->aRatCode_; ->[ElementsSafety:29]AltRating:21)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(2; ->[ElementsSafety:29]AltRating:21)
End if 