//[Town Address]"Town Address In".btnDelete
If (Form event code:C388=On Clicked:K2:4)
	If (Not:C34(Is new record:C668([Town Address:78])))
		LogDeletion(->[Town Address:78]TownAddressID:1; ->[Town Address:78]TownAddressID:1; ->[Town Address:78]TownAddressID:1; 1)
	End if 
End if 