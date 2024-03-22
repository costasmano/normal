If ([PON_ELEM_INSP:179]ELEM_KEY:3>0)
	PON_OpenHelpWindow([PON_ELEM_INSP:179]ELEM_KEY:3)
Else 
	ALERT:C41("An Element has not been selected yet!")
End if 
