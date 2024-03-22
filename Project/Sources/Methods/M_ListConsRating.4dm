//%attributes = {"invisible":true}

//Load data for Conslt Rating

C_LONGINT:C283($Lpid)
If (False:C215)
	P_ListConsRating
End if 
$Lpid:=LSpawnProcess("P_ListConsRating"; <>LStackSize; "Conslt Rating"; True:C214; False:C215)