//%attributes = {"invisible":true}
//Method: RatRep_InitialSetup
//Description
// utility to log vehicle type records and set the sequence
//  - run only once at first implementation on Boston Server
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/05/19, 13:49:40
	// ----------------------------------------------------
	//Created : 
	Mods_2019_12
End if 
//
If (User in group:C338(Current user:C182; "Design Access Group"))
	ALERT:C41("This should be run on the Boston Server only once after updating for the new Vehicle types")
	
	CONFIRM:C162("Are you sure you want to run the setup method?")
	If (OK=1)
		C_OBJECT:C1216($progress_o)
		$progress_o:=ProgressNew("Setting up"; 5; False:C215; ""; 3)
		
		READ ONLY:C145(*)
		//load the records for [RatingVehicleTypes]
		If (Records in table:C83([RatingVehicleTypes:190])=0)
			Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Loading Vehicle Types")
			UpdateProgressNew($progress_o; 1)
			ut_ExportImportAuxTables
		End if 
		
		//record act log records
		CONFIRM:C162("Create NRC and GRP act log records for "+String:C10(Records in table:C83([RatingVehicleTypes:190]))+\
			" records in [RatingVehicleTypes] table?")
		
		If (OK=1)
			Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Creating Activity log records")
			UpdateProgressNew($progress_o; 2)
			
			InitChangeStack(1)
			C_TEXT:C284(vsForward)
			C_LONGINT:C283($rec_L)
			C_OBJECT:C1216($progress_o)
			//start the bar
			ALL RECORDS:C47([RatingVehicleTypes:190])
			//start the new bar
			C_OBJECT:C1216($progress2_o)
			$progress2_o:=ProgressNew("Activity log records"; Records in selection:C76([RatingVehicleTypes:190]); False:C215; " Vehicletype"; 3)
			
			
			For ($rec_L; 1; Records in selection:C76([RatingVehicleTypes:190]))
				//update progress
				//update progress
				UpdateProgressNew($progress2_o; $rec_L)
				
				//check if progress stopped
				If (Progress Stopped(OB Get:C1224($progress2_o; "progress"; Is longint:K8:6)))
					//abort loop
					$rec_L:=Records in selection:C76([RatingVehicleTypes:190])+1
				Else 
					GOTO SELECTED RECORD:C245([RatingVehicleTypes:190]; $rec_L)
					LOAD RECORD:C52([RatingVehicleTypes:190])
					LogNewRecordChanges(->[RatingVehicleTypes:190]VehicleID:1; ->[RatingVehicleTypes:190]VehicleID:1; \
						->[RatingVehicleTypes:190]VehicleID:1; 0; Table name:C256(->[RatingVehicleTypes:190]); 1)
					
				End if 
			End for 
			
			//quit progress
			Progress QUIT(OB Get:C1224($progress2_o; "progress"; Is longint:K8:6))
			
		End if 
		
		//update the sequences table - no need to log this and does not hurt to run it
		Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Checking the [Sequences] record")
		UpdateProgressNew($progress_o; 3)
		ut_FixSequence(Table name:C256(->[RatingVehicleTypes:190]); ->[RatingVehicleTypes:190]VehicleID:1)
		
		//update the LB_Query table
		CONFIRM:C162("Update LB_Query record for Ratings query?")
		If (OK=1)
			
			Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Updating [LB_Query] record")
			UpdateProgressNew($progress_o; 4)
			QUERY:C277([LB_QueryTable:147]; [LB_QueryTable:147]QueryName_s:1="Ratings")
			If (ut_LoadRecordInteractive(->[LB_QueryTable:147]))
				[LB_QueryTable:147]ColumnWidths_txt:2:="80, 80, 160, 40, 40, 45, 45, 45, 45, 45, 45, 45, 45, 45 ,45"
				LogChanges(->[LB_QueryTable:147]ColumnWidths_txt:2; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0)
				SAVE RECORD:C53([LB_QueryTable:147])
			End if 
			
		End if 
		
		//need xbox.png and blankbox.png in resources
		//check needed files in resources
		Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Checking needed resources")
		UpdateProgressNew($progress_o; 5)
		
		C_TEXT:C284($Err_txt)
		$Err_txt:=""
		If ((Test path name:C476(Get 4D folder:C485(Current resources folder:K5:16)+"xbox.png")#Is a document:K24:1))
			$Err_txt:=$Err_txt+"Missing file : Resources"+Folder separator:K24:12+"xbox.png"+"\n"
		End if 
		
		If ((Test path name:C476(Get 4D folder:C485(Current resources folder:K5:16)+"blankbox.png")#Is a document:K24:1))
			$Err_txt:=$Err_txt+"Missing file : Resources"+Folder separator:K24:12+"blankbox.png"+"\n"
		End if 
		If ((Test path name:C476(Get 4D folder:C485(Current resources folder:K5:16)+"Utility"+\
			Folder separator:K24:12+"mountBoston.scpt")#Is a document:K24:1))
			$Err_txt:=$Err_txt+"Missing file : Resources"+Folder separator:K24:12+"Utility"+\
				Folder separator:K24:12+"mountBoston.scpt"+"\n"
		End if 
		
		Case of 
			: ($Err_txt#"")
				ALERT:C41("There are missing resources in Bostons server! Add them and rerun this method!\n"+$Err_txt)
				
			Else 
				ALERT:C41("Create act log records for xbox.png blankbox.png and Utility/mountBoston")
				Resource_control
		End case 
		
		//quit progress
		Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
		
		ALERT:C41("Done")
		
	Else 
		ALERT:C41("Quiting")
	End if 
	
End if 

//End RatRep_InitialSetup