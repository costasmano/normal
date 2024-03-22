//%attributes = {"invisible":true}
If (False:C215)
	//G_AddImage2Insp 
	//Add an image to an inspection.
	//Called from the + button in the List of images page of Inspection
	//input forms
	
	// Modified by: costasmanousakis-(Designer)-(2/17/2006 13:32:27)
	Mods_2006_CM03
	Mods_ChangesMovedto  // moved from v15
End if 
While (OK=1)
	ADD RECORD:C56([Standard Photos:36])
End while 
// for new records...
// reset and re-order images
G_Insp_RelateInsp(->[Standard Photos:36]InspID:1)
INSP_ResetToOnlyImages
G_SortInspImages
