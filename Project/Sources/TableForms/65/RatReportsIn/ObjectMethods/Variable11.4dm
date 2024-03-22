//[RatingReports];"RatReportsIn"
//Popupmenu for Rating File Type

POPUPMENUC(->aRatingFT_; ->aRatingFT_; ->[RatingReports:65]DataFileType:32)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(2; ->[RatingReports:65]DataFileType:32)
End if 