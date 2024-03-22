//%attributes = {"invisible":true}
//GP M_CondRep
//Copyright © 1997,  Albert Leung, All Rights Reserved.
//create a process for making condition reports

C_LONGINT:C283($Lpid)
If (False:C215)
	P_CondRep
End if 

$Lpid:=LSpawnProcess("P_CondRep"; <>LStackSize; "ConditionReport"; True:C214; False:C215)