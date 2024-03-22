If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Clicked:K2:4)
	Case of 
		: (cbPonElementCat=0)
			SRC_ResetForm_Pontis
		: (cbPonElementCat=1)
			OBJECT SET ENABLED:C1123(cboPontisElemCat; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(cboPontisElem; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	End case 
End if 