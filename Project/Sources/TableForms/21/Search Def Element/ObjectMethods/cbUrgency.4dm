Case of 
	: (cbUrgency=0)
		OBJECT SET ENABLED:C1123(cboUrgOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(cboUrgency; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "Urgency"; False:C215)
	: (cbUrgency=1)
		OBJECT SET ENABLED:C1123(cboUrgOp; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(cboUrgency; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "Urgency"; True:C214)
End case 
