//%attributes = {"invisible":true}
If (False:C215)
	//Method to duplicate owner recor
	//will make a copy of owner records with same refID to another user.
	//Can be used to indicate that data downloaded already by the first user
	//does not need to be downloaded by the second user.
End if 

C_TEXT:C284($old_user; $new_user)  // Command Replaced was o_C_STRING length was 40
C_LONGINT:C283($nOwnrecs; $Interval; $i)
$old_user:=Request:C163("Enter user name")
If (OK=1)
	QUERY:C277([Owners of Data:62]; [Owners of Data:62]Owner Name:2=$old_user)
	QUERY SELECTION:C341([Owners of Data:62]; [Activity Log:59]Status:9=-1)
	$nOwnrecs:=Records in selection:C76([Owners of Data:62])
	If ($nOwnrecs>0)
		$new_user:=Request:C163("Enter new user name")
		//check to see if user is an active one
		If (User in group:C338($new_user; "ActiveUsers"))
			ARRAY LONGINT:C221($aUserRefIDs; 0)
			SELECTION TO ARRAY:C260([Owners of Data:62]RefID:1; $aUserRefIDs)
			CONFIRM:C162("Ready to duplicate "+String:C10($nOwnrecs)+" ActivityLog Owner records to user "+$new_user+"?")
			If (OK=1)
				<>ProgressPID:=StartProgress(""; "None"; "Duplicating Owner Recs")
				$Interval:=MaxNum(MinNum(Int:C8($nOwnrecs/40); 20); 2)  // get an update interval between 2 and 20
				UpdateProgress(1; $nOwnrecs)  // start the progress bar...
				For ($i; 1; $nOwnrecs)
					CREATE RECORD:C68([Owners of Data:62])
					[Owners of Data:62]RefID:1:=$aUserRefIDs{$i}
					[Owners of Data:62]Owner Name:2:=$new_user
					SAVE RECORD:C53([Owners of Data:62])
					//FLUSH CACHE
					UNLOAD RECORD:C212([Owners of Data:62])
					If ($i%$Interval=0)  //Don't slow down things just to display
						//GOTO XY(1;1)
						//MESSAGE("Record "+String($i)+" of "+String($recnum))
						UpdateProgress($i; $nOwnrecs)
					End if 
				End for 
				
				POST OUTSIDE CALL:C329(<>ProgressPID)
				
			End if 
			//clean out the array    
			ARRAY LONGINT:C221($aUserRefIDs; 0)
			
		Else 
			ALERT:C41("User "+$new_user+" is not an active user")
		End if 
		
	Else 
		ALERT:C41("No Owner records found for "+$old_user)
	End if 
	
	//at end reduce the selection
	REDUCE SELECTION:C351([Owners of Data:62]; 0)
End if 