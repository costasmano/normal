//%attributes = {"invisible":true}
If (False:C215)
	//procedure: FixItem64_66
	//purpose:fix overflow in these items
	//created: 4/7/98
	//by: Albert Leung
End if 

If (False:C215)
	ARRAY REAL:C219($aItem64; 0)
	ARRAY REAL:C219($aItem66; 0)
	C_LONGINT:C283($i)
	
	MessageNM("Loading Item 64,66…")
	
	ALL RECORDS:C47([Bridge MHD NBIS:1])
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item64:137; $aItem64)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item66:139; $aItem66)
	
	For ($i; 1; Records in selection:C76([Bridge MHD NBIS:1]))
		If ($aItem64{$i}>99.9)
			$aItem64{$i}:=99.9
		End if 
		If ($aItem66{$i}>99.9)
			$aItem66{$i}:=99.9
		End if 
	End for 
	
	CLOSE WINDOW:C154
	MessageNM("Saving changes…")
	
	START TRANSACTION:C239
	
	ARRAY TO SELECTION:C261($aItem64; [Bridge MHD NBIS:1]Item64:137)
	ARRAY TO SELECTION:C261($aItem66; [Bridge MHD NBIS:1]Item66:139)
	
	CLOSE WINDOW:C154
	
	If (Records in set:C195("LockedSet")=0)
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
		ALERT:C41("Some records were in use. Changes not saved!")
	End if 
End if 
