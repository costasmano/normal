//%attributes = {"invisible":true}
// Method: ut_RenameInspAgency
// Description
//  ` Rename an Inspection agency. 
//  ` Involves changing the Agency field in Iinspection reports [inspections] , [bms inspections] logchanges
//  ` changing the [Personnel]Employer field in the [Personnel] table - logchanges
//  `[Cons Inspection]AssignConName - log changes
//  `[Contracts]ConsltName - no log
//  `[Conslt Address]ConsltName - log changes
//  `[Conslt Rating]AssignRatCons ????
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/17/10, 14:15:56
	// ----------------------------------------------------
	//******
	//Need to change the Lists!!!!!!
	//*****
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: Costas Manousakis-(Designer)-(2022-03-21 11:35:10)
	Mods_2022_03
	//  `modified to request old and new names ; combine [Inspections] and [bms inspections] to use the new vsForward
	//  `confirm each table after inspections.
End if 

If (User in group:C338(Current user:C182; "Design Access Group"))
	C_TEXT:C284($OldName_txt; $NewName_txt)
	$OldName_txt:=Request:C163("Enter old agency name")
	If ($OldName_txt#"")
		
		$NewName_txt:=Request:C163("Enter new agency name")
		$NewName_txt:=f_TrimStr($NewName_txt; True:C214; True:C214)
		If ($NewName_txt#"")
			
			START TRANSACTION:C239
			READ WRITE:C146([Personnel:42])
			SHORT_MESSAGE("Changing Personnel....")
			QUERY:C277([Personnel:42]; [Personnel:42]Employer:9=$OldName_txt)
			FIRST RECORD:C50([Personnel:42])
			While (Not:C34(End selection:C36([Personnel:42])))
				If (ut_LoadRecordInteractive(->[Personnel:42]))
					[Personnel:42]Employer:9:=$NewName_txt
					LogChanges(->[Personnel:42]Employer:9; ->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; 1)
					SAVE RECORD:C53([Personnel:42])
				End if 
				NEXT RECORD:C51([Personnel:42])
			End while 
			READ ONLY:C145([Personnel:42])
			MESSAGE:C88(Char:C90(13)+"Inspections...")
			
			QUERY:C277([Inspections:27]; [Inspections:27]InspApproved:167#BMS Approved)
			QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Agency:156=$OldName_txt)
			MESSAGE:C88(String:C10(Records in selection:C76([Inspections:27])))
			FIRST RECORD:C50([Inspections:27])
			While (Not:C34(End selection:C36([Inspections:27])))
				If (ut_LoadRecordInteractive(->[Inspections:27]))
					[Inspections:27]Agency:156:=$NewName_txt
					vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; [Inspections:27]Insp Type:6; [Inspections:27]TeamLeader:4)
					LogChanges(->[Inspections:27]Agency:156; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
					SAVE RECORD:C53([Inspections:27])
					QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
					QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
					
					If (Records in selection:C76([BMS Inspections:44])=1)
						If (ut_LoadRecordInteractive(->[BMS Inspections:44]))
							[BMS Inspections:44]Agency:13:=$NewName_txt
							LogChanges(->[BMS Inspections:44]Agency:13; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
							SAVE RECORD:C53([BMS Inspections:44])
						End if 
					End if 
					
				End if 
				NEXT RECORD:C51([Inspections:27])
			End while 
			READ ONLY:C145([Inspections:27])
			READ ONLY:C145([BMS Inspections:44])
			
			CONFIRM:C162("Update Consultant Address table?")
			
			If (OK=1)
				MESSAGE:C88(Char:C90(13)+"Conslt Address...")
				READ WRITE:C146([Conslt Address:77])
				QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2=$OldName_txt)
				MESSAGE:C88(String:C10(Records in selection:C76([Conslt Address:77])))
				FIRST RECORD:C50([Conslt Address:77])
				While (Not:C34(End selection:C36([Conslt Address:77])))
					If (ut_LoadRecordInteractive(->[Conslt Address:77]))
						[Conslt Address:77]ConsltName:2:=$NewName_txt
						LogChanges(->[Conslt Address:77]ConsltName:2; ->[Conslt Address:77]ConsltAddressID:1; ->[Conslt Address:77]ConsltAddressID:1; ->[Conslt Address:77]ConsltAddressID:1; 1)
						SAVE RECORD:C53([Conslt Address:77])
					End if 
					NEXT RECORD:C51([Conslt Address:77])
				End while 
				READ ONLY:C145([Conslt Address:77])
				
			End if 
			
			CONFIRM:C162("Update Contracts table?")
			
			If (OK=1)
				MESSAGE:C88(Char:C90(13)+"Contracts...")
				READ WRITE:C146([Contracts:79])
				QUERY:C277([Contracts:79]; [Contracts:79]ConsltName:3=$OldName_txt)
				MESSAGE:C88(String:C10(Records in selection:C76([Contracts:79])))
				FIRST RECORD:C50([Contracts:79])
				While (Not:C34(End selection:C36([Contracts:79])))
					If (ut_LoadRecordInteractive(->[Contracts:79]))
						[Contracts:79]ConsltName:3:=$NewName_txt
						SAVE RECORD:C53([Contracts:79])
					End if 
					NEXT RECORD:C51([Contracts:79])
				End while 
				READ ONLY:C145([Contracts:79])
				
			End if 
			
			CONFIRM:C162("Update Consultant Inspections table?")
			
			If (OK=1)
				MESSAGE:C88(Char:C90(13)+"Cons Inspections...")
				READ WRITE:C146([Cons Inspection:64])
				QUERY:C277([Cons Inspection:64]; [Cons Inspection:64]AssignConName:5=$OldName_txt)
				MESSAGE:C88(String:C10(Records in selection:C76([Cons Inspection:64])))
				FIRST RECORD:C50([Cons Inspection:64])
				While (Not:C34(End selection:C36([Cons Inspection:64])))
					If (ut_LoadRecordInteractive(->[Cons Inspection:64]))
						[Cons Inspection:64]AssignConName:5:=$NewName_txt
						LogChanges(->[Cons Inspection:64]AssignConName:5; ->[Bridge MHD NBIS:1]BIN:3; ->[Cons Inspection:64]BIN:1; ->[Cons Inspection:64]ConsInspectionID:32; 1)
						SAVE RECORD:C53([Cons Inspection:64])
					End if 
					
					NEXT RECORD:C51([Cons Inspection:64])
				End while 
				READ ONLY:C145([Cons Inspection:64])
				
			End if 
			
			CONFIRM:C162("Update Consultant Ratings table?")
			If (Ok=1)
				
				MESSAGE:C88(Char:C90(13)+"Cons Ratings...")
				READ WRITE:C146([Conslt Rating:63])
				QUERY:C277([Conslt Rating:63]; [Conslt Rating:63]AssignRatCons:5=$OldName_txt)
				MESSAGE:C88(String:C10(Records in selection:C76([Conslt Rating:63])))
				FIRST RECORD:C50([Conslt Rating:63])
				While (Not:C34(End selection:C36([Conslt Rating:63])))
					If (ut_LoadRecordInteractive(->[Conslt Rating:63]))
						[Conslt Rating:63]AssignRatCons:5:=$NewName_txt
						LogChanges(->[Conslt Rating:63]AssignRatCons:5; ->[Bridge MHD NBIS:1]BIN:3; ->[Conslt Rating:63]BIN:1; ->[Conslt Rating:63]ConsltRatingID:42; 1)
						SAVE RECORD:C53([Conslt Rating:63])
					End if 
					
					NEXT RECORD:C51([Conslt Rating:63])
				End while 
				READ ONLY:C145([Conslt Rating:63])
				
			End if 
			
			CLOSE WINDOW:C154
			CONFIRM:C162("Validate Changes or Cancel Transaction??"; "Validate"; "Cancel")
			If (Ok=1)
				VALIDATE TRANSACTION:C240
				ALERT:C41("Remember to update the structure lists!")
				
			Else 
				CANCEL TRANSACTION:C241
			End if 
			
		End if 
	End if 
	
End if 