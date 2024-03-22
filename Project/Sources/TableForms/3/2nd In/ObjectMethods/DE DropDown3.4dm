//[NBIS Secondary]Item102
//Popupmenu for Item 102

POPUPMENUC(->aItem102Des; ->aItem102; ->[NBIS Secondary:3]Item102:30)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[NBIS Secondary:3]Item102:30)
End if 