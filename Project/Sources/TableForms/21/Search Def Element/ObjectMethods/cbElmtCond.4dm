Case of 
	: (Self:C308->=0)
		OBJECT SET ENABLED:C1123(cboElmtCondOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(cboElmtCond; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "Rating"; False:C215)
		cboElmtCondOp:=0
		cboElmtCond:=0
		vElmtCondOp:=""
		
	: (Self:C308->=1)
		OBJECT SET ENABLED:C1123(cboElmtCondOp; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(cboElmtCond; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "Rating"; True:C214)
End case 
