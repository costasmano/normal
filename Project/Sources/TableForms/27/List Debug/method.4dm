Case of 
	: ((Form event code:C388=On Display Detail:K2:22) | (Form event code:C388=On Printing Detail:K2:18))
		C_LONGINT:C283(vElmtSize; vPicSize; vInspSize)
		vElmtSize:=fElmtStorage
		vPicSize:=fPictStorage
		vInspSize:=vElmtSize+vPicSize+BLOB size:C605([Inspections:27]InspComments:171)
End case 