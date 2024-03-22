//%attributes = {"invisible":true}

C_LONGINT:C283($Lpid)
If (False:C215)
	P_ListTownAddress
End if 

$Lpid:=LSpawnProcess("P_ListTownAddress"; <>LStackSize; "Town Address"; True:C214; False:C215)