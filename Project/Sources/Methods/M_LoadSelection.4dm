//%attributes = {"invisible":true}
//GP M_AllBridges
//Copyright © 1997,  Albert Leung, All Rights Reserved.
//Load data for All Bridge inspections

C_LONGINT:C283($Lpid)

$Lpid:=LSpawnProcess("P_LoadSelection"; <>LStackSize; "Saved Selection"; True:C214; False:C215)