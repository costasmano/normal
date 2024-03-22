//%attributes = {"invisible":true}

//Load data for Bridge Design

C_LONGINT:C283($Lpid)

If (False:C215)
	P_ListBridgeDesign
End if 
$Lpid:=LSpawnProcess("P_ListBridgeDesign"; <>LStackSize; "Bridge Design"; True:C214; False:C215)