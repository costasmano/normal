If (False:C215)
	//Object Method: [Inspections];"InspectionReview". aDistrictSelect 
	//Drop down to filter Inspections by districts available
	//Jan-2002
	//Values for the array are initialized in the P_ReviewInspections method.
	
	// Modified by: costasmanousakis-(Designer)-(6/2/10 09:58:00)
	Mods_2010_06
	//Do not rely on the On Header event to sort - call INSP_SortReviewList
	// Modified by: costasmanousakis-(Designer)-(6/23/10 08:45:32)
	Mods_2010_06
	//  `use [Bridge MHD NBIS]InspResp instead of [Bridge MHD NBIS]Item2
	// Modified by: costasmanousakis-(Designer)-(10/7/11 12:29:46)
	Mods_2011_10
	//Check for the length of the aDistrictSelect element for the transition to Inspection Resp
	// Modified by: costasmanousakis-(Designer)-(10/8/11 16:16:36)
	Mods_2011_10
	//  `Check for INSP_SelectbyRespNew_b for the transition to Inspection Resp
	// Modified by: costasmanousakis-(Designer)-(10/24/11 11:17:43)
	Mods_2011_10
	//  `USE NAMED SELECTION("UserRegionA") instead of M_GetRegion (It changed the window title)
	// InspRespDescSel_atxt
End if 

SET CURSOR:C469(128)
USE NAMED SELECTION:C332("UserRegionA")

If (Not:C34(INSP_SelectbyRespNew_b))
	QUERY SELECTION:C341([Inspections:27]; [Bridge MHD NBIS:1]InspResp:173="@"+Substring:C12(InspRespDescSel_atxt{InspRespDescSel_atxt}; 6; 1))
Else 
	QUERY SELECTION:C341([Inspections:27]; [Bridge MHD NBIS:1]InspResp:173=InspRespSelect_atxt{InspRespDescSel_atxt})
End if 

INSP_SortReviewList
//vbSortedHeader:=False  `set to re sort according to current header
REDRAW WINDOW:C456
SET CURSOR:C469(0)

RegionTitle