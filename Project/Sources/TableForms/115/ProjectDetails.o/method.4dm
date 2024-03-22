// ----------------------------------------------------
// Form Method: ProjectDetails.o
// User name (OS): cjmiller
// Date and time: 10/19/06, 12:17:58
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_TimeTracking
	Mods_2007_CJMv2  //r060   `05/16/07, 12:13:32  `Add code to control access 
	// Modified by: root-(Designer)-(10/16/2007 15:23:48)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(6/29/08 10:20:04)
	Mods_2008_CM_5404  //Higlight the last record we were in
	// Modified by: costasmanousakis-(Designer)-(10/6/08 11:16:47)
	Mods_2008_CM_5404
	//Change set name PRJLASTRECORDIN to $PRJLASTRECORDIN (local set)
	// Modified by: costasmanousakis-(Designer)-(2/13/09 16:32:03)
	Mods_2009_CM_5404
	//  `Changed Last column from Last Action to Status per request from F. Nohelty
	// Modified by: costasmanousakis-(Designer)-(9/14/09 11:10:09)
	Mods_2009_09
	//  `Adjusted the method to call PRJ_QR_ReturnBridge
	
End if 
Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Load:K2:1)
		ut_RetrievePersArraysDoc  //Mods_TimeTracking
		
		ut_SetSortColumns(7; 1)
		SortColumn1_l:=0
		ut_PRJSortByBridge
		PRJ_SetAccess
		
	: (Form event code:C388=On Display Detail:K2:22)
		PRJ_LoadDesignContractForOutput
		PRJ_SetUpStructuralPrjMgr(->[PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39)
		PRJ_DEBridgeNo_s:=PRJ_QR_ReturnBridge
		
	: (Form event code:C388=On Activate:K2:9) | (Form event code:C388=On Close Detail:K2:24)
		ut_PRJSetWindowTitle("Project Lists"; ->[PRJ_ProjectDetails:115])
		UpdatFilesPalet
		C_LONGINT:C283($Width_l; $Height_l)
		FORM GET PROPERTIES:C674([PRJ_ProjectDetails:115]; "ProjectDetails.o"; $Width_l; $Height_l)
		ut_ResizeWindow(Frontmost window:C447; $Width_l; 600)
		If (Form event code:C388=On Close Detail:K2:24)
			HIGHLIGHT RECORDS:C656("$PRJLASTRECORDIN")
			CLEAR SET:C117("$PRJLASTRECORDIN")
		End if 
		
End case 
//End Form Method:  ProjectDetails.o