//[ElementsSafety];"Safety ElmInput"
//Popupmenu for Rating

POPUPMENUC(->aRatCAT1_; ->aRatCode_; ->[ElementsSafety:29]Rating:2)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(2; ->[ElementsSafety:29]Rating:2)
End if 