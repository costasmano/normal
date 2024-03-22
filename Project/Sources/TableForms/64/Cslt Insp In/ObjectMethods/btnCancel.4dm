If (Form event code:C388=On Clicked:K2:4)
	If (Is new record:C668([Cons Inspection:64]))
		DELETE RECORD:C58([Cons Inspection Cost:76])
		vbNewInspRec:=False:C215
	End if 
End if 