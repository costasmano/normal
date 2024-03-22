//bCaclAASHTO
CONFIRM:C162("Recalculate AASHTO?")
If (Ok=1)
	[Bridge MHD NBIS:1]AASHTO:5:=AASHTO_SuffRat
End if 