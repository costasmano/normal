If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/10/09 09:46:06)
	Mods_2009_12
	//Changes/Additions for new version of POA
	
End if 

CONFIRM:C162("Are you sure you want to delete this Scour Plan of Action?")
If (OK=1)
	
	If (SCPOA_LogChanges_b)
		LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[ScourPOA:132]BIN:2; ->[ScourPOA:132]ScourPOAID:1; 1)
	End if 
	DELETE RECORD:C58([ScourPOA:132])
	CANCEL:C270
End if 
//End Object Method: bDelete