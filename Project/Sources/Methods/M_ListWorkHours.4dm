//%attributes = {"invisible":true}
//Load data for Work Hours Maintenace
If (False:C215)
	P_ListWorkHours
End if 

C_LONGINT:C283($Lpid)
$Lpid:=LSpawnProcess("P_ListWorkHours"; <>LStackSize; "WorkHours"; True:C214; False:C215)