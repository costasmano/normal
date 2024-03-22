//%attributes = {"invisible":true}
//Temp_ChangeInspBIN 
//  `Move an inspection to a different BIN
//  `Will prompt for a BIN to move inspection to;
//  `then allow user to search to inspection records to find which inspection to move
//  `meant to be used from the administration tools
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(4/24/12 13:38:50)
	Mods_2012_04
	//  `Fixed methodology
	// Modified by: Costas Manousakis-(Designer)-(5/9/13 11:05:07)
	Mods_2013_05
	//  `Added def of vsForward
End if 

If (User in group:C338(Current user:C182; "Design Access Group"))
	//Change the BIN for an Inspection.
	C_BLOB:C604($tempblob)
	C_TEXT:C284($tempbin)  // Command Replaced was o_C_STRING length was 3
	C_LONGINT:C283($BinFound)
	C_TEXT:C284(vsForward)  // Command Replaced was o_C_STRING length was 80
	vsForward:=<>Forward
	
	$tempbin:=Uppercase:C13(Substring:C12(Request:C163("Enter BIN to assign inspection to"); 1; 3))
	SET QUERY DESTINATION:C396(Into variable:K19:4; $BinFound)
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$tempbin)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($BinFound=1)
		C_BOOLEAN:C305($FoundInsp_B)
		$FoundInsp_B:=False:C215
		READ ONLY:C145([Inspections:27])
		READ ONLY:C145([BMS Inspections:44])
		READ ONLY:C145([Combined Inspections:90])
		READ ONLY:C145([ElementsSafety:29])
		READ ONLY:C145([Standard Photos:36])
		READ ONLY:C145([Cond Units:45])
		READ ONLY:C145([Field Trip:43])
		READ ONLY:C145([BMS Field Trip:56])
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		ALL RECORDS:C47([Inspections:27])
		ALERT:C41("Select an existing inspection to assign to BIN "+$tempbin)
		C_TEXT:C284($msg_txt)
		C_LONGINT:C283($numElmts_L; $numPhotos_L; $numTeam_L; $NumCUs_L; $numBMSTm_L)
		While (Not:C34($FoundInsp_B))
			QUERY SELECTION:C341([Inspections:27])
			FIRST RECORD:C50([Inspections:27])
			QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
			QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
			SET QUERY DESTINATION:C396(Into variable:K19:4; $numElmts_L)
			QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2)
			SET QUERY DESTINATION:C396(Into variable:K19:4; $numPhotos_L)
			QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2)
			SET QUERY DESTINATION:C396(Into variable:K19:4; $numTeam_L)
			QUERY:C277([Field Trip:43]; [Field Trip:43]InspID:1=[Inspections:27]InspID:2)
			SET QUERY DESTINATION:C396(Into variable:K19:4; $NumCUs_L)
			QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=[BMS Inspections:44]Inspection ID:1)
			SET QUERY DESTINATION:C396(Into variable:K19:4; $numBMSTm_L)
			QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Inspection ID:1=[BMS Inspections:44]Inspection ID:1)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			$msg_txt:="Found Insp ID:"+String:C10([Inspections:27]InspID:2)+" Type "+[Inspections:27]Insp Type:6+" date "+String:C10([Inspections:27]Insp Date:78)+" BIN "+[Inspections:27]BIN:1
			$msg_txt:=$msg_txt+" - Elements :"+String:C10($numElmts_L)+" ; Photos :"+String:C10($numPhotos_L)+"  team:"+String:C10($numTeam_L)
			$msg_txt:=$msg_txt+" BMS ID :"+String:C10([BMS Inspections:44]Inspection ID:1)+"  CUs :"+String:C10($NumCUs_L)+" bms team:"+String:C10($numBMSTm_L)
			ALERT:C41($msg_txt)
			
			CONFIRM:C162("Continue Searching?"; "Continue"; "Finish")
			If (Ok=0)
				$FoundInsp_B:=True:C214
			End if 
		End while 
		
		If ($FoundInsp_B)
			FIRST RECORD:C50([Inspections:27])
			QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
			QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
			
			Case of 
				: (Not:C34(ut_LoadRecordInteractive(->[Inspections:27])))
					ALERT:C41("Could not load Inspections record")
				: (Not:C34(ut_LoadRecordInteractive(->[Combined Inspections:90])))
					ALERT:C41("Could not load Combined Inspections record")
				: (Not:C34(ut_LoadRecordInteractive(->[BMS Inspections:44])))
					ALERT:C41("Could not load BMS Inspections record")
				Else 
					CONFIRM:C162("Change insp ID :"+String:C10([Inspections:27]InspID:2)+" Type "+[Inspections:27]Insp Type:6+" date "+String:C10([Inspections:27]Insp Date:78)+" BIN "+[Inspections:27]BIN:1+"  to new BIN "+$tempbin+"?"; "Change BIN"; "Cancel")
					If (OK=1)
						START TRANSACTION:C239
						
						//log the change first  
						LogChanges(->[Inspections:27]BIN:1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
						//set the value in the log
						VARIABLE TO BLOB:C532($tempBin; $tempBlob)
						FIRST RECORD:C50([Activity Log:59])
						[Activity Log:59]Data:10:=$tempBlob
						SAVE RECORD:C53([Activity Log:59])
						//make the change
						[Inspections:27]BIN:1:=$tempbin
						SAVE RECORD:C53([Inspections:27])
						QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
						LogChanges(->[Combined Inspections:90]BIN:1; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
						//set the value in the log
						VARIABLE TO BLOB:C532($tempBin; $tempBlob)
						FIRST RECORD:C50([Activity Log:59])
						[Activity Log:59]Data:10:=$tempBlob
						SAVE RECORD:C53([Activity Log:59])
						//make the change
						[Combined Inspections:90]BIN:1:=$tempbin
						SAVE RECORD:C53([Combined Inspections:90])
						If ([Combined Inspections:90]BMSInspID:3>0)
							QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
							LogChanges(->[BMS Inspections:44]BIN:2; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
							//set the value in the log
							VARIABLE TO BLOB:C532($tempBin; $tempBlob)
							FIRST RECORD:C50([Activity Log:59])
							[Activity Log:59]Data:10:=$tempBlob
							SAVE RECORD:C53([Activity Log:59])
							//make the change
							[BMS Inspections:44]BIN:2:=$tempbin
							SAVE RECORD:C53([BMS Inspections:44])
							
						End if 
						
						CONFIRM:C162("VALIDATE ALL CHANGES?")
						
						If (OK=1)
							VALIDATE TRANSACTION:C240
						Else 
							CANCEL TRANSACTION:C241
						End if 
						
					End if 
					
			End case 
			
		End if 
	Else 
		ALERT:C41("BIN "+$tempbin+" Does not exist")
	End if 
End if 
