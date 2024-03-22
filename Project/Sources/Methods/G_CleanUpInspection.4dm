//%attributes = {"invisible":true}
If (False:C215)
	//G_CleanUpInspection
	//Method to remove [ElementsSafety] records which are not relevant
	//to the current Inspection. I.E. records that have a rating of N and no comments.
	//This method should be executed upon final approval of the Inspection report.
	//Created : Dec-2001
	
	Mods_2005_CM04
	// Modified by: costasmanousakis-(Designer)-(2/17/2006 13:33:43)
	Mods_2006_CM03
End if 
C_LONGINT:C283($i; $numElmts)

//Gather all records of [ElementsSafety]
G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)
$numElmts:=Records in selection:C76([ElementsSafety:29])
If ($numElmts>0)
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2="N"; *)
	QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]AltRating:21="N"; *)
	QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]AltRating:21="N")
	QUERY SELECTION BY FORMULA:C207([ElementsSafety:29]; (BLOB size:C605([ElementsSafety:29]ElmComments:23)=0))
End if 
$numElmts:=Records in selection:C76([ElementsSafety:29])
If ($numElmts>0)
	InitGrpDelete
	
	FIRST RECORD:C50([ElementsSafety:29])
	//Check each record
	For ($i; 1; $numElmts)
		//if all Ratings = "N" and size of comment block =0
		If (([ElementsSafety:29]Rating:2="N") & ([ElementsSafety:29]AltRating:21="N") & (BLOB size:C605([ElementsSafety:29]ElmComments:23)=0))
			//log the deletion    
			PushGrpDelete(->[ElementsSafety:29]ElmSafetyID:7)
		End if 
		NEXT RECORD:C51([ElementsSafety:29])
	End for 
	FlushGrpDeletions(->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
	
	DELETE SELECTION:C66([ElementsSafety:29])
End if 