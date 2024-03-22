If (False:C215)
	//: 
	//Object Method [Inspections] ;"InspectionReview".bzSearchLay
	// Modified by: costasmanousakis-(Designer)-(12/15/2005 09:42:01)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(4/10/2006 14:10:21)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(6/2/10 09:58:00)
	Mods_2010_06
	//Do not rely on the On Header event to sort - call INSP_SortReviewList
	// Modified by: Costas Manousakis-(Designer)-(1/14/13 10:17:04)
	Mods_2013_01
	//  `Use new Variables ◊INSP_AreaEng_b | ◊INSP_UOEng_b to access the full Query
End if 

If (User in group:C338(Current user:C182; "Design Access Group") | User in group:C338(Current user:C182; "Area Engineers") | <>INSP_AreaEng_b | <>INSP_UOEng_b)
	QUERY:C277([Inspections:27])
Else 
	
	QUERY SELECTION:C341([Inspections:27])
End if 
If (OK=1)
	aDistrictSelect:=0
	//vbSortedHeader:=False  `set to re sort according to current header
	INSP_SortReviewList
	REDRAW WINDOW:C456
	RegionTitle
End if 
