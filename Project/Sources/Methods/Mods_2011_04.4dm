//%attributes = {"invisible":true}
//  Mods_2011_04

// **********  ` Modified by: costasmanousakis-(Designer)-(4/6/11 08:14:02)
//****** INTERNAL ******
// Created Method(s) : 
//ut_CollapseList
//  ` Collapse all levels of an Hierarchical list

// Modified Method(s) : 
//WKHR_SetUpCategPullDwn 
//WKHR_ZeroAll 
//WKHR_InitConfigArrays 
//  `Added call to ut_CollapseList to make sure the List is collapsed - Fix for the v11 transition

// Modified Object Methods : 
//"Conslt Address In".ConsNames_HL
//  `Replaced Self with Variable name ; moved on load event to form method on - avoid problems in v11
// Modified Form Methods : 
//"Conslt Address In"
//  `do on load for the ConsNames_HL hlist menu

// Modified Method(s) : 
//DCM_C_Input_FM
//  `Fixed call to get form properties - was using wrong form name
//M_ListDistrMaint 
//  `Added declaration of parameter 1
//DCM_WO_BrgList_OM 
//  `Fixed misstyped name of input form.
//SCPOA_FieldNoteCtrl
//  `Added initializing of Listbox array SCPOAFieldNotesListBox
//SCPOA_PhotoListBox_OM
//  `Added initializing of Listbox array SCPOAImagesListBox
//****** END OF INTERNAL ******


// **********  ` Modified by: costasmanousakis-(Designer)-(4/11/11 10:26:02)
//****** INTERNAL ******
// Modified Method(s) : 
//WKHR_AddEstToSum
//  `Added call to ut_CollapseList to make sure list is at state it should be - for v11 transition

//DCM_ContrProjControl
//  `Fix declaration of DCM_CO_BR_Brno_atxt 

//DCM_P_Input_FM 
//DCM_CreateWorkOrder
//  `Define vDistrict:=String(Num(DCM_Project]District))
//******END OF INTERNAL ******

// **********  ` Modified by: CJ Miller-(Designer)-(4/12/11 )
//****** INTERNAL ******
// Modified Method(s) : 
//SR_ProcessQuarterly
//prt_substdrep
//Mail_BridgeStatusRpt
//ut_SRVMonthlyReports
//  `Replaced "Get indexed string" with substring of string(date;Month Day Year) to get 3 character month

// **********  ` Modified by: CJ Miller-(Designer)-(4/12/11 10:32:35)
// Created Method(s) : 
//ut_ResetUserStartUp
//  ` Clear the startup method of users which has been set to "x"
//****** END OF INTERNAL ******


// **********  ` Modified by: costasmanousakis-(Designer)-(4/13/11 14:38:05)
//****** BUG FIXES ******
// Modified Method(s) : 
//G_DeleteInspection
//  `Fix a bug in the deletion of array element if the index of the current inspection is not found.
//  `Added Alert if the code is executed not on page 1.
//  `Added code to handle the case if the record has been loaded in read-only mode and the delete button has been
//  `pressed. This happens only if the user is in the "Area Engineers" group. See G_Insp_LockFormOnOff method.

//INSP_PrintInspBtn_OM 
//  `Added code to build the TeamMember area - incorrect team members were printed
// Modified Object Methods : 
//[Inspections];"InspectionReview".bzPrint
//  `Added code to build the TeamMember area - incorrect team members were printed

// Modified Object Methods : 
//[FileIDRes Table].output.vtablnam
//  `Added check if [FileIDRes Table]File Number : v11 Fix

//****** END OF BUG FIXES ******

// **********  ` Modified by: costasmanousakis-(Designer)-(4/19/11 14:36:11)
//****** ENHANCEMENT ******
// Modified Object Methods : 
//[PRJ_ProjectDetails].ProjectDetails.o.PRJ_RelatedQRs
//  `Changed button name and type to make it a 3D button with a linked pop-up menu. 
//  `Added ability to do QRs based on related Included BINs
//****** END OF ENHANCEMENT ******

//****** BUG FIXES ******
// Modified Method(s) : 
//PRJ_PT_GetProjectEWOs
//  `Added a check when collecting Bridge numbers in case the Non-Bridge field is also blank.
//****** END OF BUG FIXES ******
