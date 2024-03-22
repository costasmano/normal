//%attributes = {"invisible":true}
//GP M_Personnel
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
//Load personnel data.

C_LONGINT:C283($Lpid)
If (False:C215)  //to keep Used by list.
	P_Personnel
End if 

If (User in group:C338(Current user:C182; "Personnel Admin"))
	$Lpid:=LSpawnProcess("P_Personnel"; <>LStackSize; "Personnel"; True:C214; False:C215)
Else 
	ALERT:C41("Your Password does not allow you to use this item.")
End if 