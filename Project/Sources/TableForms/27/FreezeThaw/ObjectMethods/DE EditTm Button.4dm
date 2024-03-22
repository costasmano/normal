//bEditTeam
//[Inspections];"FreezeThaw"
//button to change team members

EditTeam
If (False:C215)
	If (False:C215)
		// Modified by: costasmanousakis-(Designer)-(5/2/11 10:19:27)
		Mods_2011_05
		//  `Freeze thaw Only changes....
		//  `Assign a team leader to the inspection
		
	End if 
	
	C_BOOLEAN:C305($PersRO_b)
	$PersRO_b:=Read only state:C362([Personnel:42])
	READ ONLY:C145([Personnel:42])
	QUERY WITH ARRAY:C644([Personnel:42]Person ID:1; aInspTeamID)
	QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Job Code:8=2)  // Team leaders
	If (Records in selection:C76([Personnel:42])>0)
		ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5)
		FIRST RECORD:C50([Personnel:42])
		If ([Inspections:27]TeamLeader:4#[Personnel:42]Person ID:1)
			[Inspections:27]TeamLeader:4:=[Personnel:42]Person ID:1
			LogLink(->[Inspections:27]TeamLeader:4; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
		End if 
		
	End if 
	
	If (Not:C34($PersRO_b))
		READ WRITE:C146([Personnel:42])
	End if 
	
End if 