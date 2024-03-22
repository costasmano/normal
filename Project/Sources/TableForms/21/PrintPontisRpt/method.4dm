Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(vlDlgWID)
		vlDlgWID:=Frontmost window:C447
	: (Form event code:C388=On Deactivate:K2:10)
		BRING TO FRONT:C326(Current process:C322)
		SHOW WINDOW:C435(vlDlgWID)
End case 