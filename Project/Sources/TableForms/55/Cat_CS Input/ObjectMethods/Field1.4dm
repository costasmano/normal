//SC Category ID on layout [Cat CS Notes];"Cat_CS Input"

If (Form event code:C388=On Load:K2:1) & ([Cat CS Notes:55]Category ID:1=0)
	[Cat CS Notes:55]Category ID:1:=[BMS Categories:49]Category ID:1
End if 