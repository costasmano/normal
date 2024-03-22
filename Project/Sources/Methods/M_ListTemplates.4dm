//%attributes = {"invisible":true}
//Load data for Work Hours Maintenace
If (False:C215)
	P_ListTemplates
	Mods_2006_CM04
End if 

C_LONGINT:C283($Lpid)
$Lpid:=LSpawnProcess("P_ListTemplates"; <>LStackSize; "4DTemplates"; True:C214; False:C215)