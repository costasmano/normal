//[Town Address]"Town Address In".btnSave
If (Form event code:C388=On Clicked:K2:4)
	If (Is new record:C668([Town Address:78]))
		LogNewRecord(->[Town Address:78]TownAddressID:1; ->[Town Address:78]TownAddressID:1; ->[Town Address:78]TownAddressID:1; 4; "TownAddress")
	End if 
End if 