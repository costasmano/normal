//[NBIS Secondary];"2nd In"
//Popupmenu for Item 101

POPUPMENUC(->aItem101d_; ->aItem101_; ->[NBIS Secondary:3]Item101:29)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[NBIS Secondary:3]Item101:29)
End if 
