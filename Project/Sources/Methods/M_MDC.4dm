//%attributes = {"invisible":true}
//GP M_MDC
//Copyright © 1997,  Thomas D. Nee, All Rights Reserved.
//Load data for MDC Bridge inspection
If (False:C215)
	Mods_2005_CM12
End if 

C_LONGINT:C283($Lpid)

$Lpid:=LSpawnProcess("P_MDC"; <>LStackSize; "DCR"; True:C214; False:C215)