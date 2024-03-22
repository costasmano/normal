//%attributes = {"invisible":true}
//GP M_MTA
//Copyright © 1997,  Thomas D. Nee, All Rights Reserved.
//Load data for MTA Bridge inspection

C_LONGINT:C283($Lpid)

$Lpid:=LSpawnProcess("P_MTA"; <>LStackSize; "MTA"; True:C214; False:C215)