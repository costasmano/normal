//%attributes = {"invisible":true}
//Method: ACTLOG_ChangeNRCSeq
//Description
// new uiltity method to fix bad sequence name entered in the NRC record
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/04/14, 11:42:44
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04_bug
End if 
//
//Only for Design user

If (User in group:C338(Current user:C182; "Design Access Group"))
	//ask for ref ID
	C_LONGINT:C283($refIDRec_L)
	C_BOOLEAN:C305($Done_b)
	$Done_b:=False:C215
	ARRAY TEXT:C222($allSequences_as; 0)  //Command Replaced was o_ARRAY string length was 80
	READ ONLY:C145([Sequences:28])
	
	ALL RECORDS:C47([Sequences:28])
	ORDER BY:C49([Sequences:28]; [Sequences:28]Name:1)
	SELECTION TO ARRAY:C260([Sequences:28]Name:1; $allSequences_as)
	
	Repeat 
		$refIDRec_L:=Num:C11(Request:C163("Enter Activity log Refid to fix sequence name"))
		QUERY:C277([Activity Log:59]; [Activity Log:59]RefID:28=$refIDRec_L)
		
		If (Records in selection:C76([Activity Log:59])=1)
			//load it
			
			If (ut_LoadRecordInteractive(->[Activity Log:59]))
				//check it is an NRC rec
				If ([Activity Log:59]Activity Type:3="NRC")
					//get the current sequence
					C_TEXT:C284($oldSeq_s; $newSeq_s)  // Command Replaced was o_C_STRING length was 80
					C_LONGINT:C283($seqFound_L)
					BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $oldSeq_s)
					$seqFound_L:=G_PickFromList(->$allSequences_as; "Replace "+$oldSeq_s)
					
					//$newSeq_s:=Request("Enter new sequence to replace the current";$oldSeq_s)
					//  `check ti see if the sequence is in the seq table
					//SET QUERY DESTINATION(Into variable ;$seqFound_L)
					//QUERY([Sequences];[Sequences]Name=$newSeq_s)
					//SET QUERY DESTINATION(Into current selection )
					C_BOOLEAN:C305($makeChange_b)
					If ($seqFound_L=0)
						CONFIRM:C162("No Sequence Selected!!!  Try Again?"; "Again"; "Cancel")
						$Done_B:=(OK=0)
					Else 
						$newSeq_s:=$allSequences_as{$seqFound_L}
						CONFIRM:C162("Change sequence name from "+$oldSeq_s+"  to  "+$newSeq_s+"?"; "Change"; "Cancel")
						$makeChange_b:=(OK=1)
						
						If ($makeChange_b)
							SET BLOB SIZE:C606([Activity Log:59]Data:10; 0)
							VARIABLE TO BLOB:C532($newSeq_s; [Activity Log:59]Data:10)
							SAVE RECORD:C53([Activity Log:59])
							//check if we re done
							CONFIRM:C162("Changes made to the activity log record! Do another Activity log record or Exit?"; "One More"; "Exit")
							$Done_b:=(OK=0)
						End if 
						
					End if 
					
				Else 
					CONFIRM:C162("Record is not an NRC record! Try again?"; "Again"; "Exit")
					$Done_b:=(OK=0)
				End if 
			Else 
				CONFIRM:C162("Record is locked! Try again?"; "Again"; "Exit")
				$Done_b:=(OK=0)
			End if 
			
		Else 
			CONFIRM:C162("No Record Found! Try again?"; "Again"; "Exit")
			$Done_b:=(OK=0)
		End if 
		
	Until ($Done_b)
	
End if 

//End ACTLOG_ChangeNRCSeq