If (False:C215)
	// Object Method: [Inspections];"InspectionReview".bzPrint
	// Description
	// Object method to print selected (Highlighted) inspections
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(6/2/10 09:58:00)
	Mods_2010_06
	//  `Do not use set, use named selection, so no need to sort again
	//  `Also keep the records selected highlited at the end
	// Modified by: costasmanousakis-(Designer)-(8/27/10 12:31:57)
	Mods_2010_08
	//  `Added all known inspection types
	//  `Added calls to read only befroe abd read write after
	//  `Changed method of looping thru records : Go thru the whole selection and check if the record is highlighted
	// Modified by: costasmanousakis-(Designer)-(8/30/10 10:08:55)
	Mods_2010_08
	//  `Create a selection that is in the same order as the current llist from the UserSet 
	//  `- use new method ut_SelectionFromUserSet
	//  `Also make sure the BMS Inspection record and CUs are loaded if needed
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(4/13/11 15:13:53)
	Mods_2011_04
	//  `Added code to build the TeamMember area
	// Modified by: Costas Manousakis-(Designer)-(3/9/17 15:01:42)
	Mods_2017_03
	//  `use new method INSP_PrintInspType ; added declaration of INSP_PageCountDone_b;vbInspectionLocked
	//  ` use INSP_Read_Write_Tables and ut_db_RestoreROState
End if 

C_LONGINT:C283($LRecsInSet; $i; $RecordsInSele_L)  //Command Replaced was o_C_INTEGER
$LRecsInSet:=Records in set:C195("UserSet")
If ($LRecsInSet>0)
	ut_SelectionFromUserSet("CREATE"; ->[Inspections:27]; "StartingInspects"; "TempUserSet1")
	C_BLOB:C604($ROState_x)
	$ROState_x:=ut_db_SaveROState
	INSP_Read_Write_Tables("READ")
	FIRST RECORD:C50([Inspections:27])
	For ($i; 1; $LRecsInSet)
		RELATE ONE:C42([Inspections:27]Insp Type:6)
		RELATE ONE:C42([Inspections:27]BIN:1)
		QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
		LOAD RECORD:C52([Combined Inspections:90])
		If ([Combined Inspections:90]BMSInspID:3>0)
			QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
			DISPL_CUs
			QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
		Else 
			UNLOAD RECORD:C212([BMS Inspections:44])
			UNLOAD RECORD:C212([Cond Units:45])
			UNLOAD RECORD:C212([BMS Field Trip:56])
			REDUCE SELECTION:C351([BMS Inspections:44]; 0)
			REDUCE SELECTION:C351([Cond Units:45]; 0)
			REDUCE SELECTION:C351([BMS Field Trip:56]; 0)
		End if 
		C_BOOLEAN:C305(INSP_PageCountDone_b; vbInspectionLocked)
		vbInspectionLocked:=True:C214
		INSP_PageCountDone_b:=False:C215
		INSP_PrintInspType
		
		NEXT RECORD:C51([Inspections:27])
	End for 
	
	ut_db_RestoreROState($ROState_x)
	
	ut_SelectionFromUserSet("RESTORE"; ->[Inspections:27]; "StartingInspects"; "TempUserSet1")
	
Else 
	ALERT:C41("You must first Highlight Records to Print!")
End if 