//%attributes = {"invisible":true}

C_LONGINT:C283($Lpid)
If (False:C215)
	P_ListConsAddress
End if 

$Lpid:=LSpawnProcess("P_ListConsAddress"; <>LStackSize; "Conslt Address"; True:C214; False:C215)