//[NBIS Secondary];"2nd In"
//Popupmenu for Item 20

POPUPMENUC(->aItem20des_; ->aItem20_; ->[NBIS Secondary:3]Item20:17)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[NBIS Secondary:3]Item20:17)
End if 
