//LP [BMS Inspections];"BMS Insp Out"

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	pFile:=->[BMS Inspections:44]
End if 