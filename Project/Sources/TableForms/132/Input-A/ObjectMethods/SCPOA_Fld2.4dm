If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)
	Self:C308->:=f_TrimStr(Self:C308->; True:C214; True:C214)
	If (Self:C308->#"")
		SC_FTMat_known:=1
		SC_FTMat_Unknown:=0
	Else 
		SC_FTMat_known:=0
		SC_FTMat_Unknown:=1
	End if 
	
End if 