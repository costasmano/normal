If (False:C215)
	// Method: Object Method: [Inspections];"InspectionReview".bzOmit
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(6/2/10 09:58:00)
	Mods_2010_06
	//Do not rely on the On Header event to sort - call INSP_SortReviewList
	
End if 

C_LONGINT:C283($LRecsInSet)
$LRecsInSet:=Records in set:C195("UserSet")
If ($LRecsInSet>0)
	COPY SET:C600("UserSet"; "TempSet1")
	CREATE SET:C116(pFile->; "OriginalSelSet")
	DIFFERENCE:C122("OriginalSelSet"; "TempSet1"; "NonHighlightedSet")
	USE SET:C118("NonHighlightedSet")
	CLEAR SET:C117("NonHighlightedSet")
	CLEAR SET:C117("OriginalSelSet")
	CLEAR SET:C117("TempSet1")
	RegionTitle
	
	//vbSortedHeader:=False  `set to re sort according to current header
	INSP_SortReviewList
Else 
	ALERT:C41("You must first Highlight Records to omit!")
End if 
