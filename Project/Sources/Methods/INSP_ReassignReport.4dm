//%attributes = {"invisible":true}
//Method: INSP_ReassignReport
//Description
//method to re-assign inspection report to another user by
//changing the Modified by field
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-03-18T00:00:00, 15:56:18
	// ----------------------------------------------------
	//Created : 
	Mods_2022_03
End if 
//
C_LONGINT:C283($i; $LRecsInSet; $k)
C_TEXT:C284($msg)
C_TEXT:C284($new_user)  // Command Replaced was o_C_STRING length was 40
C_BOOLEAN:C305($bOKUser)
ARRAY TEXT:C222($aUsers; 0)  //Command Replaced was o_ARRAY string length was 40
ARRAY INTEGER:C220($aUserNumbers; 0)
If ((User in group:C338(Current user:C182; "Inspection Engineers")) | (Current user:C182="Designer"))
	GET USER LIST:C609($aUsers; $aUserNumbers)
	$LRecsInSet:=Records in set:C195("UserSet")
	If ($LRecsInSet>0)
		//Save current selection
		CUT NAMED SELECTION:C334([Inspections:27]; "TempSelection1")
		USE SET:C118("UserSet")
		FIRST RECORD:C50([Inspections:27])
		For ($i; 1; $LRecsInSet)
			
			RELATE ONE:C42([Inspections:27]Insp Type:6)
			
			If (Not:C34(Locked:C147([Inspections:27])))
				
				$bOKUser:=False:C215
				$new_user:=Request:C163("New Owner name for "+[Inspection Type:31]Description:2+" Insp - BIN "+[Inspections:27]BIN:1)
				If ((OK=1) & (Replace string:C233($new_user; " "; "")#""))
					$k:=Find in array:C230($aUsers; $new_user)
					If ($k>0)
						If (Not:C34(Is user deleted:C616($aUserNumbers{$k})))
							$bOKUser:=True:C214
						End if 
					End if 
					If ($bOKUser)
						$msg:="Change Inspection Ownership from "+[Inspections:27]Modified By:134
						$msg:=$msg+<>sCR+"to user :"+$aUsers{$k}
						$msg:=$msg+<>sCR+" for "+[Inspection Type:31]Description:2+" Inspection "
						$msg:=$msg+<>sCR+"dated : "+String:C10([Inspections:27]Insp Date:78)
						$msg:=$msg+<>sCR+"for  BIN : "+[Inspections:27]BIN:1+"?"
						CONFIRM:C162($msg)
						If (Ok=1)
							[Inspections:27]Modified By:134:=$aUsers{$k}
							vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; [Inspections:27]Insp Type:6; [Inspections:27]TeamLeader:4)
							LogChanges(->[Inspections:27]Modified By:134; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
							SAVE RECORD:C53([Inspections:27])
							UNLOAD RECORD:C212([Activity Log:59])
						End if 
					Else 
						ALERT:C41("User name <"+$new_user+"> Not Found!!!")
					End if 
				End if   //if OK=1
				
			Else 
				//Inspection is locked - in use by somebody...
				C_LONGINT:C283($OtherPID)  //Command Replaced was o_C_INTEGER
				C_TEXT:C284($OtherUser; $OtherMachine; $OtherProc)  // Command Replaced was o_C_STRING length was 80
				LOCKED BY:C353([Inspections:27]; $OtherPID; $OtherUser; $OtherMachine; $OtherProc)
				$msg:="Inspection "+[Inspections:27]Insp Type:6+" BIN :"+[Inspections:27]BIN:1+" date:"+String:C10([Inspections:27]Insp Date:78)
				$msg:=$msg+" is being edited by"+<>sCR+"User : "+$OtherUser+<>sCR+"From station : "+$OtherMachine
				$msg:=$msg+<>sCR+"In process : "+$OtherProc
				$msg:=$msg+<>sCR+"Cannot proceed with change of Owner at this time. Try again later."
				ALERT:C41($msg)
				
			End if 
			NEXT RECORD:C51([Inspections:27])
			
		End for 
		
		USE NAMED SELECTION:C332("TempSelection1")
		HIGHLIGHT RECORDS:C656("UserSet")
		UNLOAD RECORD:C212([Inspections:27])
	Else 
		ALERT:C41("You must first Highlight Records to Re-Assign!")
	End if 
End if 
//End INSP_ReassignReport