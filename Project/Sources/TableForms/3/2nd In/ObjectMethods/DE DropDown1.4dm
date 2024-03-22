//[NBIS Secondary];"2nd In"
//Popupmenu for Item 100

POPUPMENUC(->aItem100d_; ->aItem100_; ->[NBIS Secondary:3]Item100:28)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[NBIS Secondary:3]Item100:28)
End if 
