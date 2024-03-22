If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Clicked:K2:4)
	Case of 
		: (Self:C308->=0)
			OBJECT SET ENABLED:C1123(cboElmtQtyOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENTERABLE:C238(vrSearchElmtQty; False:C215)
			cboElmtQtyOp:=0
			vrSearchElmtQty:=-1
			vElmtQtyOp:=""
			
		: (Self:C308->=1)
			OBJECT SET ENABLED:C1123(cboElmtQtyOp; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENTERABLE:C238(vrSearchElmtQty; True:C214)
			If (vrSearchElmtQty<0)
				vrSearchElmtQty:=0
			End if 
	End case 
End if 
