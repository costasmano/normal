If (f_TrimStr(PURPOSE_TXT; True:C214; True:C214)="")
	ALERT:C41("You entered a blank string!")
	PURPOSE_TXT:=""
	GOTO OBJECT:C206(*; "PURPOSE_TXT")
Else 
	OBJECT SET ENTERABLE:C238(*; "SUBCATEGORY_TXT"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "MENUNAME_TXT"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "REPORTNAME_TXT"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "LONGDESCR_TXT"; True:C214)
	OBJECT SET ENABLED:C1123(*; "SOURCEFILEbtn@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
End if 
