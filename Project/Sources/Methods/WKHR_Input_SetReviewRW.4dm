//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/28/05, 21:30:59
	// ----------------------------------------------------
	// Method: WKHR_Input_SetReviewRW
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-(2/26/2007 14:28:34)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(3/19/09 16:42:23)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 16:52:52  `("WKHRMODS")
	// Modified by: costasmanousakis-(Designer)-(3/26/09 15:56:08)
	Mods_2009_03
	//Declared and initialized help text variable WK_EnableEditMsg_s
End if 
OBJECT SET VISIBLE:C603(*; "@Avr@"; True:C214)
WKHR_LockEstimate:=True:C214
OBJECT SET ENTERABLE:C238(*; "@Cons_@"; False:C215)
OBJECT SET ENABLED:C1123(*; "ClearWKHRAllBtn@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(*; "DeleteRowBtn"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(*; "AddToList"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET VISIBLE:C603(*; "ReadWriteBtn"; True:C214)
OBJECT SET ENABLED:C1123(*; "AccptReview"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
C_TEXT:C284(WK_EnableEditMsg_s)
If (WKHR_LockEstimate)
	WK_EnableEditMsg_s:="Click to Edit/Configure Proposal"
	ReadWriteBtn:=1
Else 
	WK_EnableEditMsg_s:="Click to Stop Editing Proposal"
	ReadWriteBtn:=0
End if 
If (WKHR_InputStatus=2)  //coming from list
	OBJECT SET ENABLED:C1123(*; "ToolSetButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End if 

If ([Work_Estimate:103]WkHrEstApproved:18=BMS Approved)
	OBJECT SET VISIBLE:C603(*; "UpdateAssignment@"; True:C214)  //Mods_2007_CM07
End if 

//Load the Addendum if any
If ([Work_Estimate:103]AddendumNo:29>0)
	QUERY:C277([Addendum_Maintenance:102]; [Addendum_Maintenance:102]AssignID:3=[Work_Estimate:103]AssignID:2; *)
	QUERY:C277([Addendum_Maintenance:102];  & [Addendum_Maintenance:102]AddendumNo:2=[Work_Estimate:103]AddendumNo:29)
End if 
