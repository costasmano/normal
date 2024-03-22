//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mods_2007_CJMv2
// User name (OS): cjmiller
// Date and time: 04/12/07, 10:37:27
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
End if 
//Add new fields
//EnteredDesEWO : similar to the 
//FedReviewReq : Boolean
//BridgeSectResp : Bridge Section
//(longint)coming from a pulldown with cho
//ConsultantReview
//In-House Des
//Preservation

//04/19/07, 09:48:51`
//Make modify behaviour of primary bin make visible or invisible if no bins



//04/26/07, 11:04:26
//Add code to clear, set to export, or set to print on quick report form

//04/26/07, 12:15:37`Integrate Changes made by Costas
//Add InitProcessVar to PRJ_DisplayProjects
//Add te following methods
//PRJ_BD_BuildBrgDataShtList 
//PRJ_BD_BrgDSht_OM 
//PRJ_BD_OpenBridgeDataSheet 

//add PRJ_BD_BuildBrgDataShtList to Form Method: ProjectDetails.i
//add PRJ_BD_BuildBrgDataShtList to Object Method: Button1 which allows for selecting included bins
//add PRJ_BD_BuildBrgDataShtList to Object Method: PRJ_DEBin_s 

//05/03/07, 15:50:59
//Add modified by and modified time stamp fields
//ModifiedTimeStamp_s
//ModifiedBy_s


//05/09/07, 10:54:36`Add reviewer id
//ut_PRJImportData
//ut_PRJCreateTypeStudy 
//ut_PRJCreateSketchPlan 
//ut_PRJCreateStructuralReview 

// `05/09/07, 11:55:47`set new buttons visibility on pages `PRJ_GotoPrjInfo_FN
//PRJ_LoadPage_1
//05/09/07, 12:41:14`Create report of events
//ut_PRJCtrlRetrieveProjectData

//r060 `05/16/07, 11:14:16
//Add code to control access using 
//[PERS_GroupMembers]
//[PRJ_ProjectDetails];" ProjectDetails.i"
//  ` Form Method: ProjectDetails.i

//[PRJ_ProjectDetails];" ProjectDetails.o"
//  ` Form Method: ProjectDetails.o
//[PRJ_ReportData];"ReportData.i"
//  ` Form Method: ReportData.i
//[PRJ_StructuralReview];ProjectReview.i"
//  ` Form Method: ProjectReview.i
//[PRJ_SketchPlans];"SketchPlans.i"
//  ` Form Method: SketchPlans.i
//[PRJ_TypeStudy];"TypeStudy.i"
// ` Form Method: TypeStudy.i
//[PRJ_ProjectTimeTracking];"ProjectTimeTracking.i"
//  ` Form Method: ProjectTimeTracking.i
//[PRJ_ProjectTimeTracking];"TImeSheetEntry"
//  ` Form Method: TImeSheetEntry
//Compiler_PRJ 
//PRJ_ControlPageMovement 
//PRJ_DisplayProjects
//ut_PRJ_IdentifyHighestGroup 
//PRJ_SetAccess 
//PRJ_SetAccessPage_1
//PRJ_SetAccessPage_2 
//PRJ_SetAccessButtonsPage_2 
//PRJ_ReturnAccessAllowed 

//r060   `05/16/07, 16:38:26`Make sure that call to select passes in correct bdept
//PRJ_BridgesEntry

//r060   `05/18/07, 14:48:48
//r62 05/30/07
//Add grading level
//Begin coding for new stored procedure which returns xml in a text variable

//[PRJ_ProjectDetails];"ProjectDetails.i"
//[PRJ_ProjectDetails];"ProjectDetails.o"
//[PRJ_ReportData];"ReportData.i"
//[PRJ_StructuralReview];"ProjectReview.i"
//[PRJ_TypeStudy];"TypeStudy.i"
//05/30/07 ` add ability to select by design contract
//new form
//[PRJ_DesignContracts];"PRJ_Selection.o"
//[PRJ_DesignContracts];"PRJ_Empty"
//PRJ_ControlSelect
//PRJ_GetSelectedDesignContracts 
//add window title
//ut_PRJSetWindowTitle

//05/31/07
//ut_PRJCtrlRetrieveProjectData
//ut_PRJRetrieveConstructionCont
//ut_PRJRetrieveDCAmounts
//ut_PRJRetrieveDesignContracts
//ut_RetrieveModifiedProjects
//ut_PRJRetrieveDCAmounts
//End Mods_2007_CJMv2