//%attributes = {"invisible":true}
//Method: Temp_FixRatingReportVeh
//Description
// temporary fix for records in table [RatingReportVehicles]
// Will log a deletion of the old id, assign new record ids to the current records in the table 
// and log the creation of a new record.
// this is from the roll-out of v7.3.0 where there was a table added and then deleted in the
// dev structure, but not in the production (bug fix) structure up to ver 7.2.1.x
// the rating vehicle tables were added (#190. 191) , but when v 7.3.0 opened the 7.2.1 data file
// the data in the tables was not accessible. 
// Call Reference #733
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/24/20, 17:52:34
	// ----------------------------------------------------
	//Created : 
	Mods_2020_07_bug
End if 
//
// will run only for designgroup
If (User in group:C338(Current user:C182; "Design Access Group"))
	ALERT:C41("This method will duplicate all current records in [RatingReportVehicles] and delete the old ones."+\
		" This should be run with no users connected!")
	CONFIRM:C162("Continue?"; "Continue"; "Cancel")
	If (OK=1)
		ALL RECORDS:C47([RatingReportVehicles:191])
		ARRAY LONGINT:C221($RatingvehIDs_aL; 0)
		SELECTION TO ARRAY:C260([RatingReportVehicles:191]RatingVehicleID:1; $RatingvehIDs_aL)
		C_LONGINT:C283($ratingvehID_L; $NumRatingVeh_L; $ratingVeh_L)
		$NumRatingVeh_L:=Size of array:C274($RatingvehIDs_aL)
		C_BOOLEAN:C305($ValidateTransaction_b; $AutoMany; $AutoOne; 4DError_b)
		GET AUTOMATIC RELATIONS:C899($AutoOne; $AutoMany)
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		
		C_TEXT:C284(VSFORWARD)  //to run interpreted
		InitChangeStack(1)
		//start the bar
		C_OBJECT:C1216($progress_o)
		$progress_o:=ProgressNew("Duplicating Rating Report vehicles"; $NumRatingVeh_L; True:C214; " Rating vehicle"; 3)
		START TRANSACTION:C239
		$ValidateTransaction_b:=True:C214
		For ($ratingVeh_L; 1; $NumRatingVeh_L)
			//update progress
			UpdateProgressNew($progress_o; $ratingVeh_L)
			QUERY:C277([RatingReportVehicles:191]; [RatingReportVehicles:191]RatingVehicleID:1=$RatingvehIDs_aL{$ratingVeh_L})
			If (Records in selection:C76([RatingReportVehicles:191])=1)
				
				If (ut_LoadRecordInteractive(->[RatingReportVehicles:191]))
					
					LogDeletion(->[RatingReports:65]RatingID:21; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1; 2)
					
					Inc_Sequence(Table name:C256(->[RatingReportVehicles:191]); ->[RatingReportVehicles:191]RatingVehicleID:1)
					LogNewRecordChanges(->[RatingReports:65]RatingID:21; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1; 2; Table name:C256(->[RatingReportVehicles:191]); 1)
					4DError_b:=False:C215
					ON ERR CALL:C155("4D_Errors")
					SAVE RECORD:C53([RatingReportVehicles:191])
					
					If (4DError_b)
						C_TEXT:C284($sql_errors_txt)
						$sql_errors_txt:=ut_ArraysToText("\t"; ->SQLErrorNumbers_al; ->SQL_InternalCodes_atxt; ->SQL_InternalDescriptions_atxt)
						ALERT:C41("Error Encountered Saving [RatingReportVehicles] record!\r"+$sql_errors_txt+"\rAborting")
						
						$ratingVeh_L:=$NumRatingVeh_L+1
						$ValidateTransaction_b:=False:C215
					Else 
						
					End if 
					ON ERR CALL:C155("")
					
					UNLOAD RECORD:C212([RatingReportVehicles:191])
					
				Else 
					//could not load the record - abort and cancel
					ALERT:C41("Record ID "+String:C10($RatingvehIDs_aL{$ratingVeh_L})+" could not be loaded for edit.  Process will abort.")
					$ratingVeh_L:=$NumRatingVeh_L+1
					$ValidateTransaction_b:=False:C215
				End if 
				
			Else 
				//probably deleted???
			End if 
			
			//check if progress stopped
			If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
				//abort loop
				$ratingVeh_L:=$NumRatingVeh_L+1
				$ValidateTransaction_b:=False:C215
			End if 
			
		End for 
		
		SET AUTOMATIC RELATIONS:C310($AutoOne; $AutoMany)
		
		//quit progress
		Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
		
		
		If ($ValidateTransaction_b)
			ALERT:C41("Saving transaction")
			VALIDATE TRANSACTION:C240
			ALERT:C41("duplicated and deleted "+String:C10($NumRatingVeh_L)+" rating report vehicle records")
			
		Else 
			ALERT:C41("Canceling transaction")
			CANCEL TRANSACTION:C241
		End if 
		
	End if 
	
End if 
//End Temp_FixRatingReportVeh