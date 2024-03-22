//%attributes = {"invisible":true}
If (False:C215)
	//  InitGrpDelete 
	//Initializa array of Grouped deletions IDs.
	//Must be called before  a PushGrpdelete/FlushGrpDeletions 
	
	Mods_2005_CM04
End if 

//reset array
ARRAY TEXT:C222(arr_DeletedIDs; 0)  //Command Replaced was o_ARRAY string length was 80