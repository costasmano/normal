//%attributes = {"invisible":true}
If (False:C215)
	//G_Insp_SaveContinue
	//Method used in button to Save without exiting and Insp Input form.
	
	//Prompt user if Inspection report is completed, and ready to be reviewed.
	Mods_2005_CM01
	Mods_2005_CM04
	Mods_2005_CM06
	Mods_2005_CM11
	// Modified by: costasmanousakis-(Designer)-(11/15/05 17:56:05)
	Mods_2005_CM18
	// Modified by: costasmanousakis-(Designer)-(11/17/05 15:02:45)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/16/2005 11:10:02)
	Mods_2005_CM20
End if 

C_TEXT:C284(CurCat)  // Command Replaced was o_C_STRING length was 3

CONFIRM:C162("Save Inspection Data?")
If (Ok=1)
	INSP_SaveRecords
	
	//restart the change stack
	InitChangeStack(1)
	InitChangeStack(2)  //sub records
	InitChangeStack(3)  //bms insp
	InitChangeStack(4)  //COMBINED insp
	
	START TRANSACTION:C239  //start a new transaction
	//restore Elements and photos
	
	G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)
	If (Records in selection:C76([ElementsSafety:29])>0)
		If (CurCat#"ALL")
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3=CurCat)
		End if 
		
		If ([Inspections:27]Insp Type:6="RTA")
			ORDER BY:C49([ElementsSafety:29]; [ElementDict:30]Category:3; >; [ElementDict:30]FullLabelArch:14; >)
		Else 
			ORDER BY:C49([ElementsSafety:29]; [ElementDict:30]Category:3; >; [ElementDict:30]FullLabel:13; >)
		End if 
	End if 
	If (Records in selection:C76([Standard Photos:36])>0)
		G_SortInspImages
	End if 
	If ([BMS Inspections:44]Inspection ID:1>0)
		DISPL_CUs
		QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Inspection ID:1=[BMS Inspections:44]Inspection ID:1)
	End if 
End if 