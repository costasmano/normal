If ([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3>0)
	NTI_OpenHelpWindow([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
Else 
	ALERT:C41("An Element has not been selected yet!")
End if 
