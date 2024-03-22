//%attributes = {"invisible":true}

//Load data for Conslt Rating

C_LONGINT:C283($Lpid)
If (False:C215)
	P_ListContracts
End if 
$Lpid:=LSpawnProcess("P_ListContracts"; <>LStackSize; "Contracts"; True:C214; False:C215)