//%attributes = {"invisible":true}
//Method: PON_ut_RelogPON_INSP_records
//Description
// relog records in [PON_ELEM_INSP]
// generally create GRP and LNK records.
// search for records using the Query command.
// check if there is a record in the FileIDRes table. if there is not probably need to create a NRC act log
//check to see if there is an NRC rec in act log already. matching pon id, insp id then check the source.
// also check if there is a record in the FileIDRes table for the LNK fields. if not, check if there is an NRC rec - maybe not sent yet.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/03/15, 11:16:52
	// ----------------------------------------------------
	//Created : 
	Mods_2015_10_bug
	C_TEXT:C284(PON_ut_RelogPON_INSP_records; $1)
	// Modified by: Costas Manousakis-(Designer)-(10/22/15 17:31:41)
	Mods_2015_10_bug
	//  `fixed call to LogLink
End if 
//
If (User in group:C338(Current user:C182; "Design Access Group"))  //only for design group users 
	//launch a new process to run this
	
	If (Count parameters:C259=0)
		C_LONGINT:C283($Lpid)
		$Lpid:=LSpawnProcess("PON_ut_RelogPON_INSP_records"; <>LStackSize; "ReLogPONRecs"; True:C214; False:C215; "RUN")
	Else 
		C_TEXT:C284($1)
		
		C_BOOLEAN:C305($Done_b; $lognew_b; $logtherecord_b)
		$Done_b:=False:C215
		C_TEXT:C284($msg_txt)
		READ ONLY:C145(*)  // all tables read only
		
		//prep stack and arrays
		ARRAY POINTER:C280(ptr_changes; 0; 0)
		InitChangeStack(1)
		ARRAY POINTER:C280($FldsToSkip_aptr; 0)
		ARRAY POINTER:C280($fldsToLog_aptr; 0)
		APPEND TO ARRAY:C911($FldsToSkip_aptr; ->[PON_ELEM_INSP:179]INSPID:21)
		APPEND TO ARRAY:C911($FldsToSkip_aptr; ->[PON_ELEM_INSP:179]ELEMID:22)
		APPEND TO ARRAY:C911($FldsToSkip_aptr; ->[PON_ELEM_INSP:179]ELEM_PARENTID:27)  //skip these two also - they are link entries
		APPEND TO ARRAY:C911($FldsToSkip_aptr; ->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28)
		
		C_LONGINT:C283($TblNum_L; $numFlds_L; $fLoop_L; $NRCRecordFound_L)
		C_POINTER:C301($Tbl_ptr; $fld_ptr)
		$TblNum_L:=Table:C252(->[PON_ELEM_INSP:179])
		$Tbl_ptr:=Table:C252($TblNum_L)
		$numFlds_L:=Get last field number:C255($Tbl_ptr)
		//do all the fields
		For ($fLoop_L; 1; $numFlds_L)
			If (Is field number valid:C1000($Tbl_ptr; $fLoop_L))
				$fld_ptr:=Field:C253($TblNum_L; $fLoop_L)
				If (Find in array:C230($FldsToSkip_aptr; $fld_ptr)>0)
					
				Else 
					APPEND TO ARRAY:C911($fldsToLog_aptr; $fld_ptr)
				End if 
			End if 
		End for 
		
		ARRAY LONGINT:C221($InspIDs_aL; 0)
		C_TEXT:C284(vsForward)  // Command Replaced was o_C_STRING length was 80
		vsForward:=<>Forward  // no need to reset it later. this is is a separate process
		
		Repeat 
			QUERY:C277([PON_ELEM_INSP:179])
			If (OK=1)
				If (Records in selection:C76([PON_ELEM_INSP:179])>0)
					DISTINCT VALUES:C339([PON_ELEM_INSP:179]INSPID:21; $InspIDs_aL)
					If (Size of array:C274($InspIDs_aL)>1)
						//should do one inspection at a time. - because we sort the elements in the order they appear in the inspection
						ALERT:C41("Multiple inspections are in the set!  Try again")
					Else 
						CONFIRM:C162("Process "+String:C10(Records in selection:C76([PON_ELEM_INSP:179]))+" records?")
						If (OK=1)
							//sort them 
							ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; PON_ElemSort)
							FIRST RECORD:C50([PON_ELEM_INSP:179])
							QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[PON_ELEM_INSP:179]INSPID:21)
							
							If (Structure file:C489="MHD BMS External@")
								QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Inspections:27]BIN:1)
								
								If ([Bridge MHD NBIS:1]InspResp:173="DIST@")
									vsForward:="District "+Substring:C12([Bridge MHD NBIS:1]InspResp:173; 5; 1)+" BMS"
								End if 
							End if 
							
							While (Not:C34(End selection:C36([PON_ELEM_INSP:179])))
								
								//check to see if we need to log the NRC
								SET QUERY DESTINATION:C396(Into variable:K19:4; $NRCRecordFound_L)
								QUERY:C277([Activity Log:59]; [Activity Log:59]Activity Type:3="NRC"; *)
								QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Local:24=$TblNum_L; *)
								QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Local ID:15=String:C10([PON_ELEM_INSP:179]ELEMID:22); *)
								QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Parent ID:14=String:C10([PON_ELEM_INSP:179]INSPID:21))
								SET QUERY DESTINATION:C396(Into current selection:K19:1)
								
								//default : no NRC record only GRP and LNK records
								$lognew_b:=False:C215
								$logtherecord_b:=True:C214
								
								Case of 
									: ($NRCRecordFound_L=1)
										//found one - just log the fields
									: ($NRCRecordFound_L=0)
										//no record found ` verify that we want to create an NRC
										$msg_txt:="Did not find an NRC record for ElemID "+String:C10([PON_ELEM_INSP:179]ELEMID:22)
										$msg_txt:=$msg_txt+" Key/Env "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+"/"+String:C10([PON_ELEM_INSP:179]ENVKEY:5)
										$msg_txt:=$msg_txt+" and InspID "+String:C10([PON_ELEM_INSP:179]INSPID:21)+" !! Create one?"
										CONFIRM:C162($msg_txt)
										$lognew_b:=(OK=1)
									Else 
										//more than one!!! ask what to do
										$msg_txt:="More than one NRC records found for ElemID "+String:C10([PON_ELEM_INSP:179]ELEMID:22)
										$msg_txt:=$msg_txt+" Key/Env "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+"/"+String:C10([PON_ELEM_INSP:179]ENVKEY:5)+" and InspID "+String:C10([PON_ELEM_INSP:179]INSPID:21)+" !! Create one?"
										$msg_txt:=$msg_txt+" and InspID "+String:C10([PON_ELEM_INSP:179]INSPID:21)+" !! "
										ALERT:C41($msg_txt)
										CONFIRM:C162("Create a NRC Activity Log record?")
										$lognew_b:=(OK=1)
										CONFIRM:C162("Create a GRP / LNK Activity Log record(s)?")
										$logtherecord_b:=(OK=1)
								End case 
								//now check if the LNK records should be created.  if not, we should skip the element.
								If ([PON_ELEM_INSP:179]ELEM_PARENTID:27>0)
									SET QUERY DESTINATION:C396(Into variable:K19:4; $NRCRecordFound_L)
									QUERY:C277([Activity Log:59]; [Activity Log:59]Activity Type:3="NRC"; *)
									QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Local:24=$TblNum_L; *)
									QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Local ID:15=String:C10([PON_ELEM_INSP:179]ELEM_PARENTID:27); *)
									QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Parent ID:14=String:C10([PON_ELEM_INSP:179]INSPID:21))
									SET QUERY DESTINATION:C396(Into current selection:K19:1)
									
									Case of 
										: ($NRCRecordFound_L=1)
											// ok
										: ($NRCRecordFound_L=0)
											$msg_txt:="NO NRC records found for Parent with ElemID "+String:C10([PON_ELEM_INSP:179]ELEM_PARENTID:27)
											$msg_txt:=$msg_txt+" Key/Env "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+"/"+String:C10([PON_ELEM_INSP:179]ENVKEY:5)
											$msg_txt:=$msg_txt+" and InspID "+String:C10([PON_ELEM_INSP:179]INSPID:21)
											$msg_txt:=$msg_txt+" !! skipping current element ID "+String:C10([PON_ELEM_INSP:179]ELEMID:22)+"!!"
											ALERT:C41($msg_txt)
											$lognew_b:=False:C215
											$logtherecord_b:=False:C215
											
										Else 
											$msg_txt:="More than one NRC records found for Parent with ElemID "+String:C10([PON_ELEM_INSP:179]ELEM_PARENTID:27)
											$msg_txt:=$msg_txt+" Key/Env "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+"/"+String:C10([PON_ELEM_INSP:179]ENVKEY:5)
											$msg_txt:=$msg_txt+" and InspID "+String:C10([PON_ELEM_INSP:179]INSPID:21)
											$msg_txt:=$msg_txt+" !! skipping current element ID "+String:C10([PON_ELEM_INSP:179]ELEMID:22)+"!!"
											ALERT:C41($msg_txt)
											$lognew_b:=False:C215
											$logtherecord_b:=False:C215
									End case 
									
								End if 
								
								If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28>0)
									SET QUERY DESTINATION:C396(Into variable:K19:4; $NRCRecordFound_L)
									QUERY:C277([Activity Log:59]; [Activity Log:59]Activity Type:3="NRC"; *)
									QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Local:24=$TblNum_L; *)
									QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Local ID:15=String:C10([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28); *)
									QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Parent ID:14=String:C10([PON_ELEM_INSP:179]INSPID:21))
									SET QUERY DESTINATION:C396(Into current selection:K19:1)
									
									Case of 
										: ($NRCRecordFound_L=1)
										: ($NRCRecordFound_L=0)
											$msg_txt:="NO NRC records found for GrandParent with ElemID "+String:C10([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28)
											$msg_txt:=$msg_txt+" Key/Env "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+"/"+String:C10([PON_ELEM_INSP:179]ENVKEY:5)
											$msg_txt:=$msg_txt+" and InspID "+String:C10([PON_ELEM_INSP:179]INSPID:21)
											$msg_txt:=$msg_txt+" !! skipping current element ID "+String:C10([PON_ELEM_INSP:179]ELEMID:22)+"!!"
											ALERT:C41($msg_txt)
											$lognew_b:=False:C215
											$logtherecord_b:=False:C215
										Else 
											$msg_txt:="More than one NRC records found for GrandParent with ElemID "+String:C10([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28)
											$msg_txt:=$msg_txt+" Key/Env "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+"/"+String:C10([PON_ELEM_INSP:179]ENVKEY:5)
											$msg_txt:=$msg_txt+" and InspID "+String:C10([PON_ELEM_INSP:179]INSPID:21)
											$msg_txt:=$msg_txt+" !! skipping current element ID "+String:C10([PON_ELEM_INSP:179]ELEMID:22)+"!!"
											ALERT:C41($msg_txt)
											$lognew_b:=False:C215
											$logtherecord_b:=False:C215
									End case 
									
								End if 
								
								If ($lognew_b)
									LogNewRecord(->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; "PON_ELEM_INSP")
								End if 
								
								If ($logtherecord_b)
									
									C_LONGINT:C283($loop_L)
									For ($loop_L; 1; Size of array:C274($fldsToLog_aptr))
										PushChange(1; $fldsToLog_aptr{$loop_L})
									End for 
									
									FlushGrpChgs(1; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2)
									If ([PON_ELEM_INSP:179]ELEM_PARENTID:27>0)
										LogLink(->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
									End if 
									If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28>0)
										LogLink(->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
									End if 
									
								End if 
								NEXT RECORD:C51([PON_ELEM_INSP:179])
							End while 
							
						End if 
						
					End if 
					
				Else 
					ALERT:C41("No Records were found!!!")
				End if 
				
			End if 
			CONFIRM:C162("Continue with More records?"; "Done"; "More")
			$Done_b:=(OK=1)
		Until ($Done_b)
		
	End if 
	
End if 
//End PON_ut_RelogPON_INSP_records