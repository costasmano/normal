If (Self:C308->=1)
	OBJECT SET ENTERABLE:C238(*; "File@"; True:C214)
	OBJECT SET ENABLED:C1123(*; "File@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	Center_chk:=0
	OBJECT SET ENTERABLE:C238(*; "Center@"; False:C215)
	OBJECT SET ENABLED:C1123(*; "OKBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
Else 
	OBJECT SET ENTERABLE:C238(*; "File@"; False:C215)
	OBJECT SET ENABLED:C1123(*; "OKBtn"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET ENABLED:C1123(*; "File@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End if 
