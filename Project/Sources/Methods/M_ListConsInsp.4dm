//%attributes = {"invisible":true}

//Load data for Cons Inspection

C_LONGINT:C283($Lpid)
If (False:C215)
	P_ListConsInsp
End if 

$Lpid:=LSpawnProcess("P_ListConsInsp"; <>LStackSize; "Conslt Insp"; True:C214; False:C215)