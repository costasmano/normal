//%attributes = {"invisible":true}
If (False:C215)
	//procedure: FixItem70
	//purpose: Item 70 is less than 5 because of the 0.9 * 0.7 conversion
	//created: 3/11/99
	//by: Albert Leung
End if 

If (False:C215)
	C_LONGINT:C283($recnum; $i)
	
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214; *)
	QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item41:141="A"; *)
	QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item70:140<"5")
	//SEARCH([Bridge MHD NBIS]; & [Bridge MHD NBIS]PostingStatus="EJDMNT")
	
	//update InvHS and OprHS and Item 64, and Item 66
	ARRAY REAL:C219($aItem64; 0)
	ARRAY REAL:C219($aItem66; 0)
	ARRAY REAL:C219($aInvHS; 0)
	ARRAY REAL:C219($aOprHS; 0)
	ARRAY REAL:C219($aOpr3S2; 0)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item64:137; $aItem64)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item66:139; $aItem66)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]InvHS:22; $aInvHS)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]OprHS:18; $aOprHS)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Opr3S2:17; $aOpr3S2)
	
	$recnum:=Records in selection:C76([Bridge MHD NBIS:1])
	
	For ($i; 1; $recnum)
		If ($aInvHS{$i}=0)
			$aInvHS{$i}:=36
			$aItem66{$i}:=36*0.9
		End if 
		If ($aOprHS{$i}=0)
			$aOprHS{$i}:=49
			$aItem64{$i}:=49*0.9
		End if 
		If ($aOpr3S2{$i}>=36)
			$aItem64{$i}:=[Bridge MHD NBIS:1]Opr3S2:17*0.9
		End if 
	End for 
	
	START TRANSACTION:C239
	
	ARRAY TO SELECTION:C261($aItem64; [Bridge MHD NBIS:1]Item64:137)
	ARRAY TO SELECTION:C261($aItem66; [Bridge MHD NBIS:1]Item66:139)
	ARRAY TO SELECTION:C261($aOprHS; [Bridge MHD NBIS:1]OprHS:18)
	ARRAY TO SELECTION:C261($aInvHS; [Bridge MHD NBIS:1]InvHS:22)
	ARRAY TO SELECTION:C261($aOpr3S2; [Bridge MHD NBIS:1]Opr3S2:17)
	
	If (Records in set:C195("LockedSet")=0)
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
		ALERT:C41("Some records were in use. Changes not saved!")
	End if 
End if 
