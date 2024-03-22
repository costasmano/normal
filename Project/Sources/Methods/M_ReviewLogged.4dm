//%attributes = {"invisible":true}
//GP M_Personnel
//Copyright © 1997, Albert Leung, All Rights Reserved.
//Load changes sent.

C_LONGINT:C283($Lpid)
If (False:C215)
	P_ReviewLogged
End if 

$Lpid:=LSpawnProcess("P_ReviewLogged"; <>LStackSize; "Review Changes"; True:C214; False:C215)