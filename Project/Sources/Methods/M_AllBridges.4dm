//%attributes = {"invisible":true}
If (False:C215)
	//GP M_AllBridges
	//Copyright © 1997,  Thomas D. Nee, All Rights Reserved.
	//Load data for All Bridge inspections
	
	P_AllBridges
	
End if 
C_LONGINT:C283($Lpid)

$Lpid:=LSpawnProcess("P_AllBridges"; <>LStackSize; "All Bridges"; True:C214; False:C215)