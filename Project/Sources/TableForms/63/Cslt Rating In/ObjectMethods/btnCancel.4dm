If (Form event code:C388=On Clicked:K2:4)
	If (Is new record:C668([Conslt Rating:63]))
		DELETE RECORD:C58([Conslt Rating Cost:74])
		vbNewRtgRec:=False:C215
	End if 
End if 