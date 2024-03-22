//%attributes = {"invisible":true}
//M_reviewInspections
//Review inspections unverified
C_LONGINT:C283($Lpid)
If (False:C215)
	P_ReviewInspcts
End if 

$Lpid:=LSpawnProcess("P_ReviewInspcts"; <>LStackSize; "Review Inspects"; True:C214; False:C215)