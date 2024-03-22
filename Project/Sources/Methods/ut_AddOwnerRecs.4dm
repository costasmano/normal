//%attributes = {"invisible":true}
// Method: ut_AddOwnerRecs
// Description
//Add Owner records to [Owners of Data] for [activity Log] records not
//owned by a user.
//Can be used when copying a data file from a server to a laptop 
//to indicate that the user has all records from the server DB.
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/07/05, 16:41:43
	// ----------------------------------------------------
	// Method: ut_AddOwnerRecs
	// Description
	// 
	//Add Owner records to [Owners of Data] for [activity Log] records not
	//owned by a user.
	//Can be used when copying a data file from a server to a laptop 
	//to indicate that the user has all records from the server DB.
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(7/10/09 10:12:52)
	Mods_2009_07
	//  `Added ability to 'copy' records owned by another user after getting a selection of activity Log records.
	//  `Also added an execution boolean and predefined the Array of refIDs.
	Mods_2011_06  // CJ Miller`06/13/11, 16:54:40      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(10/25/17 12:12:14)
	Mods_2017_10
	//  `use new ProgressNew and UpdateProgressNew
	// Modified by: Costas Manousakis-(Designer)-(1/10/19 10:23:44)
	Mods_2019_01
	//  `Added Alert at the end of adding records
	// Modified by: Costas Manousakis-(Designer)-(2023-04-06 12:43:54)
	Mods_2023_04
	//  `replaced creating records one at a time with using Array to selection
End if 

C_TEXT:C284($prev_user; $old_user)
C_LONGINT:C283($nOwnrecs; $Interval; $i)
$old_user:=""
$old_user:=Request:C163("Enter user name")
If (OK=1)
	ARRAY TEXT:C222($asUserNames; 0)
	ARRAY LONGINT:C221($aiUserNumbers; 0)
	GET USER LIST:C609($asUserNames; $aiUserNumbers)
	$i:=Find in array:C230($asUserNames; $old_user)
	If ($i>0)
		$old_user:=$asUserNames{$i}
	Else 
		ALERT:C41("User Name "+$old_user+" Not Found in User List!")
		$old_user:=""
	End if 
End if 
If (Not:C34(User in group:C338($old_user; "ActiveUsers")))
	ALERT:C41("User Name "+$old_user+" Not in ActiveUser Group!")
	$old_user:=""
End if 

If ($old_user#"")
	C_BOOLEAN:C305($DoAdd_b)
	$DoAdd_b:=False:C215
	CONFIRM:C162("Do all Act Log Records or a Custom Query?"; "All"; "CustomQuery")
	If (OK=1)
		ALL RECORDS:C47([Activity Log:59])
		$DoAdd_b:=True:C214
	Else 
		QUERY:C277([Activity Log:59])
		If (OK=1)
			$DoAdd_b:=True:C214
		End if 
		
	End if 
	If ($DoAdd_b)
		CONFIRM:C162("Reduce the selection to records owned by another user?"; "AnotherUser"; "KeepSelection")
		If (OK=1)
			$prev_user:=Request:C163("Enter User name")
			If (OK=1)
				CREATE SET:C116([Activity Log:59]; "AllActLogRecs")
				QUERY:C277([Owners of Data:62]; [Owners of Data:62]Owner Name:2=$prev_user)
				RELATE ONE SELECTION:C349([Owners of Data:62]; [Activity Log:59])
				CREATE SET:C116([Activity Log:59]; "Hasrecords")
				INTERSECTION:C121("AllActLogRecs"; "Hasrecords"; "AllActLogRecs")
				USE SET:C118("AllActLogRecs")
				CLEAR SET:C117("AllActLogRecs")
				CLEAR SET:C117("Hasrecords")
				$DoAdd_b:=True:C214
			Else 
				ALERT:C41("Add Owner Process Canceled!")
				$DoAdd_b:=False:C215
			End if 
			
		End if 
		
	End if 
	If (Records in selection:C76([Activity Log:59])=0)
		ALERT:C41("No Activiity Log records were selected! - Add Owner Process Cancelling!")
		$DoAdd_b:=False:C215
	End if 
	
	If ($DoAdd_b)
		
		SHORT_MESSAGE("Checking for missing records...")
		
		CREATE SET:C116([Activity Log:59]; "AllActLogRecs")
		
		QUERY:C277([Owners of Data:62]; [Owners of Data:62]Owner Name:2=$old_user)
		RELATE ONE SELECTION:C349([Owners of Data:62]; [Activity Log:59])
		
		CREATE SET:C116([Activity Log:59]; "Hasrecords")
		DIFFERENCE:C122("AllActLogRecs"; "Hasrecords"; "ActNotThere")
		CLEAR SET:C117("AllActLogRecs")
		CLEAR SET:C117("Hasrecords")
		$nOwnrecs:=Records in set:C195("ActNotThere")
		CLOSE WINDOW:C154
		If ($nOwnrecs>0)
			USE SET:C118("ActNotThere")
			//check to see if user is an active one
			If (User in group:C338($old_user; "ActiveUsers"))
				ARRAY LONGINT:C221($aUserRefIDs; $nOwnrecs)
				SELECTION TO ARRAY:C260([Activity Log:59]RefID:28; $aUserRefIDs)
				CONFIRM:C162("Ready to Add "+String:C10($nOwnrecs)+" ActivityLog Owner records to user "+$old_user+"?")
				If (OK=1)
					C_OBJECT:C1216($progressObj_o)
					$progressObj_o:=ProgressNew("Adding Owner Recs"; $nOwnrecs; False:C215; ""; 3)
					
					UpdateProgressNew($progressObj_o; -1)
					Progress SET MESSAGE($progressObj_o.progress; "Loading arrays...")
					ARRAY TEXT:C222($ownername_atxt; $nOwnrecs)
					ARRAY TEXT:C222($UUIDS_atxt; $nOwnrecs)
					C_LONGINT:C283($loop_L)
					For ($loop_L; 1; $nOwnrecs)
						$ownername_atxt{$loop_L}:=$old_user
						$UUIDS_atxt{$loop_L}:=Generate UUID:C1066
					End for 
					
					REDUCE SELECTION:C351([Owners of Data:62]; 0)
					Progress SET MESSAGE($progressObj_o.progress; "Creating records from arrays...")
					ARRAY TO SELECTION:C261($aUserRefIDs; [Owners of Data:62]RefID:1; *)
					ARRAY TO SELECTION:C261($ownername_atxt; [Owners of Data:62]Owner Name:2; *)
					ARRAY TO SELECTION:C261($UUIDS_atxt; [Owners of Data:62]Owners_of_Data_UUIDKey_s:3)
					
					Progress QUIT($progressObj_o.progress)
					
					ALERT:C41("Finished adding "+String:C10($nOwnrecs)+" owner records in Activity Log for user "+$old_user)
				End if 
				//clean out the array    
				ARRAY LONGINT:C221($aUserRefIDs; 0)
				
			Else 
				ALERT:C41("User "+$old_user+" is not an active user")
			End if 
			
		Else 
			ALERT:C41("No Missing [Activity Log] records found for "+$old_user)
		End if 
		CLEAR SET:C117("ActNotThere")
		
	End if 
	//at end reduce the selection
	REDUCE SELECTION:C351([Owners of Data:62]; 0)
	REDUCE SELECTION:C351([Activity Log:59]; 0)
End if 