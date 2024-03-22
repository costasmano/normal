//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/09/10, 21:32:59
	// ----------------------------------------------------
	// Method: ut_convert2Distr6
	// Description
	//  ` Convert info in Town Data and [Bridge MHD NBIS]Item2 from D4 to the new D6
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_08
End if 
If (Current user:C182="Designer")
	Case of 
		: (Count parameters:C259=0)
			C_BOOLEAN:C305($Done_b)
			$Done_b:=False:C215
			Repeat 
				C_LONGINT:C283($Option_L)
				$Option_L:=ut_3Option_Confirm("Converting from D4 to D6!! Convert Town Data or Bridge Item 2?"; "Town Data"; "Bridge Item 2"; "END")
				Case of 
					: ($Option_L=1)
						ut_convert2Distr6("TOWNDATA")
					: ($Option_L=2)
						ut_convert2Distr6("BRIDGEITEM2")
					: ($Option_L=3)
						$Done_b:=True:C214
				End case 
				
			Until ($Done_b)
			
		: (Count parameters:C259=1)
			C_TEXT:C284($1)
			Case of 
				: ($1="TOWNDATA")
					READ WRITE:C146([Town Data:2])
					QUERY WITH ARRAY:C644([Town Data:2]Town Name:1; <>D6Towns_atxt)
					ARRAY TEXT:C222(sbdept_atxt; Records in selection:C76([Town Data:2]))
					SELECTION TO ARRAY:C260([Town Data:2]BDEPT Prefix:2; sbdept_atxt)
					QUERY SELECTION:C341([Town Data:2]; [Town Data:2]District:6="04")
					If (Records in selection:C76([Town Data:2])>0)
						CONFIRM:C162("CONVERTING "+String:C10(Records in selection:C76([Town Data:2]))+" TOWN DATA RECORDS FOR D6 FROM 04 TO 06")
						If (OK=1)
							START TRANSACTION:C239
							Repeat 
								APPLY TO SELECTION:C70([Town Data:2]; [Town Data:2]District:6:="06")
								If (Records in set:C195("LockedSet")>0)
									ALERT:C41("Some records in [Town Data] were locked- trying again!")
									//IDLE
									DELAY PROCESS:C323(Current process:C322; 60)
									USE SET:C118("LockedSet")
								End if 
							Until (Records in set:C195("LockedSet")=0)
							VALIDATE TRANSACTION:C240
							ALERT:C41("DONE!")
							
						End if 
						
					Else 
						ALERT:C41("ALL TOWN DATA RECORDS FOR D6 HAVE BEEN CHANGED FROM 04 TO 06")
					End if 
					READ ONLY:C145([Town Data:2])
					REDUCE SELECTION:C351([Town Data:2]; 0)
					UNLOAD RECORD:C212([Town Data:2])
					
				: ($1="BRIDGEITEM2")
					READ ONLY:C145([Town Data:2])
					QUERY WITH ARRAY:C644([Town Data:2]Town Name:1; <>D6Towns_atxt)
					ARRAY TEXT:C222(sbdept_atxt; Records in selection:C76([Town Data:2]))
					SELECTION TO ARRAY:C260([Town Data:2]BDEPT Prefix:2; sbdept_atxt)
					
					C_LONGINT:C283($loop_L; $NumberSkipped_L; $NumberFixed_L)
					For ($loop_L; 1; Size of array:C274(sbdept_atxt))
						sbdept_atxt{$loop_L}:=sbdept_atxt{$loop_L}+"@"
					End for 
					QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BDEPT:1; sbdept_atxt)
					C_BOOLEAN:C305($abort_b)
					$abort_b:=False:C215
					READ WRITE:C146([Bridge MHD NBIS:1])
					$loop_L:=1
					$NumberSkipped_L:=0
					$NumberFixed_L:=0
					C_TEXT:C284($BinsSkipped_txt)
					$BinsSkipped_txt:=""
					<>ProgressPID:=StartProgress("Item 2 Update"; "none"; "Updating Item 2 to 06"; "Num Records")
					UpdateProgress(1; Records in selection:C76([Bridge MHD NBIS:1]))
					While ($loop_L<=Records in selection:C76([Bridge MHD NBIS:1]))
						GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $loop_L)
						LOAD RECORD:C52([Bridge MHD NBIS:1])
						If ([Bridge MHD NBIS:1]Item2:60="06")
							$loop_L:=$loop_L+1
						Else 
							If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]))
								[Bridge MHD NBIS:1]Item2:60:="06"
								LogChanges(->[Bridge MHD NBIS:1]Item2:60; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
								SAVE RECORD:C53([Bridge MHD NBIS:1])
								UNLOAD RECORD:C212([Bridge MHD NBIS:1])
								$NumberFixed_L:=$NumberFixed_L+1
								$loop_L:=$loop_L+1
							Else 
								CONFIRM:C162("BIN "+[Bridge MHD NBIS:1]BIN:3+"is locked! Wait a few and try again or skip and go to next record?"; "Try Again"; "SKIP!")
								If (OK=1)
									uT_DelayUserProcess  //delay 10 sec
								Else 
									$loop_L:=$loop_L+1
									$NumberSkipped_L:=$NumberSkipped_L+1
									$BinsSkipped_txt:=$BinsSkipped_txt+" "+[Bridge MHD NBIS:1]BIN:3+" "
									
								End if 
								
							End if 
							
						End if 
						UpdateProgress($loop_L; Records in selection:C76([Bridge MHD NBIS:1]))
						
					End while 
					
					POST OUTSIDE CALL:C329(<>ProgressPID)
					If ($NumberSkipped_L>0)
						ALERT:C41("Looped thru "+String:C10($loop_L-1)+" Bridge records. Converted "+String:C10($NumberFixed_L)+", Skipped "+String:C10($NumberSkipped_L)+" BINS :["+$BinsSkipped_txt+"]")
					Else 
						ALERT:C41("Looped thru "+String:C10($loop_L-1)+" Bridge records. Converted "+String:C10($NumberFixed_L))
					End if 
					
					READ ONLY:C145([Bridge MHD NBIS:1])
					REDUCE SELECTION:C351([Bridge MHD NBIS:1]; 0)
					UNLOAD RECORD:C212([Bridge MHD NBIS:1])
					
			End case 
			
	End case 
	
End if 