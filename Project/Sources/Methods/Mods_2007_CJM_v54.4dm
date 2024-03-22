//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mods_2007_CJM_v54
// User name (OS): cjmiller
// Date and time: 11/13/07, 11:14:41
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r001 `11/13/07, 11:15:11
End if 

//[PRJ_ProjectDetails];"ProjectDetails.i"
//  ` Object Method: PRJ_CityOrTown_s
//  ` Object Method: PRJ_AllowProjectEntry_l

//r001 `11/13/07, 11:45:28`Make param code no more than 20 characters
//SQL_ClearArrays 
//SQL_FillBuiltStatements
//ut_PRJRetrieveAdDate 
//ut_PRJRetrieveConstructionCont 
//ut_PRJRetrieveCPName 
//ut_PRJRetrieveDesignContracts 
//ut_PRJRetrieveModifiedProjects 
//ut_PRJRetrieveOffice_EstAndOpen 
//ut_PRJRetrieveDCAmounts 
//ut_PRJRetrieveProjectFileData 
//End Mods_2007_CJM_v54

//[PRJ_TypeStudy];"TypeStudy.i"
//  ` Form Method: TypeStudy.i
//  ` Method: Object Method: bValidate
//  ` Object Method: TYP_StructureType_s
//PRJ_SetTypeApproved

//`Make first selected record allow for project approval entry
//[PRJ_StructuralReview];" ProjectReview.i"
// Form Method: ProjectReview.i

//r002 `11/20/07, 12:40:36    `Fix display issues when new record is created
//[PRJ_ProjectDetails];"PRJ_ProjectDetails.o"
//  `Object Method bAdd

//PRJ_ControlPageMovement

//NEW FORM
//[PRJ_ProjectDetails];"ProjectDetails.NEW"
//PRJ_DetailOutsideCall
//[PRJ_ProjectDetails];"ProjectDetails.I" - NO FORM CHANGES
//form method ProjectDetails.I

//Change backgriound color and add heading to prj input forms
//[PRJ_ProjectTimeTracking];"ProjectTimeTracking.i"
//[PRJ_TypeStudy];"TypeStudy.i"
//[PRJ_ReportData];"ReportData.i"
//[PRJ_SketchPlans];"SketchPlans.i"
//[PRJ_StructuralReview];"ProjectReview.i"

//Overide conslutant does not work all the time
//Missing outside call event on form
//[Conslt_Name];"PRJ_Selection.o"

//r003 `11/27/07, 10:28:05
//Make sure that bridge, proj file and consultant always editable for new record
// Form Method: ProjectDetails.new
//Make sure all possibilities are queried for
//PRJ_GetSelectedProjectFiles


//Make new and modify entry control use methods
//[PRJ_ProjectDetails];"ProjectDetails.i"
//[PRJ_ProjectDetails];"ProjectDetails.new"
// Object Method: PRJ_DEBin_s
//PRJ_ControlSelectBin
// Object Method: PRJ_DEConsultant_s
//PRJ_ControlSelectConsultant 
// Object Method: PRJ_DEProjectFileNo_l
//PRJ_ControlSelectFileNumber
// Object Method: PRJ_FederalAid_s
//PRJ_ControlSelectFederalAid
// Object Method: PRJ_Program_s
//PRJ_ControlSelectProgram
// Object Method: PRJ_SelectedBins_as
//PRJ_ControlSelectPrimaryBin
// Object Method: PRJ_ConsultantButton_l
//PRJ_ControlChapter85Input
//Fix double click to ake it same as single click and select
//[Bridge MHD NBIS];"PRJ_Selection.o"
//  ` Form Method: PRJ_Selection.o
//Make town not enterable
//PRJ_ResetBridge
//Make sure structrue type actually has something other than spaces in it
//PRJ_SetTypeApproved
//[PRJ_StructuralReview];"ProjectReview.i"
//  ` Object Method: PRJ_DesignApproved_b
//  ` Object Method: PRJ_DesignApproval_d

//Make sure add only does one record at a time
//[PRJ_ReportData];" ReportData.i"
// Form Method: ReportData.i
//  ` Object Method: bValidate
//Make sure that after save many records are there
//[PRJ_ProjectDetails];"ProjectDetails.i"
//  ` Object Method: PRJ_Save_l
//Make sure that delete of many records works correctly and set changed flag
//Make delete button not automatic
//[PRJ_TypeStudy];"TypeStudy.i"
//[PRJ_StructuralReview];"ProjectReview.i"
//[PRJ_ReportData];"ReportData.i"
//[PRJ_SketchPlans];"SketchPlans.i"
//  ` Object Method: bDelete
//Add nbi-non-nbi variable to summary page
//[PRJ_ProjectDetails];"ProjectDetails.i"
//Compiler_PRJ 
//PRJ_SetFormVariableToEmpty 
//PRJ_LoadBridgeData
//End Mods_2007_CJM_v54

//*****Compiler fixes
//	<method name="[PRJ_TypeStudy].TypeStudy.i.bValidate">
//		<error line="24" warning="false">Closing parenthesis ) expected.</error>
//		<error line="37" warning="false">Closing parenthesis ) expected.</error>
//	</method>
//	<method name="[PRJ_ProjectDetails].ProjectDetails.i.[PRJ_ProjectDetails].PRJ_CityOrTown_s">
//		<error line="16" warning="false">The variable PRJ_DECONSULTANT_TXT could not be typed.</error>
//	</method>
//	<method name="[PRJ_ProjectDetails].ProjectDetails.new.PRJ_DEBridgeNo_s">
//		<error line="15" warning="false">The variable PRJ_DEDBRIDGENO_S could not be typed.</error>
//		<error line="16" warning="false">The variable PRJ_DEDBRIDGENO_S could not be typed.</error>
//	</method>
//	<method name="[PRJ_ProjectDetails].ProjectDetails.new.[PRJ_ProjectDetails].PRJ_CityOrTown_s">
//		<error line="16" warning="false">The variable PRJ_DECONSULTANT_TXT could not be typed.</error>
//	</method>
