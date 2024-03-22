//%attributes = {"invisible":true}
//GP M_OutofFreqRep
//Copyright © 1997,  Albert Leung, All Rights Reserved.
//create a process for making condition reports

C_LONGINT:C283($Lpid)
If (False:C215)
	P_OutofFreqRep
End if 

$Lpid:=LSpawnProcess("P_OutofFreqRep"; <>LStackSize; "OOF Report"; True:C214; False:C215)