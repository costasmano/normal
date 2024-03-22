//[NBIS Secondary];"2nd In"
//Popupmenu for Item 26

POPUPMENUC(->aItem26Des; ->aItem26; ->[NBIS Secondary:3]Item26:18)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[NBIS Secondary:3]Item26:18)
End if 