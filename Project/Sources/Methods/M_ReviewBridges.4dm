//%attributes = {"invisible":true}
//GP M_ReviewBridges
//Copyright © 1997,  Albert Leung, All Rights Reserved.
//Load bridges being reviewed

C_LONGINT:C283($Lpid)

$Lpid:=LSpawnProcess("P_ReviewBridges"; <>LStackSize; "ReviewBridges"; True:C214; False:C215)