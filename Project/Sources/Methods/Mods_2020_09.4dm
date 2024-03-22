//%attributes = {"invisible":true}
//Method: Mods_2020_09
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 09/01/20, 12:22:39
	// ----------------------------------------------------
	//Created : 
	Mods_2020_09
End if 
//
//Make changes regarding UT so results sub form on the UT input form
//FM_PhotoInput 
//LSS_ControlUTDmeterSketches 
//LSS_CreatePhotoRecord 
//LSS_GotToInspectionPage 
//ut_LSSControlPictureMod  - This one is obsolete 
//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Signal"

//[LSS_UT];"UltraSonicSubForm_New" - new FORM
//[LSS_UT];"UltraSonicSubForm"- - FORM NO LONGER USED
//[LSS_UtResult];"UltraSonicResultSubForm"
//[LSS_UtResult];"Input"



//Make changes so that UT and d-meter pictures Added and modified using the [LSS_Photos];"Input" form
// 
//LSS_GotToInspectionPage 
//FM_PhotoInput 
//LSS_ControlUTDmeterSketches 
//LSS_CreatePhotoRecord 
//[LSS_Photos];"Input" - added page 2
//[LSS_Inspection];"Input_Signal"
//  // Method: Object Method: [LSS_Inspection].Input_Signal.DMeterButton_L
//  //Method: [LSS_Inspection].Input_Signal.UTButton_L
//[LSS_Inspection];"Input_Sign"
//  // Method: Object Method: [LSS_Inspection].Input_Sign".DMeterButton_L
//  //Method: [LSS_Inspection].Input_Sign.UTButton_L
//[LSS_Inspection];"Input_Light"
//  // Method: Object Method: [LSS_Inspection].Input_Light".DMeterButton_L
//  //Method: [LSS_Inspection].Input_Light.UTButton_L
//[LSS_Inspection];"Input_ITS"
//  // Method: Object Method: [LSS_Inspection].Input_ITS".DMeterButton_L
//  //Method: [LSS_Inspection].Input_ITS.UTButton_L


//Removed obsolete PICT images from following forms
//[CM_ExtTimeFYAlloc];"Include"
//[CM_ExtTimeFYAlloc];"Output"
//[Conslt Address];"Match_LB"
//[Conslt Address];"Match.o"
//[Conslt Address];"View Conslt Address"
//[Conslt_Name];"Conslt_Name.o"
//[Conslt_Name];"Included"
//[Conslt_Name];"OutPut"
//[Conslt_Name];"PRJ_Selection.o"
//[Field Trip];"Output"
//[InventoryPhotoInsp];"Input"
//[InventoryPhotoInsp];"Output"
//[InventoryPhotoInsp];"ReviewDialog"
//[InventoryPhotos];"Input"
//[InventoryPhotos];"Output"
//[Parameters];"Input"
//[Parameters];"Output"
//[PERS_GroupMembers];"Output"
//[PERS_Groups];"Input"
//[PERS_Groups];"Output"
//[PRJ_ATTRFileNoXrefs];"User.i"
//[PRJ_ATTRFileNoXrefs];"UserList.o"
//[PRJ_ConstructionProject];"UserList.o"
//[PRJ_Contractor];"Input"
//[PRJ_Contractor];"UserList.o"
//[PRJ_DesignContracts];"Input"
//[PRJ_DesignContracts];"Output"
//[PRJ_DesignContracts];"PRJ_Selection.o"
//[PRJ_DesignContracts];"UserList.o"
//[PRJ_ProjectDetails];"BridgeProgram"
//[PRJ_ProjectDetails];"NewBDEPTSelection.o"
//[PRJ_ProjectDetails];"ProjectDetails.i"
//[PRJ_ProjectDetails];"ProjectDetails.o"
//[PRJ_ProjectDetailsIncludedBINS];"UserList.o"
//[PRJ_ProjectFile];"PRJ_Selection.o"
//[PRJ_ProjectFile];"ProjectFile.i"
//[PRJ_ProjectTimeTracking];"PRJ_Details.inc"
//[PRJ_ProjectTimeTracking];"ProjectTimeTracking.i"
//[PRJ_ReportData];"ReportData.i"
//[PRJ_SketchPlans];"SketchPlans.i"
//[PRJ_SketchPlans];"SketchPlans.inc"
//[PRJ_StrPrjManagerHistory];"Input"
//[PRJ_StrPrjManagerHistory];"Output"
//[PRJ_StructuralReview];"ProjectReview.i"
//[PRJ_TypeStudy];"TypeStudy.i"

//[ScourPOA_DetourBridge];"Output"
//[ScourPriorityRank];"Input"
//[ScourPriorityRank];"Output"
//[SQL_Connections];"Connect_dlg"
//[SQL_Connections];"SQL_Connnectsions.o"
//[TableOfLists];"PRJ_Selection.o"
//[TableOfLists];"TableOfLists.i"
//[TableOfLists];"TableOFLists.o"
//[Town Address];"View Town Address"
//[Templates];"Output"
//[Work_Estimate];"List"
//[WorkHour_Config];"Input"
//[WorkHour_Config];"Output"
//[WorkHour_Summary];"Input"
//[WorkHour_Summary];"Output"
//[zSpecialReports];"Output"




//[Dialogs];"Inspection"
//[Inspections];"DiveTemplate"



//[Cond Units];"Output.Page1.Picture11
//[Activity Log];"Output-Fast.Page1.Picture8
//[Out of Freq];"O_OutofFreq.Page1.Picture10
//[Out of Freq];"P_OutofFreq.Page1.Picture1
//[ServerProcesses];"Output-old.Page0.Picture11
//[ServerProcesses];"Input.Page1.Picture17
//[ServerProcesses];"Output_LB.Page0.Picture11
//[ClientAccess];"Input.Page1.Picture17
//[ClientAccess];"Output.Page1.Picture9
//[SD_History];"ImportForm.Page1.Picture30
//[SD_History];"Input.Page1.Picture30
//[SD_History];"OutPut.Page1.Picture24
//[Contract_Assignment_Maintenance];"testlist.Page1.Picture3
//[PRJ_ProjectDetails];"ProjectDetails.i.Page2.PRJ_ConsultantButton
//[PRJ_ProjectDetails];"ProjectDetails.new.Page1.PRJ_ConsultantButton
//Delete forms
//[PRJ_ProjectDetailsIncludedBINS];"BinSelection.dlg.Page1.MoveToNewPicture
//[PRJ_ProjectDetailsIncludedBINS].BinSelection.dlg.Page1.IncludeAllpic1
//[PRJ_ProjectDetailsIncludedBINS].BinSelection.dlg.Page1.MoveFromNewPicture
//[PRJ_ProjectDetailsIncludedBINS].BinSelection.dlg.Page1.IncludeAllpic2
//[PRJ_ProjectDetailsIncludedBINS].BinSelection.dlg.Page1.MoveToExistingPicture
//[PRJ_ProjectDetailsIncludedBINS].BinSelection.dlg.Page1.MoveFromExistPicture
//[PRJ_ProjectDetailsIncludedBINS];"BinSelectionNoNew.dlg.Page1.MovetoAssigned1a
//[PRJ_ProjectDetailsIncludedBINS].BinSelectionNoNew.dlg.Page1.MovetoAvailable1a
//[PRJ_ProjectDetailsIncludedBINS].BinSelectionNoNew.dlg.Page1.MoveAllToAssigned1a
//[PRJ_ProjectDetailsIncludedBINS];"BinSelectionwithNew.dlg.Page1.MoveAllToSelected1a
//[PRJ_ProjectDetailsIncludedBINS].BinSelectionwithNew.dlg.Page1.AssigntoGroup1a
//[PRJ_ProjectDetailsIncludedBINS].BinSelectionwithNew.dlg.Page1.MovetoUnassigned1a
//[PRJ_ProjectDetailsIncludedBINS].BinSelectionwithNew.dlg.Page1.MovetoUnassigned2a
//[PRJ_ProjectDetailsIncludedBINS].BinSelectionwithNew.dlg.Page1.MovetoAvailable1a
//[PRJ_ProjectDetailsIncludedBINS].BinSelectionwithNew.dlg.Page1.MoveAllToUnassigned1a
//end delete forms
//[LB_QueryTable];"Output.Page1.Picture3
//[BridgeInfoLink];"Output.Page1.Picture4
//[TunnelInfo];"Output.Page1.Picture8
//[TunnelInspection];"Output.Page1.Picture10
//[IS_ControlProcess];"Output.Page1.Picture23
//[AddtlRatingRequests];"Output.Page1.Picture5
//[BridgeRankCalc];"Output.Page0.Picture6
//[BridgeRankResult];"Output.Page1.Picture7
//[ElmtRatingLoads];"Output.Page1.Picture3
//[LSS_Accessibility];"Output.Page1.Picture7
//[LSS_AccessibilityElement];"Output.Page1.Picture3
//[LSS_DMeter];"Output.Page1.Picture10
//[LSS_Element];"Output.Page1.Picture5
//[LSS_ElementInspection];"Output.Page1.Picture10
//[LSS_Inspection];"Output.Page1.Picture39
//[LSS_Inventory];"Output.Page1.Picture28
//[LSS_Photos];"Output.Page1.Picture6
//[LSS_Photos];"show_Picts.Page1.Picture3
//[LSS_refInspectionType];"Output.Page1.Picture4
//[LSS_refRouteDirection];"Output.Page1.Picture3
//[LSS_refStructureCoating];"Output.Page1.Picture3
//[LSS_refStructureMaterial];"Output.Page1.Picture3
//[LSS_refStructureTypes];"Output.Page1.Picture4
//[LSS_SignPanel];"Output.Page1.Picture9
//[LSS_TeamMembers];"Output.Page1.Picture3
//[LSS_TowerDistance];"Output.Page1.Picture6
//[LSS_UT];"Output.Page1.Picture15
//[LSS_UtResult];"Output.Page1.Picture9
//[LSS_VerticalClearance];"Output.Page1.Picture7
//[PON_ELEM_DEFS];"Output.Page1.Picture23
//[PON_ELEM_INSP];"Output.Page1.Picture30
//[PON_ELEM_COSTS];"Output.Page1.Picture6
//[NTI_ELEM_DEFS];"Output.Page1.Picture7
//[NTI_ELEM_BIN_INSP];"Output.Page1.Picture8
//[TIN_Inspections];"Output.Page1.Picture20
//[NTI_ELEM_TIN_INSP];"Output.Page1.Picture23
//[TIN_Insp_TmMembers];"Output.Page1.Picture3


//Change personnel and [personnel groups 
//add search like on bridge list
//change project detail bridge program to list boxes


//**********`Modified by: Costas Manousakis-(Designer)-(9/14/20)
//Method: GetPictureTypes
//Description
// Fill a text array with the picture types found in a picture
// Parameters
// $1 : $Picture
// $2 : $TypeArray_ptr

// [Standard Photos];"Standard Photos".Button
//  `replaced calls to hmfree with call to GetPictureTypes
// QR_ReturnPhotoType
//  `replaced calls to hmfree with call to GetPictureTypes
// INSP_SavePhoto
//  `replaced calls to hmfree with call to GetPictureTypes
//  `use parameter INSP_BADIMAGETYPES to determine which images to prohibit


//Add search picker to personnel output list box
//Modified by: CJ (9/17/20 13:44:01)
//on server startup
//[Personnel];"Inspectors Out_LB"
//PersonnelSearchPicker_OM 
//Personnel_FillSearchArrray

//Add search picker to [PERS_Groups] output list box
//Modified by: CJ (9/17/20 16:20:36)
//on server startup
//[PERS_Groups];"PG_Output_LB"
//PersGroup_FillSearchArrray 
//PersGroupSearchPicker_OM
//Try and speed up display of project bridge

//End Mods_2020_09