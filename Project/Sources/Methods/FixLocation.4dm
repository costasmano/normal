//%attributes = {"invisible":true}
If (False:C215)
	//procedure: FixLocation
	//by: Albert Leung
	//created: 11/19/97
	//purpose: Fix Town Name, Item 2, Item 3, Item 4 assuming BDEPT is correct
	//in current selection
End if 

C_LONGINT:C283($i)

MessageNM("Loading Item 2, Item 3, Item 4, Town Name…")

ARRAY TEXT:C222($abdept; 0)  //Command Replaced was o_ARRAY string length was 6
ARRAY TEXT:C222($aTownName; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222($aItem2; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222($aItem3; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($aItem4; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222($aRPC; 0)  //Command Replaced was o_ARRAY string length was 4

SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BDEPT:1; $abdept; [Bridge MHD NBIS:1]Town Name:175; $aTownName)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item2:60; $aItem2; [Bridge MHD NBIS:1]Item3:61; $aItem3)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item4:62; $aItem4; [Bridge MHD NBIS:1]RPC_Codes:183; $aRPC)

For ($i; 1; Records in selection:C76([Bridge MHD NBIS:1]))
	$aTownName{$i}:=Get_Town_Name($abdept{$i})
	$aItem2{$i}:=Get_District($abdept{$i})
	$aItem3{$i}:=Get_County($abdept{$i})
	$aItem4{$i}:=Get_Place($abdept{$i})
	$aRPC{$i}:=Get_RPCCode($abdept{$i})
End for 

CLOSE WINDOW:C154
MessageNM("Saving changes…")

START TRANSACTION:C239

ARRAY TO SELECTION:C261($aTownName; [Bridge MHD NBIS:1]Town Name:175; $aItem2; [Bridge MHD NBIS:1]Item2:60)
ARRAY TO SELECTION:C261($aItem3; [Bridge MHD NBIS:1]Item3:61; $aItem4; [Bridge MHD NBIS:1]Item4:62; $aRPC; [Bridge MHD NBIS:1]RPC_Codes:183)

CLOSE WINDOW:C154

If (Records in set:C195("LockedSet")=0)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
	ALERT:C41("Some records were in use. Changes not saved!")
End if 

ARRAY TEXT:C222($aTownName; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222($aItem2; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222($aItem3; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($aItem4; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222($aRPC; 0)  //Command Replaced was o_ARRAY string length was 4