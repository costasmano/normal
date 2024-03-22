If ([NTI_ELEM_BIN_INSP:183]ELEM_KEY:3>0)
	NTI_OpenHelpWindow([NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
Else 
	ALERT:C41("An Element has not been selected yet!")
End if 
