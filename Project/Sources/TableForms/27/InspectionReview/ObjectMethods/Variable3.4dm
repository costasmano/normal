If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/17/07, 09:32:02
	// ----------------------------------------------------
	// Object Method: [Inspections];"InspectionReview".bzSearch
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(6/2/10 09:58:00)
	Mods_2010_06
	//Do not rely on the On Header event to sort - call INSP_SortReviewList
	
End if 
M_SearchBrgInInspections
aDistrictSelect:=0
//vbSortedHeader:=False  `set to re sort according to current header
INSP_SortReviewList
REDRAW WINDOW:C456
RegionTitle