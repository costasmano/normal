//%attributes = {"invisible":true}
If (False:C215)
	//by: Susie Hwang
	//created: 4/21/2006
	//purpose: Creates a process for making bridge scour reports
	//Mods_2006_SH01 
End if 

C_LONGINT:C283($Lpid)
If (False:C215)
	P_ScourReport
End if 

$Lpid:=LSpawnProcess("P_ScourReport"; <>LStackSize; "Scour Report"; True:C214; False:C215)