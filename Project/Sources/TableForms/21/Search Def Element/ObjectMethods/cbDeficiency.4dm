Case of 
	: (cbDeficiency=0)
		OBJECT SET ENABLED:C1123(cboDefOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(cboDeficiency; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "Deficiency"; False:C215)
	: (cbDeficiency=1)
		OBJECT SET ENABLED:C1123(cboDefOp; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(cboDeficiency; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "Deficiency"; True:C214)
End case 