//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/03/07, 09:35:11
	// ----------------------------------------------------
	// Method: ut_LoadBridgeDesRecs
	// Description
	// Method to load/update  [bridge design] records to a district db.
	// To be used to transfer these records from the Boston db where changes in
	// that table have not been getting logged.
	//  `Step one is to create the export file while on the Boston server.
	//  `Then import that file on the District server.
	// Will create local Activity log entries so that district users can get these records.
	// Will also create Record Resolutions.
	// Will prompt whether actlog records will be created, to address the case when it is run
	// on the External server.
	// 
	// Parameters
	// $1 : $Option : "EXPORT"|"IMPORT"
	//
	// ex : ut_LoadBridgeDesRecs("IMPORT")
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(8/11/08 10:22:27)
	Mods_2008_CM_5404  // ("Various")
	//Use method X_CleanIDResTable
	// Modified by: costasmanousakis-(Designer)-(4/22/09 12:34:17)
	Mods_2009_04
	//  `Added ".4D@" to the Structure file comparison for the new 2004 type extensions.
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TEXT:C284($1)
READ ONLY:C145([Bridge MHD NBIS:1])
Case of 
	: ($1="EXPORT")
		ALERT:C41("Exporting all Bridge design records")
		C_TEXT:C284($ExportFile; $ExportHeader; $TargetDir)
		C_LONGINT:C283($NumTeam_L; $NumElmts_L; $NumPhotos_L; $NumPontisElmt_L; $NumPontisTm_L; $i)
		$ExportFile:=String:C10(Year of:C25(Current date:C33(*)); "0000")+String:C10(Month of:C24(Current date:C33(*)); "00")+String:C10(Day of:C23(Current date:C33(*)); "00")+"-"+String:C10(Current time:C178(*))
		$ExportFile:=Replace string:C233($ExportFile; ":"; "")
		$ExportFile:="BrgDes-"+$ExportFile+".export"
		$TargetDir:=Select folder:C670("Select folder for Export file")
		If (OK=1)
			C_BOOLEAN:C305($CreateFile_b)
			$CreateFile_b:=True:C214
			If (Test path name:C476($TargetDir+$ExportFile)=Is a document:K24:1)
				CONFIRM:C162("File "+$ExportFile+" already exists in folder "+$TargetDir+"! Overwrite or Cancel?"; "Overwrite"; "Cancel")
				If (OK=1)
				Else 
					$CreateFile_b:=False:C215
				End if 
			End if 
			If ($CreateFile_b)
				SET CHANNEL:C77(10; $TargetDir+$ExportFile)  //Open a channel for a document
				$ExportHeader:="BridgeDesignExport"
				SEND VARIABLE:C80($ExportHeader)
				READ ONLY:C145([Bridge Design:75])
				SET CURSOR:C469(4)
				SHORT_MESSAGE("Exporting....")
				ALL RECORDS:C47([Bridge Design:75])
				FIRST RECORD:C50([Bridge Design:75])
				While (Not:C34(End selection:C36([Bridge Design:75])))
					SEND RECORD:C78([Bridge Design:75])
					NEXT RECORD:C51([Bridge Design:75])
				End while 
				SET CHANNEL:C77(11)  //close file
				READ WRITE:C146([Bridge Design:75])
				CLOSE WINDOW:C154
				SET CURSOR:C469(0)
				ALERT:C41("Created export file "+$TargetDir+$ExportFile)
			End if 
			
		End if 
		
	: ($1="IMPORT")
		If (Structure file:C489="MHD BMS.4D@")
			ALERT:C41("Cannot run this on the Main Boston server!!!!")
		Else 
			C_BOOLEAN:C305($DoLog_b)
			CONFIRM:C162("Create Local Activity Log entries?")
			$DoLog_b:=(OK=1)
			SET CHANNEL:C77(10; "")
			If (Ok=1)
				C_BOOLEAN:C305(<>NRI_B)
				C_TEXT:C284($ExportHeader)
				RECEIVE VARIABLE:C81($ExportHeader)
				If ($ExportHeader#"BridgeDesignExport")
					ALERT:C41("File <"+Document+"> NOT A VALID BRIDGE DESIGN Export data file!!")
				Else 
					C_LONGINT:C283($CurrTransfMode)
					
					//Set the transfer to no
					$CurrTransfMode:=<>Transfer
					<>Transfer:=-1
					//A) Delete local records
					If (Records in table:C83([Bridge Design:75])>0)
						ALL RECORDS:C47([Bridge Design:75])
						FIRST RECORD:C50([Bridge Design:75])
						For ($i; 1; Records in selection:C76([Bridge Design:75]))
							LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[Bridge Design:75]BIN:1; ->[Bridge Design:75]BridgeDesignID:35; 1)
							NEXT RECORD:C51([Bridge Design:75])
						End for 
						DELETE SELECTION:C66([Bridge Design:75])
					End if 
					C_LONGINT:C283($DesTable; $Num_Fields; $i; $ServerID_L)
					C_POINTER:C301($ForeignKeyFld_ptr; $IDFld_ptr)
					$DesTable:=Table:C252(->[Bridge Design:75])
					$Num_Fields:=Get last field number:C255(->[Bridge Design:75])
					ARRAY POINTER:C280($a_Ptr_Fields; $Num_Fields)
					For ($i; 1; $Num_Fields)
						$a_Ptr_Fields{$i}:=Field:C253($DesTable; $i)
					End for 
					$ForeignKeyFld_ptr:=->[Bridge Design:75]BIN:1
					$IDFld_ptr:=->[Bridge Design:75]BridgeDesignID:35
					RECEIVE RECORD:C79([Bridge Design:75])
					While (OK=1)
						$ServerID_L:=[Bridge Design:75]BridgeDesignID:35  //save server record ID
						Inc_Sequence("BrDesign"; ->[Bridge Design:75]BridgeDesignID:35)  //get a new local ID
						If ($DoLog_b)
							InitChangeStack(1)
							For ($i; 1; $Num_Fields)
								If (($a_Ptr_Fields{$i}#$ForeignKeyFld_ptr) & ($a_Ptr_Fields{$i}#$IDFld_ptr))
									PushChange(1; $a_Ptr_Fields{$i})
								End if 
							End for 
							LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Bridge Design:75]BIN:1; ->[Bridge Design:75]BridgeDesignID:35; 1; "BrDesign")
							FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge Design:75]BIN:1; ->[Bridge Design:75]BridgeDesignID:35; 1)
						End if 
						X_CleanIDResTable($DesTable; String:C10($ServerID_L); "REMOTE")
						G_StoreRecResolution($DesTable; String:C10([Bridge Design:75]BridgeDesignID:35); String:C10($ServerID_L); <>Destination)
						SAVE RECORD:C53([Bridge Design:75])
						RECEIVE RECORD:C79([Bridge Design:75])
					End while 
					
					<>Transfer:=$CurrTransfMode
				End if 
				ALERT:C41("Done importing from File"+Document)
				SET CHANNEL:C77(11)
			End if 
		End if 
		
End case 
READ WRITE:C146([Bridge MHD NBIS:1])