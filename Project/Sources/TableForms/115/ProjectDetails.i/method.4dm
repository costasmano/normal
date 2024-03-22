// ----------------------------------------------------
// Form Method: ProjectDetails.i
// User name (OS): cjmiller
// Date and time: 03/24/06, 10:37:46
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_TimeTracking
	Mods_2006_CJMv2  //03/15/07, 15:59:18` remove * form bridge de variable
	Mods_2006_CJMv2  //04/05/07, 16:05:45`fix when cancelling from selecting federal aid, program, or pr  `oject file
	Mods_2007_CJMv2  //04/26/07, 12:15:37`Integrate Changes made by Costas
	Mods_2007_CJMv2  //r060   `05/16/07, 16:37:11 `Add code to control access 
	
	Mods_PRJSELECTION
	// Modified by: costasmanousakis-(Designer)-(6/21/2007 10:13:53)
	Mods_2007_CJM_v5310
	// Modified by: costasmanousakis-(Designer)-(8/28/2007 15:43:12)
	Mods_2007_CM12_5301  //added use of ◊PRJ_SelectedBIN_txt
	Mods_2007_CM12_5301  //10/01/07 Load RECORD([PRJ_ProjectFile])
	// Modified by: costasmanousakis-(Designer)-(10/29/2007 08:43:45)
	Mods_2007_CM12_5302  //added check in close detail events to re-order lists
	Mods_2007_CJM_v5303  //r003 `10/09/07, 12:08:26`Add Chapter 85
	Mods_2007_CJM_v5303  //r004 `10/23/07, 16:30:01`Add code to allow for overide  consultant
	Mods_2007_CJM_v54  //r002 `11/20/07, 16:13:01`Add record - made it so outside call is a method so add   `record form uses exact same call
	// Modified by: costasmanousakis-(Designer)-(6/29/08 10:20:54)
	Mods_2008_CM_5404  //On Unload mark the record we were in so that it gets highlighted on the output fo  `rm.
	//  `Added field RPJ_status on Project data page
	// Modified by: costasmanousakis-(Designer)-(10/6/08 11:16:47)
	Mods_2008_CM_5404
	//Change set name PRJLASTRECORDIN to $PRJLASTRECORDIN (local set)
	// Modified by: costasmanousakis-(Designer)-(4/8/09 09:33:28)
	Mods_2009_04
	//Execute the START TRANSACTION only if PRJ_ReturnAccessAllowed=TRUE
	// Modified by: costasmanousakis-(Designer)-(5/26/09 11:51:24)
	Mods_2009_05
	//Adjusted size of included lists for Reports, Types, Sketch and Str Reviews;
	//changed size to automatic size, and Window size to "with constraints" - fixed witdh, min ht=500
	// Modified by: Costas Manousakis-(Designer)-(8/23/13 17:00:10)
	Mods_2013_08
	//  `Changed buttons for projectInfo to use Resource file "projbtn.png"
End if 

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(v_115_002_L)
		If (Type:C295(v_115_002_aL)=Is undefined:K8:13)
			ARRAY LONGINT:C221(v_115_002_aL; 0)
			v_115_002_L:=-1
		End if 
		If (Size of array:C274(v_115_002_aL)>0)
			v_115_002_L:=Find in array:C230(v_115_002_aL; Record number:C243([PRJ_ProjectDetails:115]))
		End if 
		utl_SetSpellandContextMenu
		
		UNLOAD RECORD:C212([PRJ_ProjectFile:117])
		
		PRJ_SetManyTablesReadOnly
		PRJ_SetAccess
		If (PRJ_ReturnAccessAllowed)
			OBJECT SET ENABLED:C1123(PRJ_Validate_l; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(PRJ_Save_l; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			START TRANSACTION:C239
		Else 
			OBJECT SET ENABLED:C1123(PRJ_Validate_l; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(PRJ_Save_l; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		LOAD RECORD:C52([PRJ_ProjectFile:117])  //Mods_2007_CM12_5301   `10/01/07 Load RECORD([PRJ_ProjectFile])
		Compiler_FieldVariables(Table:C252(->[Bridge MHD NBIS:1]))
		
		SET QUERY DESTINATION:C396(Into set:K19:2; "BDEPTset")
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6))
		USE SET:C118("BDEPTset")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		PRJ_SetUpIncludedBins
		PRJ_BD_BuildBrgDataShtList
		ProjectChangesMade_b:=False:C215
		PRJ_SetFormVariableToEmpty
		PRJ_LoadProjectFileData
		PRJ_LoadPage_0
		C_LONGINT:C283($Width_l; $Height_l)
		FORM GET PROPERTIES:C674([PRJ_ProjectDetails:115]; "ProjectDetails.i"; $Width_l; $Height_l)
		
		ut_ResizeWindow(Frontmost window:C447; $Width_l+0; $Height_l+0)
		
		ARRAY TEXT:C222(PRJ_Detail_atxt; 0)
		ARRAY TEXT:C222(PRJ_DetailHead_atxt; 0)
		
		If (Record number:C243([PRJ_ProjectDetails:115])=New record:K29:1)
			Inc_Sequence("PRJ_ProjectID_l"; ->[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
			PRJProjectTabs_as:=2
		Else 
			
			PRJProjectTabs_as:=PRJ_DefaultPage_atxt
			If (False:C215)
				If ([PRJ_ProjectDetails:115]PRJ_BeamUnit_l:28#0)
					PRJ_BeamUnitCost_s:=String:C10(Round:C94(([PRJ_ProjectDetails:115]PRJ_BeamCost_r:27/[PRJ_ProjectDetails:115]PRJ_BeamUnit_l:28); 2))
				Else 
					PRJ_BeamUnitCost_s:="Beam Unit 0"
				End if 
			End if 
		End if 
		PRJ_PT_CalcHourTotals  //Mods_TimeTracking
		
		PRJ_ProjectTypes_atxt:=PRJ_SetUpDetailDDs(->PRJ_ProjectTypes_atxt; ->[PRJ_ProjectDetails:115]PRJ_ProjectType_s:4)
		
		If ([PRJ_ProjectDetails:115]PRJ_BridgeSectResp_s:44="")
			If (PRJ_BridgeSection_atxt{1}#"select@")
				INSERT IN ARRAY:C227(PRJ_BridgeSection_atxt; 0; 1)
				PRJ_BridgeSection_atxt{1}:="Select Responsible Group"
			End if 
			PRJ_BridgeSection_atxt:=1
		Else 
			If (PRJ_BridgeSection_atxt{1}="select@")
				DELETE FROM ARRAY:C228(PRJ_BridgeSection_atxt; 1; 1)
			End if 
			PRJ_BridgeSection_atxt:=PRJ_SetUpDetailDDs(->PRJ_BridgeSection_atxt; ->[PRJ_ProjectDetails:115]PRJ_BridgeSectResp_s:44)
		End if 
		
		PRJ_ControlPageMovement
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_NonBridgeNotes_txt:40)
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8)
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_EnteredDesignEWO_s:43)
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_FederalAid_s:25)
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_Program_s:23)
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_ApprovedType_s:30)
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_BinUpdateRequest_s:26)
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_Slot_s:33)
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_Comments_txt:10)
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_LastActionDescription_txt:9)
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_BridgeDataSheetComplete_s:13)
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_EnteredConstructionEWO_s:31)
		
		ut_SetStringOrTextFilter(->PRJ_DEBin_s)
		ut_SetStringOrTextFilter(->PRJ_ConsultantName_txt)
		ut_SetStringOrTextFilter(->PRJ_DEBridgeNo_s)
		
	: (Form event code:C388=On Outside Call:K2:11)
		PRJ_DetailOutsideCall
		
	: (Form event code:C388=On Unload:K2:2)
		
		PRJ_SetFormVariableToEmpty
		CLEAR SET:C117("$PRJLASTRECORDIN")
		CREATE EMPTY SET:C140([PRJ_ProjectDetails:115]; "$PRJLASTRECORDIN")
		ADD TO SET:C119([PRJ_ProjectDetails:115]; "$PRJLASTRECORDIN")
		Compiler_FieldVariables(Table:C252(->[Bridge MHD NBIS:1]))
		CLEAR SET:C117("BDEPTset")
	: (Form event code:C388=On Close Detail:K2:24)  //Mods_TimeTracking
		Case of 
			: (FORM Get current page:C276=3)  //Reports
				QUERY:C277([PRJ_ReportData:118]; [PRJ_ReportData:118]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
				ORDER BY:C49([PRJ_ReportData:118]; [PRJ_ReportData:118]RPT_Received_d:3; <)
			: (FORM Get current page:C276=4)  //Type Studies
				QUERY:C277([PRJ_TypeStudy:121]; [PRJ_TypeStudy:121]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
				ORDER BY:C49([PRJ_TypeStudy:121]; [PRJ_TypeStudy:121]TYP_Received_d:5; <)
			: (FORM Get current page:C276=5)  //Sketch
				QUERY:C277([PRJ_SketchPlans:120]; [PRJ_SketchPlans:120]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
				ORDER BY:C49([PRJ_SketchPlans:120]; [PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3; <)
			: (FORM Get current page:C276=6)  //Struct Review
				QUERY:C277([PRJ_StructuralReview:119]; [PRJ_StructuralReview:119]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
				ORDER BY:C49([PRJ_StructuralReview:119]; [PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3; <)
			: (FORM Get current page:C276=7)  //Timesheets
				PRJ_PT_CalcHourTotals
				ORDER BY:C49([PRJ_ProjectTimeTracking:124]; [PRJ_ProjectTimeTracking:124]PT_WeekEnding_d:4; <)
		End case 
	: (Form event code:C388=On Data Change:K2:15)
		
End case 
//End Form Method: ProjectDetails.i