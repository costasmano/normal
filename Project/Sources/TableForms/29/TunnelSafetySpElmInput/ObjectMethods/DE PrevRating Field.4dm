If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/23/15 11:00:19)
End if 
If (Form event code:C388=On Data Change:K2:15)
	PushChange(2; Self:C308)
	POPUPMENUC(->aRatCAT2_; ->aRatCode_; Self:C308)
End if 

