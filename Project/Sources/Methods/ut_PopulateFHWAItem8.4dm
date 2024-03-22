//%attributes = {"invisible":true}
//Method: ut_PopulateFHWAItem8
//Description
//  ` Populate the new FHWA Item 8 field in the [Bridge MHD NBIS] for NBI records only
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/15/13, 15:28:25
	// ----------------------------------------------------
	//Created : 
	Mods_2013_03
End if 
//

C_TEXT:C284($ArchiveSetName_txt)

$ArchiveSetName_txt:=Request:C163("Enter Archive Reason to search....")
QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=$ArchiveSetName_txt)

If (Records in selection:C76([BridgeMHDNBISArchive:139])>0)
	
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
	QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWAItem8:229="")
	C_LONGINT:C283($NumRecords_L; $Loop_L; $interval_L)
	$NumRecords_L:=Records in selection:C76([Bridge MHD NBIS:1])
	$interval_L:=20
	
	If ($NumRecords_L\50<$interval_L)
		$interval_L:=$NumRecords_L
	End if 
	
	If ($NumRecords_L>0)
		//start the bar
		C_LONGINT:C283(<>ProgressPID)
		<>ProgressPID:=StartProgress("UpdateFHWAItem8"; "Button"; "Update FHWA Item 8"; "Bridge Records ")
		//initialize the bar
		UpdateProgress(1; $NumRecords_L)
		
		For ($Loop_L; 1; $NumRecords_L)
			GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $Loop_L)
			LOAD RECORD:C52([Bridge MHD NBIS:1])
			QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=$ArchiveSetName_txt; *)
			QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]BIN:3=[Bridge MHD NBIS:1]BIN:3)
			
			If (Records in selection:C76([BridgeMHDNBISArchive:139])=1)
				
				If ([BridgeMHDNBISArchive:139]FHWARecord:173)
					// if last years record was NBI it means it went as that.
					If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]))
						
						If ([BridgeMHDNBISArchive:139]FHWAItem8:228#"")
							//This should not happen, only in case FHWAItem8 was reset since the last submission
							[Bridge MHD NBIS:1]FHWAItem8:229:=[BridgeMHDNBISArchive:139]FHWAItem8:228
						Else 
							//Most common case
							[Bridge MHD NBIS:1]FHWAItem8:229:=[BridgeMHDNBISArchive:139]Item8:203
						End if 
						SAVE RECORD:C53([Bridge MHD NBIS:1])
					End if 
				Else 
					If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]))
						//Last submittal this record was not NBI so probably first submital - so FHWAItem8 is locked to the current Item 8
						[Bridge MHD NBIS:1]FHWAItem8:229:=[Bridge MHD NBIS:1]Item8:206
						SAVE RECORD:C53([Bridge MHD NBIS:1])
					End if 
				End if 
				
			End if 
			
			//update the bar
			If (($Loop_L%$interval_L)=0)
				UpdateProgress($Loop_L; $NumRecords_L)
			End if 
			
			If (<>Abort)
				ALERT:C41("Aborting after completing "+String:C10($Loop_L)+" records out of "+String:C10($NumRecords_L)+" !!!!")
				$Loop_L:=$NumRecords_L+2
			End if 
			
		End for 
		
		//stop the progress bar
		POST OUTSIDE CALL:C329(<>ProgressPID)
	End if 
	
Else 
	ALERT:C41("No Records found in the Archive table for reason "+$ArchiveSetName_txt)
End if 

//End ut_PopulateFHWAItem8