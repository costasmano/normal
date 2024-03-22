//%attributes = {"invisible":true}
If (False:C215)
	//ADD_INSPECT
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	//Add a new inspection report
	//
	//Modified 6/2001
	//Set Item93B dive inspection date to current date also.
End if 
C_TEXT:C284($vsInspType)  // Command Replaced was o_C_STRING length was 3
$vsInspType:=GetInspType
If ($vsInspType#"")
	FORM SET INPUT:C55([Inspections:27]; "BlankStarter")  //Changed Dec-2001
	CREATE RECORD:C68([Inspections:27])  //Add a record for a new inspection
	//Set default values
	Inc_Sequence("Inspections"; ->[Inspections:27]InspID:2)
	[Inspections:27]BIN:1:=[Bridge MHD NBIS:1]BIN:3
	LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; "Inspections")
	InitChangeStack(1)
	[Inspections:27]Insp Type:6:=$vsInspType
	PushChange(1; ->[Inspections:27]Insp Type:6)
	[Inspections:27]InspReviewed:12:=BMS Not Reviewed
	PushChange(1; ->[Inspections:27]InspReviewed:12)
	[Inspections:27]InspApproved:167:=BMS Not Reviewed
	PushChange(1; ->[Inspections:27]InspApproved:167)
	[Inspections:27]InspComplete:168:=False:C215
	PushChange(1; ->[Inspections:27]InspComplete:168)
	[Inspections:27]Insp Date:78:=Current date:C33(*)
	PushChange(1; ->[Inspections:27]Insp Date:78)
	
	G_SIA2Inspection  //get SIA data into [Inspections] fields  
	//Need a creation date before saving
	[Inspections:27]DateCreated:135:=Current date:C33(*)  //+◊LDifference  `Add the difference between the server date
	PushChange(1; ->[Inspections:27]DateCreated:135)
	[Inspections:27]TimeCreated:136:=Current time:C178(*)  //+◊hDifference  `Add the difference between the server time
	PushChange(1; ->[Inspections:27]TimeCreated:136)
	[Inspections:27]Modified By:134:=Current user:C182
	PushChange(1; ->[Inspections:27]Modified By:134)
	
	FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
	SAVE RECORD:C53([Inspections:27])
	//Go to configure inspection right away
	SET CURSOR:C469(4)
	SHORT_MESSAGE("Configuring Inspection...")
	G_AddDefInspElmts
	SET CURSOR:C469(0)
	CLOSE WINDOW:C154
	
	MODIFY RECORD:C57([Inspections:27])
	RELATE MANY:C262([Bridge MHD NBIS:1])
	ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
End if 