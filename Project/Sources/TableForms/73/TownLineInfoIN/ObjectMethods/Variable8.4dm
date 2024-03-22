If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(5/10/11 14:08:38)
	Mods_2011_05
	//Make sure data changes are logged
End if 

If (([TownLineInfo:73]RefID:3=0) & ([TownLineInfo:73]BDEPT:2#""))  //This is a new record
	[TownLineInfo:73]BIN:1:=[Bridge MHD NBIS:1]BIN:3
	Inc_Sequence("TownLine"; ->[TownLineInfo:73]RefID:3)
	SAVE RECORD:C53([TownLineInfo:73])
	LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[TownLineInfo:73]BIN:1; ->[TownLineInfo:73]RefID:3; 1; "TownLine")
	If ([TownLineInfo:73]RefID:3#0)
		LogChanges(->[TownLineInfo:73]BDEPT:2; ->[Bridge MHD NBIS:1]BIN:3; ->[TownLineInfo:73]BIN:1; ->[TownLineInfo:73]RefID:3; 1)
		If ([Bridge MHD NBIS:1]OnTwnLine:177=False:C215)
			[Bridge MHD NBIS:1]OnTwnLine:177:=True:C214
			LogChanges(->[Bridge MHD NBIS:1]OnTwnLine:177; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
		End if 
	End if 
	
	ACCEPT:C269
Else 
	If (Length:C16(Replace string:C233([TownLineInfo:73]BDEPT:2; "_"; ""))<6)
		ALERT:C41("Please fill in the BDEPT information before saving.")
	Else 
		If ([TownLineInfo:73]RefID:3#0)
			LogChanges(->[TownLineInfo:73]BDEPT:2; ->[Bridge MHD NBIS:1]BIN:3; ->[TownLineInfo:73]BIN:1; ->[TownLineInfo:73]RefID:3; 1)
			If ([Bridge MHD NBIS:1]OnTwnLine:177=False:C215)
				[Bridge MHD NBIS:1]OnTwnLine:177:=True:C214
				LogChanges(->[Bridge MHD NBIS:1]OnTwnLine:177; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
			End if 
		End if 
		ACCEPT:C269
	End if 
End if 