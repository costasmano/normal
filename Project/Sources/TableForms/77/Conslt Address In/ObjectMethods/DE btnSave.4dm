//[Conslt Address]"Conslt Address In".btnSave
If (Form event code:C388=On Clicked:K2:4)
	If (Is new record:C668([Conslt Address:77]))
		LogNewRecord(->[Conslt Address:77]ConsltAddressID:1; ->[Conslt Address:77]ConsltAddressID:1; ->[Conslt Address:77]ConsltAddressID:1; 4; "ConsAddress")
	End if 
End if 