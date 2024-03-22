//%attributes = {"invisible":true}
If (False:C215)
	P_ListSpecialReports
	
	Mods_2006_CM04
End if 

C_LONGINT:C283($Lpid)
$Lpid:=LSpawnProcess("P_ListSpecialReports"; <>LStackSize; "SpecialReports"; True:C214; False:C215)