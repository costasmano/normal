If (False:C215)
	// Method: Object Method: [Inspections];"InspectionReview".bzAll
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(6/2/10 09:58:00)
	Mods_2010_06
	//Do not rely on the On Header event to sort - call INSP_SortReviewList
End if 

M_GetRegion
//vbSortedHeader:=False  `set to re sort according to current header
INSP_SortReviewList
aDistrictSelect:=0
REDRAW WINDOW:C456