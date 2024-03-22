//%attributes = {"invisible":true}
If (False:C215)
	//procedure: Init64_66
	//purpose:initialize according to DESIGN designation
	//created: 2/12/98
	//by: Albert Leung
End if 
If (False:C215)
	
	ARRAY TEXT:C222($aItem63; 0)  //Command Replaced was o_ARRAY string length was 1
	ARRAY TEXT:C222($aItem65; 0)  //Command Replaced was o_ARRAY string length was 1
	ARRAY TEXT:C222($aPostStat; 0)  //Command Replaced was o_ARRAY string length was 6
	ARRAY REAL:C219($aItem64; 0)
	ARRAY REAL:C219($aItem66; 0)
	ARRAY REAL:C219($aOprH20; 0)
	ARRAY REAL:C219($aOprType3; 0)
	ARRAY REAL:C219($aOpr3S2; 0)
	ARRAY REAL:C219($aOprHS; 0)
	ARRAY REAL:C219($aInvH20; 0)
	ARRAY REAL:C219($aInvType3; 0)
	ARRAY REAL:C219($aInv3S2; 0)
	ARRAY REAL:C219($aInvHS; 0)
	
	C_LONGINT:C283($i)
	
	MessageNM("Loading Item 63,64,65,66,Loads…")
	
	ALL RECORDS:C47([Bridge MHD NBIS:1])
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]PostingStatus:8="DESIGN")
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]PostingStatus:8; $aPostStat)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item 63:199; $aItem63)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item 65:200; $aItem65)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item64:137; $aItem64)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item66:139; $aItem66)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]OprH20:15; $aOprH20)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]OprType3:16; $aOprType3)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Opr3S2:17; $aOpr3S2)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]OprHS:18; $aOprHS)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]InvH20:19; $aInvH20)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]InvType3:20; $aInvType3)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Inv3S2:21; $aInv3S2)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]InvHS:22; $aInvHS)
	
	For ($i; 1; Records in selection:C76([Bridge MHD NBIS:1]))
		$aItem63{$i}:="5"
		$aItem65{$i}:="5"
		$aItem64{$i}:=44.1
		$aItem66{$i}:=32.4
		$aOprH20{$i}:=27
		$aOprType3{$i}:=34
		$aOpr3S2{$i}:=49
		$aOprHS{$i}:=49
		$aInvH20{$i}:=20
		$aInvType3{$i}:=25
		$aInv3S2{$i}:=36
		$aInvHS{$i}:=36
	End for 
	
	CLOSE WINDOW:C154
	MessageNM("Saving changes…")
	
	START TRANSACTION:C239
	
	ARRAY TO SELECTION:C261($aItem63; [Bridge MHD NBIS:1]Item 63:199)
	ARRAY TO SELECTION:C261($aItem65; [Bridge MHD NBIS:1]Item 65:200)
	ARRAY TO SELECTION:C261($aItem64; [Bridge MHD NBIS:1]Item64:137)
	ARRAY TO SELECTION:C261($aItem66; [Bridge MHD NBIS:1]Item66:139)
	ARRAY TO SELECTION:C261($aOprH20; [Bridge MHD NBIS:1]OprH20:15)
	ARRAY TO SELECTION:C261($aOprType3; [Bridge MHD NBIS:1]OprType3:16)
	ARRAY TO SELECTION:C261($aOpr3S2; [Bridge MHD NBIS:1]Opr3S2:17)
	ARRAY TO SELECTION:C261($aOprHS; [Bridge MHD NBIS:1]OprHS:18)
	ARRAY TO SELECTION:C261($aInvH20; [Bridge MHD NBIS:1]InvH20:19)
	ARRAY TO SELECTION:C261($aInvType3; [Bridge MHD NBIS:1]InvType3:20)
	ARRAY TO SELECTION:C261($aInv3S2; [Bridge MHD NBIS:1]Inv3S2:21)
	ARRAY TO SELECTION:C261($aInvHS; [Bridge MHD NBIS:1]InvHS:22)
	
	CLOSE WINDOW:C154
	
	If (Records in set:C195("LockedSet")=0)
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
		ALERT:C41("Some records were in use. Changes not saved!")
	End if 
End if 
