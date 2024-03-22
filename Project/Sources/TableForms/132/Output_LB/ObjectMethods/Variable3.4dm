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
SRC_SearchByBridge(->[ScourPOA:132]; ->[ScourPOA:132]BIN:2; ->[Bridge MHD NBIS:1]BDEPT:1; ->[Bridge MHD NBIS:1]Bridge Key:2; True:C214)
GET AUTOMATIC RELATIONS:C899($oneRel_b; $manyRel_b)
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
ORDER BY:C49([ScourPOA:132]; [Bridge MHD NBIS:1]BDEPT:1)
SET AUTOMATIC RELATIONS:C310($oneRel_b; $manyRel_b)

If (Current user:C182="designer")
	C_POINTER:C301($LB_ptr)
	$LB_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "ScourPOA_LB")
	REDRAW:C174($LB_ptr->)
	
Else 
	REDRAW WINDOW:C456
End if 
WindowTitle