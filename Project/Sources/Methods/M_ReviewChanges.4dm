//%attributes = {"invisible":true}
//GP M_ReviewChanges
//Copyright © 1997, Albert Leung, All Rights Reserved.
//Load changes.

C_LONGINT:C283($Lpid)
If (False:C215)
	P_ReviewChanges
End if 

$Lpid:=LSpawnProcess("P_ReviewChanges"; <>LStackSize; "Review Changes"; True:C214; False:C215)