//%attributes = {"invisible":true}
//Method: TownAddressUpdate
//Description
//Method to update the new BDEPT prefix field in Town Address table
//Will match the town name in the official town name field with the Town name in Town data.
//Can be repeated and it will only update differences
// only for DesignUsers
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/13/20, 14:21:14
	// ----------------------------------------------------
	//Created : 
	Mods_2020_05
End if 
//
If (User in group:C338(Current user:C182; "Design Access Group"))
	QUERY:C277([Town Address:78]; [Town Address:78]OfficialTownName:4="City of @"; *)
	QUERY:C277([Town Address:78];  | ; [Town Address:78]OfficialTownName:4="Town of @")
	C_TEXT:C284($missingTownNames_txt; $lockedRecords_txt; $town_txt)
	C_TEXT:C284(VSFORWARD)  // for interpreted execution
	//start the bar
	C_OBJECT:C1216($townUpdateProgress_o)
	$townUpdateProgress_o:=ProgressNew("Updating BDEPT prefix in Town Addresses"; \
		Records in selection:C76([Town Address:78]); \
		True:C214; " Town address"; 3)
	C_LONGINT:C283($FoundSame_L; $updated_L; $missing_L; $locked_L; $scanned_L)
	FIRST RECORD:C50([Town Address:78])
	While (Not:C34(End selection:C36([Town Address:78])))
		//update progress
		UpdateProgressNew($townUpdateProgress_o; Selected record number:C246([Town Address:78]))
		//check if progress stopped
		If (Progress Stopped(OB Get:C1224($townUpdateProgress_o; "progress"; Is longint:K8:6)))
			LAST RECORD:C200([Town Address:78])  // go to last record
			NEXT RECORD:C51([Town Address:78])  // exit selection
		Else 
			$scanned_L:=$scanned_L+1
			$town_txt:=[Town Address:78]OfficialTownName:4
			QUERY:C277([Town Data:2]; [Town Data:2]Town Name:1=Replace string:C233(Replace string:C233([Town Address:78]OfficialTownName:4; "City of "; ""); "Town of "; ""))
			If (Records in selection:C76([Town Data:2])=1)
				If ([Town Address:78]TownBDEPTPrefix:17#[Town Data:2]BDEPT Prefix:2)
					If (ut_LoadRecordInteractive(->[Town Address:78]))
						[Town Address:78]TownBDEPTPrefix:17:=[Town Data:2]BDEPT Prefix:2
						LogChanges(->[Town Address:78]TownBDEPTPrefix:17; ->[Town Address:78]TownAddressID:1; ->[Town Address:78]TownAddressID:1; ->[Town Address:78]TownAddressID:1; 1)
						SAVE RECORD:C53([Town Address:78])
						$updated_L:=$updated_L+1
					Else 
						$locked_L:=$locked_L+1
						$lockedRecords_txt:=$lockedRecords_txt+$town_txt+"\r"
					End if 
				Else 
					$FoundSame_L:=$FoundSame_L+1
				End if 
			Else 
				$missing_L:=$missing_L+1
				$missingTownNames_txt:=$missingTownNames_txt+[Town Address:78]OfficialTownName:4+"\r"
			End if 
			NEXT RECORD:C51([Town Address:78])
		End if 
		
	End while 
	//quit progress
	Progress QUIT(OB Get:C1224($townUpdateProgress_o; "progress"; Is longint:K8:6))
	ut_BigAlert("Update Town Address BDEPT Results\r"+\
		"Found "+String:C10(Records in selection:C76([Town Address:78]))+" City or Town records\r"+\
		"Scanned "+String:C10($scanned_L)+\
		"\rFound Correct "+String:C10($FoundSame_L)+\
		"\rUpdated "+String:C10($updated_L)+\
		"\rThere were "+String:C10($locked_L)+" locked records\r"+\
		$lockedRecords_txt+\
		"\rCould not find BDEPT for "+String:C10($missing_L)+"\r"+\
		$missingTownNames_txt; \
		"Update Results")
	
End if 
//End TownAddressUpdate