If (False:C215)
	// Object Method: [Inspections];"InspectionReview".bzSub
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
	USE SET:C118("UserSet")
	RegionTitle
	//vbSortedHeader:=False  `set to re sort according to current header
	INSP_SortReviewList
Else 
	ALERT:C41("You must first Highlight Records to use!")
End if 
