//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/27/09, 11:42:59
	// ----------------------------------------------------
	// Method: Mods_2009_CM_5404
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 

// **********  ` Modified by: costasmanousakis-(Designer)-(1/20/09 15:42:24)
// Modified Form Methods : 
//[Contract_Maintenance];"Contract Maintenance In"
//  `Create an assgnment record when new contract record is created.

// Created Method(s) : 
//CM_QRAssignmentInfo
//  ` Retrieve various pieces of info for an assignment depending on the passed parameter.

// Created Method(s) : 
//ut_GoogleBIN
//  ` Launch a browser with google maps to the latlongs of the current BIN record.

// Modified Forms : 
//[Bridge MHD NBIS];"SI & A Input"
//  `Added Google Button on Page 0

// **********  ` Modified by: costasmanousakis-(Designer)-(1/22/09 12:12:03)
// Modified Method(s) : 
//PRJ_SelectField_atxt
//  `In the MassEdit form . For Responsible group, copy the  PRJ_BridgeSection_atxt array used in the input forms.

// **********  ` Modified by: costasmanousakis-(Designer)-(1/23/09 12:02:05)
// Modified Method(s) : 
//PRJ_DisplayProjects 
//  `Reduce the starting list by where user belongs to.

//PRJ_LoadDropDownLists 
//  `Additions for search by Expediter
//PRJ_BPGM_InitSRCHVars 
//  `Additions for search by Expediter, BridgeSectResp
//PRJ_BPGM_CleanSearchVars 
//  `Additions for search by Expediter, BridgeSectResp , Attribute
//PRJ_BPGM_CreateSearchSet
//  `Additions for search by Expediter, BridgeSectResp , Attribute
// Modified Forms : 
//[Dialogs];"PRJ_BPGM_Search"
//  `Additions for search by Expediter, BridgeSectResp , Attribute

// **********  ` Modified by: costasmanousakis-(Designer)-(1/27/09 11:39:00)
// Modified Method(s) : 
//CM_FYFundRecalc
//  ` check size of array arr_CM_FYAlloc_I to be greater than 0 instead of 1

// Created Method(s) : 
//PRJ_QRSDFOStatus 
//  ` Return the SD/FO status of the current Bridge project
//  ` Must have a [PRJ_ProjectDetails] record current
//PRJ_QRBINList
//  ` Return the list of BINs associated with a project
//  ` Must have a [PRJ_ProjectDetails] record current

// Modified Method(s) : 
//INSP_SavePhoto
//  `Modified logic of saving pictures, so that no large photos are saved. does not change anything for
//  `sketches / charts
// Modified Method(s) : 
//M_ContractRpt_Assignment
//  `fixed the calculation of cons score averages. 
//  `Keep a count of valid cons score projects. count only non zero ones.

// Modified Forms : 
//[Contracts];"Rpt Assign Detail"
//[Contracts];"Rpt Assign Footer"
//  `Added to the display the count of valid scores (non-zero)

//PRJ_QR_ReturnConsultant
//  `Adjusted logic to check for cons ID overrrides.

// **********  ` Modified by: costasmanousakis-(Designer)-(2/5/09 09:07:19)
// Modified Method(s) : 
//INSP_SavePhoto 
//  `Modified logic of saving pictures, so that no large photos are saved. does not change anything for
// `sketches / charts

// **********  ` Modified by: costasmanousakis-(Designer)-(2/11/09 14:21:45)
// Modified Forms : 
//[Contracts];"Contracts Out"
//Added button ExportContractsbn.
//  ` Button to export all contract information for 
//  ` Farhad Rastegari

// **********  ` Modified by: costasmanousakis-(Designer)-(2/12/09 14:52:56)
// Modified Method(s) : 
//INSP_SavePhoto 
//  `Also restricted all images to 1250Kb size.

// **********  ` Modified by: costasmanousakis-(Designer)-(2/13/09 11:26:54)
// Modified Method(s) : 
//G_Insp_SetTitle
//  `Fixed the part of adding Spec mem in title. Happens only for
//   `Routine  inspections (RT@, CUL)

// Modified Forms : 
//[Personnel];"Inspectors In"
//  `Modified the form margins and the On horiz resize properties of some objects.

// **********  ` Modified by: costasmanousakis-(Designer)-(2/17/09 08:56:03)
// Modified Method(s) : 
//INSP_SavePhoto 
//  `Increased image size restriction to 1350Kb size.

// Created Method(s) : 
//ut_updateCMAssgnABP
//  ` Update the ABP flag in the assignments for the Bridge Preservation module.

// Modified Form Methods : 
//[Work_Estimate];"Input"
// Modified Object Methods : 
//[Work_Estimate];"Input".ReadWriteBtn
//  `Added a variable help message for the ReadWriteBtn

// **********  ` Modified by: costasmanousakis-(Designer)-(2/19/09 10:41:43)
// Modified Table(s) : 
//[Contract_Assignment_Maintenance]
// `added fields
// `[Contract_Assignment_Maintenance]ExtendedDesc_txt
// `[Contract_Assignment_Maintenance]ABPFlag_L

// Modified Forms and form method : 
//[Contract_Assignment_Maintenance];"Assignment Maintenance In"
//  `Included the new field [Contract_Assignment_Maintenance]ExtendedDesc_txt
//  ` and code to display the ABP flag status
// Modified Object Methods : 
//[Contract_Assignment_Maintenance];"Assignment Maintenance In".ProjectIS
//  `Added the object method to adjust the ABP Flag field and the ABP display variable.

// **********  ` Modified by: costasmanousakis-(Designer)-(2/23/09 16:04:17)
// Created Method(s) : 
//CM_QR_GetAssignPaid
//  ` Get the ammounts paid for an assignment.
//  ` Fills process variables than can be used in a quick report.

// **********  ` Modified by: costasmanousakis-(Designer)-(2/26/09 16:04:32)
// Modified Method(s) : 
//PRJ_PT_GetProjectEWOs
//  `Added the EWOs in the project selection HLists to help differentiate between diff projects on same bridge.

// **********  ` Modified by: costasmanousakis-(Designer)-(2/27/09 10:25:04)
// Modified Method(s) : 
//G_Insp_SetPersUI
//  `When there is no team leader - will make the current person the team leader

// Modified Method(s) : 
//LOGIN_BMSPontisTransfer
//  `Added a call to method ut_updateCMAssgnABP

// **********  ` Modified by: costasmanousakis-(Designer)-(3/5/09 09:07:25)
// Modified Method(s) : 
//ut_ControlFieldReset
//  `Moved the declaration of array $aSkippedFileNums so that it is always declared
//  ` fixed a bug in the message where table name was called.
//  `added case to drop indexes for all tables, not for all, or go by table

//G_Insp_RelateInsp
//  `Modified parameter declarations to use the 'indirection'

// **********  ` Modified by: costasmanousakis-(Designer)-(3/6/09 16:22:39)
//``Mods_2009_CM_5404   `----TIMESHEETS2
// Modified Forms : 
//[PRJ_ProjectTimeTracking];"ProjectTimeTracking.i"
//[PRJ_ProjectTimeTracking];"TImeSheetEntry"
//  `Added dropdown to enter the review stage.
// Modified Method(s) : 
//PRJ_PT_CalcHourTotals
//PRJ_PT_ValidateTime_OM 
//PRJ_PT_ValidEntry 
//P_PRJ_StartTimeSheets
//  `Added code to handle the initialization, validation, and calculation of time hours using
//  `the new stage_s field.


// **********  ` Modified by: costasmanousakis-(Designer)-(3/9/09 12:22:09)
//``Mods_2009_CM_5404   `---- "FREEZETHAW"
//Implementation of the Freeze Thaw inspection
// Created Method(s) : 
//PRINT_FREEZE_F 
//Print_Freeze_pg1 
//ut_FitPrintFormObject 
//FRZ_PrintPageUtil 
//INSP_FRZElmtDesc 
//INSP_FRZ_PrintCmts

// Created Form(s) :
// [ElementsSafety];"FreezeThawInc_1"
//[ElementsSafety];"FreezeThawInp_1"
//[Inspections];"FreezeThaw"
//[Inspections];"FrzThawPg1"

// Modified Method(s) : 
//GetInspType 
//G_DefInspElmts 
//G_CountSpMbPgs 
//G_CountSpInspPgs 
//G_SIA2Inspection

// Modified Object Methods : 
//[Inspections];"AboveWater Template".bPrint
//[Standard Photos];"Standard Photos".vbPrintImages

// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"

// Modified Object Methods : 
//[Dialogs];"InspectConfig".bOK
// Modified Form and  Methods : 
//[Dialogs];"InspectConfig"

//``END  OF Mods_2009_CM_5404   `---- "FREEZETHAW"

// Modified Forms : 
//[Element Cat];"Input"
//  `Enabled logging of changes in the [Element Cat] table

// Modified by: costasmanousakis-(Designer)-(3/19/09 09:28:32)
// Modified Method(s) : 
//CM_MailInvoiceNotice 
//CM_UpdateInvoiceTotals
//G_MaintenanceCalculateTLFandDE
// Modified Forms : 
//[Invoice_Maintenance];"Invoice Maintenance In"
// Modified Form Methods : 
//[Invoice_Maintenance];"Invoice Maintenance Out"
//  `In All above include the cost recovery field.

//  `  `Start of Mods_2009_CM_5404   ` ("WKHRMODS")
// Created Method(s) : 
//ut_ZeroByPointer
//  ` Will Zero/clear a series of variables, based on a pattern and a numeric counter.
//WKHR_CalcFunctions 
//  ` Perform various functions for the design rates
//WKHR_ClearWKHRAllBtn_OM 
//  ` The object method for the clear all button in the work hour input form
//WKHR_GetItemNo
//  ` Get the printable item number - allows renumbering of items.
//WKHR_ClearCosts 
//  ` Clear all rate fields
//WKHR_StoreOrigEngEst 
//  ` Initialize/store/retrieve the original estimate
//WKHR_LineEntry_FM 
//  ` Form method for line entry form
//WKHR_LoadLineItem 
//  ` Tasks for loading line items

// Modified Method(s) : 
//WKHR_CalcOffEstTotals
//WKHR_AcceptRevwCat 
//WKHR_SubItemPlus 
//WK_ScrollArea
//WKHR_LoadItemHRs
//WKHR_InitVars
//WKHR_CalcRates
//WKHR_SubItemMinus 
//WKHR_InitLineItemVars
//WKHR_HandleSubItm 
//WKHR_CalcReviewTotals
//WKHR_ZeroAll
//WKHR_Temp_LoadDescr
//WKHR_StoreVariables_2
//WKHR_SetUpCategPullDwn
//WKHR_ResetPageValues
//WKHR_RecalcPage2
//WKHR_Print
//WKHR_InitConfigArrays
//WKHR_CreateProposal
//WKHR_ClearOutCategory
//WKHR_ClearAllValues
//WKHR_CalcTotals
//WKHR_LoadVariables_2
//WKHR_ApprvReject_OM
//WKHR_AcceptReviewer
//WKHR_Input_SetReviewRW

// Modified Forms / Form Methods :: 
//[Work_Estimate];"Print3"
//[Work_Estimate];"Print4"
//[Work_Estimate];"LineEntry"
//[Work_Estimate];"Input"

// Created Form(s) : 
//[Work_Estimate];"Print3_V0"
//[Work_Estimate];"Print4_V0"
//  `Copies of the old Print3 and Print4 forms

//Created new HLists
//"WKHR_ItemsNos"
//"WKHR_ItemsNos_V1"
//"WKHR_Items_V1"

// Modified by: costasmanousakis-(Designer)-(3/20/09 08:44:39)
//[Work_Estimate];"Print4"
//WKHR_InitVars
//[Work_Estimate];"Input"

//  `  `End of Mods_2009_CM_5404   ` ("WKHRMODS")
