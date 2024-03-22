If (False:C215)
	//Object method bzAccept form [Inspections]Dive Template
	//Accept Button
	//Prompt user if Inspection report is completed, and ready to be reviewed.
	
	Mods_2005_CM01
	Mods_2005_CM13
	// Modified by: costasmanousakis-(Designer)-(4/19/2006 14:10:38)
	Mods_2006_CMy2
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 14:00:59
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23T00:00:00 13:44:34)
	Mods_2021_12_bug
	//  `call INSP_SaveInspCommts
End if 
//INSP_Check4DWriteChgs 
INSP_SaveInspCommts

CONFIRM:C162("Save Inspection Data?")
If (Ok=1)
	
	INSP_UWSaveInsp
	
	SAVE RECORD:C53([Inspections:27])
	
	FLUSH CACHE:C297  //make sure all is saved...
	
	//restart the change stack
	InitChangeStack(1)
	InitChangeStack(4)
	
	//resort Elements
	G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)
	
	If (CurCat#"ALL")
		QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3=CurCat)
	End if 
	//ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>) 
	ORDER BY:C49([ElementsSafety:29]; [ElementDict:30]Category:3; >; [ElementDict:30]FullLabel:13; >)
	
	//resort images
	G_SortInspImages
End if 