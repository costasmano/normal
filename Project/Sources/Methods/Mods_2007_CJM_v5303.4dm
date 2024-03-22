//%attributes = {"invisible":true}
//New field
//[PRJ_ProjectFile]PF_ConsultantOverideID_l field type is long
//[PRJ_ProjectDetails]PRJ_Chapter85_b  type is boolean
//new form
//[PRJ_ProjectFile];"Chapter85.i"

// Modified Form Methods : 
//[Bridge MHD NBIS];"PRJ_Selection.o"
//[PRJ_ProjectFile];"PRJ_Selection.o"
//[TableOfLists];"PRJ_Selection.o"
//[PRJ_DesignContracts];"PRJ_Selection.o"
//[Conslt_Name];"PRJ_Selection.o"
//   `r003 `10/09/07, 15:56:35`Add filter event so we never get to input frm
// Modified Object Methods : 
//[Conslt_Name];"PRJ_Selection.o".CreateNew, Select, Skip
//  `Code to account for selecting a new or overriding a consultant
// Created Form Method : 
//[Conslt_Name];"PRJ_Empty"

//Add ability to assign a consultant to chapter 85 project types
//Rules are as follows:
//If proj type is chapter 85. 
//project file # is not visible
//set drop down of consultants to be visible and allow selection
//Once a consultant is selcted, create a dummy [PRJ_DesignContracts] record and a dummy [PRJ_ProjectFile] record and link
//If consultant changes, modify design contract record

//If proj file # > 0 Chapter 85 removed form projct type array
//If proj file # < 0 Chapter 85 add to projct type array

If (False:C215)
	//COPIED FOLLOWING FROM CJM SOURCE METHOD Mods_2007_CJM_v5302
	
	//Add ability to assign a consultant to chapter 85 project types
	//Rules are as follows:
	//If proj type is chapter 85. 
	//project file # is not visible
	//set drop down of consultants to be visible and allow selection
	//Once a consultant is selcted, create a dummy [PRJ_DesignContracts] record and a dummy [PRJ_ProjectFile] record and link
	//If consultant changes, modify design contract record
	
	//If proj file # > 0 Chapter 85 removed form projct type array
	//If proj file # < 0 Chapter 85 add to projct type array
	
	//Part of this is to fix display of check boxes to allow entry on page 2 to take access cotrol into account. I think I should rewrite to be more generic.
	
	//r003 `10/09/07, 10:01:16
	//[Bridge MHD NBIS];"PRJ_Selection.o" - form method
	//[PRJ_ProjectDetails];"ProjectDetails.i"- form method
	//[PRJ_ProjectFile];"PRJ_Selection.o"- form method
	//[PRJ_DesignContracts];"PRJ_Selection.o"- form method
	//[TableOfLists];"PRJ_Selection.o"- form method
	//[Conslt_Name];"PRJ_Empty" form
	//[Conslt_Name];"PRJ_Selection.o"- form and form method
	//compiler_prj
	//PRJ_SetChapter85Access
	//PRJ_DisplayProjects 
	//PRJ_LoadDropDownLists 
	//PRJ_QR_ReturnConsultant
	//[Conslt_Name];"Conslt_name.i"
	
	//r004 `10/23/07, 10:00
	
	//Make sure PRJ_ConsultantName_txt is set to non-enterable
	//PRJ_ControlPageMovement 
	
	//Add code to control change from chapter 85
	//PRJ_ControlSelect
	
	//10/23/07, 15:18:43`Make sure only real numbers displayed
	//PRJ_GetSelectedDesignContracts 
	//PRJ_GetSelectedProjectFiles 
	
	//`10/23/07, 16:10:40`Add code to allow for overide  consultant
	//PRJ_SetAccess
	//PRJ_SetAccessPage_2
	//PRJ_SetChapter85Access
	//PRJ_SetEntryCheckBoxes
	//PRJ_LoadDesignContractData
	// Form Method: ProjectDetails.i
	// Form: ProjectDetails.i
	// PRJ_ControlSelect
	//[PRJ_ProjectFile]PF_ConsultantOverideID_l`new field
	//ut_PRJRetrieveDesignContracts
	
	
	//r005  `10/30/07, 
	//PRJ_LoadDesignContractData 
	//PRJ_SetAccess 
	//PRJ_SetChapter85Access 
	//PRJ_SetEntryCheckBoxes 
	//ut_PRJRetrieveDesignContracts 
	
	//Sanity check stuff
	//Mnt_GetReportType 
	//r006 `11/06/07, 12:07:24
	//Fix defect in selecting bins
	//PRJ_MoveToAvailable 
	//PRJ_MoveToSelected 
	//delete method PRJ_MoveToNewSelected
	//[PRJ_ProjectDetailsIncludedBINS];"BinSelection.dlg"
	
End if 

If (False:C215)
	//THESE COMMENTS WERE FROM A DOC TRACKING CHANGES
	//THE DOUBLE COMMENTED LINES KEPT A RECORD OF THE CHANGES
	//IN THE SERVER DB.
	
	//Project changes
	//New field
	//  `[PRJ_ProjectFile]PF_ConsultantOverideID_l field type is long
	//  `[PRJ_ProjectDetails]PRJ_Chapter85_b  type is boolean
	//new form
	//  `[PRJ_ProjectFile];"Chapter85.i"
	//  `[zDalogs];"ResetDialog"
	//
	//Modified Forms- you should move form methods as well as forms. 
	//Check to see if you have made changes as well.
	//  ``All PRJ_Selection.o
	//  ``ALL PRJ_Empty
	//  `[prj_ProjectDetails]:"ProjectDetails.i" - page 0, page 1, page 2
	//  `[prj_ProjectDetails]:"ProjectDetails.i" -form method
	//  `[prj_ProjectDetails]:"ProjectDetails.o"
	//  `[PRJ_ProjectDetails];"BridgeProgram.prt"
	//  `[Conslt_Name];"Conslt_name.i"
	//  `[PRJ_ProjectDetailsIncludedBINS];"BinSelection.dlg" - Form Method
	//  `[PRJ_DesignContracts];"PRJ_Selection.o" - Form Method - BShowAll - BQuery
	//  `[PRJ_ProjectDetailsIncludedBINS];"BinSelection.dlg"
	//
	//Modifed Methods
	//  `PRJ_ProcessfromChapter85
	//  `PRJ_LoadDropDownLists
	//  `Compiler_PRJ
	//  `Compiler_PRJArrays
	//  `PRJ_SetChapter85Access
	//  `PRJ_DisplayProjects 
	//  `PRJ_LoadDropDownLists 
	//  `PRJ_QR_ReturnConsultant
	//  `PRJ_ControlPageMovement
	//  `PRJ_ControlSelect
	//  `PRJ_GetSelectedDesignContracts 
	//  `PRJ_GetSelectedProjectFiles 
	//  `PRJ_SetAccess
	//  `PRJ_SetAccessPage_2
	//  `PRJ_SetChapter85Access
	//  `PRJ_SetEntryCheckBoxes
	//  `PRJ_LoadDesignContractData
	//  `ut_PRJRetrieveDesignContracts
	//  `PRJ_LoadDesignContractData 
	//  `PRJ_SetAccess 
	//  `PRJ_SetChapter85Access 
	//  `PRJ_SetEntryCheckBoxes 
	//  `ut_PRJRetrieveDesignContracts 
	//  `PRJ_DisplayBridgePgm
	//  `PRJ_ReturnAccessAllowed
	//  `PRJ_BPGM_ListFromBINs
	//  `PRJ_MoveToAvailable 
	//  `PRJ_MoveToSelected 
	//
	//deleted methods
	//  `PRJ_MoveToNewSelected
	//
	//Miscelleneous changes
	//  `G_MaintenanceCalculateTLFandDE
	//  `ut_PutTWNDATAtoDoc
	//  `ut_PRJCreateTypeStudy
	//  `P_ListConsultantNames
	//  `[Inspections];"Closed Bridge"
	//  `Obj meth Insp Date
	//  `[Contracts];"Contracts In"
	//  `Obj method bAdd button - additional funds page 2
	//  `[Contract_Maintenance];"Contract Maintenance In"
	//  `Obj Mthod AddAdditionalBtn page 5
	//  `[Work_Estimate];"LineEntry"
	//  `OBJ metho ReviewItm_1, _2, _3, _4, _5
	//  `[PRJ_ProjectDetails];"BridgeProgram.prt"
	//  `Form Method
	
End if 

// Created Method(s) : 
//PRJ_ProcessfromChapter85 
//  `r004 `10/23/07, 12:45:36
//PRJ_SetChapter85Access
//  `r003 `10/09/07, 11:19:28
// Modified Method(s) : 
//Compiler_PRJ
//  `r003 `10/09/07, 16:51:44`Chapter85
//  `r006 `11/06/07, 12:11:26
//ut_PRJRetrieveDesignContracts
//  `r004 `10/23/07, 16:49:42``Add code to allow for overide  consultant
//PRJ_GetSelectedDesignContracts
//  `r004 `10/23/07, 16:39:23`` Make sure only real numbers displayed
//PRJ_ControlSelect
//  `r004 `10/23/07, 11:17:52`Add code to control change from chapter 85
//  `r004 `10/23/07, 16:31:28 `Add code to allow for overide  consultant
//PRJ_ControlPageMovement
//  `r004 `10/23/07, 10:42:16
//PRJ_GetSelectedProjectFiles
//  `r004 `10/23/07, 15:18:43`Make sure only real project file numbers displayed
//PRJ_LoadDesignContractData
//   `r004 `10/23/07, 16:30:01`Add code to allow for overide  consultant
//[PRJ_DesignContracts];"PRJ_Selection.o" - Form Method - BShowAll - BQuery
//   `r004 `10/23/07, 15:22:42`Make sure only real design contract  records displayed
//[PRJ_ProjectDetailsIncludedBINS];"BinSelection.dlg" - Form Method
//  ` Hide buttons if nothing is available
//PRJ_MoveToAvailable
//   `r006 `11/06/07, 12:06:15
//PRJ_MoveToSelected
//   `r006 `11/06/07, 11:42:52
//deleted methods
//PRJ_MoveToNewSelected
//PRJ_ReturnAccessAllowed
//   `r004 `10/23/07, 16:49:42 `Designer has access also
// Modified Form Methods : 
//[Conslt_Name];"Conslt_name.i"
//  `r006 `changes for use as a consultant selector
// Modified Method(s) : 
//PRJ_SetAccess
//   `r004 `10/23/07, 14:37:39`Make sure designers can delete
//   `r004 `10/23/07, 16:10:40`Add code to allow for overide  consultant
//PRJ_SetAccessPage_2
//  `r004  `Code to account access to consultant inputs
//PRJ_SetEntryCheckBoxes
//  `r004`Select by consultant changes
// Modified Form Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.i"
//   `r003 `10/09/07, 12:08:26`Add Chapter 85
//   `r004 `10/23/07, 16:30:01`Add code to allow for overide  consultant
// Modified Form  : 
//[PRJ_ProjectDetails];"ProjectDetails.i"
//   `r003 `10/09/07, 12:08:26`Add Chapter 85
//   `r004 `10/23/07, 16:30:01`Add code to allow for overide  consultant
//PRJ_DisplayBridgePgm
//PRJ_ShowAdPrjStatus
//PRJ_BPGM_ListFromBINs
//  `r004 changed name of array PRJ_ConsultantName_atxt; declare the array also
//PRJ_QR_ReturnConsultant
//  `r004 changed name of array PRJ_ConsultantName_atxt
// Modified Object Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.o".SortColumn3 (sort by consultant)
//  `r004 changed name of array PRJ_ConsultantName_atxt