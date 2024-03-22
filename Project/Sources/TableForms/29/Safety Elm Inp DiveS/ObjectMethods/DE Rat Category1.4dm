//[ElementsSafety];"Safety ElmInput"
//Popupmenu for Prev Rating

POPUPMENUC(->aRatCAT4_; ->aRatCode_; ->[ElementsSafety:29]AltRating_i:24)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(2; ->[ElementsSafety:29]AltRating_i:24)
End if 