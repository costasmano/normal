C_DATE:C307(vDate)
C_TEXT:C284(vAttention; vCityStateZip)  // Command Replaced was o_C_STRING length was 100

vDate:=Current date:C33(*)
If (Form event code:C388=On Printing Detail:K2:18)
	vAttention:=[Town Address:78]ContactFName:8+" "+[Town Address:78]ContactMName:10+" "+[Town Address:78]ContactLName:9
	If ([Town Address:78]ContactTitle:11#"")
		vAttention:=vAttention+", "+[Town Address:78]ContactTitle:11
	End if 
	vCityStateZip:=[Town Address:78]TownName:2+", "+[Town Address:78]State:6+" "+[Town Address:78]Zip:7
End if 
