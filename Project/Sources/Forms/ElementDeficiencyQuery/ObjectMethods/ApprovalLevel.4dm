Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=2
End case 

vbAnyCompleted:=(Self:C308->=1)
vInspApproved:=(Self:C308->=2)

