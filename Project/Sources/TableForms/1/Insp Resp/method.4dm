//LP [Bridge MHD NBIS];"Insp Resp"

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	pFile:=->[Bridge MHD NBIS:1]
End if 