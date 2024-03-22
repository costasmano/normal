//[Conslt Address]"Conslt Address In".btnDelete
If (Form event code:C388=On Clicked:K2:4)
	If (Not:C34(Is new record:C668([Conslt Address:77])))
		LogDeletion(->[Conslt Address:77]ConsltAddressID:1; ->[Conslt Address:77]ConsltAddressID:1; ->[Conslt Address:77]ConsltAddressID:1; 1)
	End if 
End if 