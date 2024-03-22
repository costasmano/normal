//%attributes = {"invisible":true}
If (False:C215)
	C_TEXT:C284($vsPersID_old; $vsPersID_new)  // Command Replaced was o_C_STRING length was 12
	C_LONGINT:C283($vlPersID_old; $vlPersID_new; $viFoundOld; $viFoundNew)
	$vsPersID_old:=Request:C163("Enter old Pers ID num")
	$vsPersID_new:=Request:C163("Enter new Pers ID Num")
	$vlPersID_old:=Num:C11($vsPersID_old)
	$vlPersID_new:=Num:C11($vsPersID_new)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $viFoundOld)
	QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=$vlPersID_old)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $viFoundnew)
	QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=$vlPersID_new)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	Case of 
		: ($viFoundOld<1)
			ALERT:C41("Old user ID "+$vsPersID_old+" NOT FOUND")
		: ($viFoundnew<1)
			ALERT:C41("New user ID "+$vsPersID_new+" NOT FOUND")
		Else 
			QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Person ID:2=$vlPersID_old)
			$viFoundOld:=Records in selection:C76([BMS Field Trip:56])
			If ($viFoundOld>0)
				C_TEXT:C284($msg)
				$msg:="Change "+String:C10($viFoundOld)+" records to ID "+$vsPersID_new
				CONFIRM:C162($msg; "Replace?"; "Keep")
				If (OK=1)
					APPLY TO SELECTION:C70([BMS Field Trip:56]; [BMS Field Trip:56]Person ID:2:=$vlPersID_new)
				End if 
			End if 
			CONFIRM:C162("User ID "+$vsPersID_old+"Not found any more in Field trip!"; "Delete?"; "Keep")
			If (OK=1)
				QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=$vlPersID_old)
				DELETE RECORD:C58([Personnel:42])
			End if 
			
	End case 
	CONFIRM:C162("Clean up BMS Field trip from undefined person ids?"; "Clean"; "Nope")
	If (OK=1)
		ALL RECORDS:C47([Personnel:42])
		SELECTION TO ARRAY:C260([Personnel:42]Person ID:1; alAllIDs)
		QUERY WITH ARRAY:C644([BMS Field Trip:56]Person ID:2; alAllIDs)
		CREATE SET:C116([BMS Field Trip:56]; "$FieldTripMatches")
		ALL RECORDS:C47([BMS Field Trip:56])
		CREATE SET:C116([BMS Field Trip:56]; "$FieldTripAll")
		DIFFERENCE:C122("$FieldTripAll"; "$FieldTripMatches"; "$FieldTripNoMatch")
		CLEAR SET:C117("$FieldTripAll")
		CLEAR SET:C117("$FieldTripMatches")
		$viFoundOld:=Records in set:C195("$FieldTripNoMatch")
		If ($viFoundOld>0)
			CONFIRM:C162("Found "+String:C10($viFoundOld)+" unmatched records"; "Delete them?"; "Nope")
			If (OK=1)
				USE SET:C118("$FieldTripNoMatch")
				DELETE SELECTION:C66([BMS Field Trip:56])
			End if 
		End if 
		
		CLEAR SET:C117("$FieldTripNoMatch")
		
	End if 
End if 
