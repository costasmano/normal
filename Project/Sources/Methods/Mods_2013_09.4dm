//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/04/13, 13:31:35
//----------------------------------------------------
//Method: Mods_2013_09
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_09  //r001 ` 
	//Modified by: Charles Miller (9/4/13 13:31:37)
	
End if 
//removed file number from project details when project ibnfo removes it
//ut_PRJRetrievePRJ_Bridge
//Add [PRJ_ConstructionProject]CP_ConstructionContractNo_s when call fails
//ut_PRJRetrieveCPName
//Only create or update [PRJ_ConstructionProject] if PRJ_ConstructionContract_atxt{$Loop_l} is not blank
//ut_PRJRetrieveConstructionCont


// Modified Table(s) : 
//[TunnelInfo]
//Added fields :
//[TunnelInfo]SpecialInsp(1-3)Date_d
//[TunnelInfo]SpecialInsp(1-3)Desc_s
//[TunnelInfo]SpecialInsp(1-3)Freq_i

//**********`Modified by: Costas Manousakis-(Designer)-(9/6/13)
// Modified Forms : 
//[Bridge MHD NBIS];"TunnelSIA "
//  `Modified some labels - made some of the information invisible
//  `Modified the info shown under the Inspections section

//[TunnelInfo];"TunnelInput"
//  `Modified the info shown under the Inspections section- added new  TunnelInfo Inspection fields and fields from bridge table

// Modified Forms : 
//[Bridge MHD NBIS];"SI & A Input"
//  `Named inspection data fields to DE BridgeInsp@

// Modified Method(s) : 
//SIA_SecureInputForm
//  `For tunnel records lock all inspection fields - must be entered in the Tunnel SIA input form

//**********`Modified by: Costas Manousakis-(Designer)-(9/9/13)
// Modified Forms : 
//[Inspections];"TunnelReprtTemplate"
//  `adjusted format of year rehab,  added var INSP_TunnelStructType_txt with obj method; made horiz 2 points

//[Inspections];"TunnelReprtTemplate"
//  ` Method: Object Method: [Inspections].TunnelReprtTemplate.INSP_TunnelStructType_txt


// Modified Method(s) : 
//COMPILER_Inspections
//  `INSP_TunnelStructType_txt
//PRINT_TunnelAllItems_F
//G_CountRTNInspPgs
//  `call Print_Tunnel_Cmts for both TAL and TOV inspections

// Modified Object Methods : 
//[Inspections].TunnelInspection.vbI59Collcmts 
//[Inspections].TunnelOverheadInspection.vbI59Collcmts 
//  `adjusted Title of window

//r001 ` Changes in cloning to use arrays whenever possible and to allow for selection updates instead of only all
//ut_ControlClone 
//ut_CreateSQLVariables
//CloneTables form 
//Method: Object Method: CloneTables.Button1
//Compiler_Clone
//Clone_ArrayToSelection 
//Method: Object Method: CloneTables.ProcessListBox_l
//clone_BuildFieldDropDown 
//clone_DeleteSelection 
//Clone_ReturnFieldNumber 
//clone_ReturnUniqueKeys 
//Clone_UpdateRecords
//clone_UpdateLocalTable 
//Clone_UpdateRecords 
//ut_CloneSetUpSelectInto
//ut_CreateSQLVariables
//ut_GetBlobs
//ut_ProcessBlobs
//ut_MoveElements
//Modified by: Charles Miller (9/10/13 13:00:40)

//**********`Modified by: Costas Manousakis-(Designer)-(9/11/13)
// Modified Form / Methods : 
//[Dialogs];"InspDialog1"
//  `Added 2nd page for Tunnel inspections - move Cancel and OK to pg 0

// Modified Method(s) : 
//QR_InspSchedInfo
//QR_NextInspInfo
//M_inspSchedule
//fOutofFreq
//fCombineInsp 
//fUpforInsp 
//  `added handling of Tunnel inspections

// Created Method(s) : 
//Compiler_BridgeList
//Compiler_RemoveWarnings

//Modified by: Charles Miller (9/18/13 10:09:55)
//Add fields to [TunnelInspection] to track 
//Structural Collision Damage
//[TunnelInspection]StructuralCollisionValue_s
//[TunnelInspection]StructuralCollisionComments_txt
//Roadway collision damage
//[TunnelInspection]RoadwayCollisionValue_s
//[TunnelInspection]RoadwayCollisionComments_txt
//INSP_TunnelRtnPg1_2_FM 
//Compiler_TunnelInspections 
//[Inspections];"TunnelInspection"
//  `Method: aI62aCollisionDamage
//  `Method: aI62bCollisionDamage
//InitProcessVar

//**********`Modified by: Costas Manousakis-(Designer)-(9/25/13)
// Modified Method(s) : 
//ut_ReturnStructureName
//  `Make sure there is directories in the structure file 


//  ***************** PRESERVATION MODULE *************
// Modified Table(s) : 
//[Preservation_Meetings]
//[Preservation_Reviews]
//[Contract_Assignment_Maintenance]
//[Contract_Project_Maintenance]
//[Invoice_Maintenance]
//[Addendum_Maintenance]
//  `Added Fields

// Created Method(s) : 
//PRV_Variables
//PRV_ut_defReviewTypes
//PRV_ut_defDecisionTrees
//PRV_SortByPINFO_txt
//PRV_SortByPINFO_d
//PRV_SortByBRGINFO_s
//PRV_SetRowColor
//PRV_ReviewLB_OM
//PRV_ReviewInput_FM
//PRV_PTRERROR
//PRV_ProjBridgeInput_FM
//PRV_PopupMenuC
//PRV_MEETINGINP_FM
//PRV_ListTableValue
//PRV_ListAssignments
//PRV_LimitTableValue
//PRV_InvoicesLB_OM
//PRV_Invoice_FM
//PRV_InputForm_FM
//PRV_FillPersonnelDropDowns
//PRV_DisplayAssignments
//PRV_Decision_FM
//PRV_CTRLSelections
//PRV_CTRLListBoxes
//PRV_BridgeLB_OM
//PRV_AddReview_OM
//PRV_AddNewAssignment
//PRV_Addendum_FM
//PRV_AddAssignment_FM
//LB_ProcessContracAssigns
//COMPILER_Preservation

// Modified Method(s) : 
//ut_ScanSequences
//  `Added new sequences from preservation module


//**********`Modified by: Costas Manousakis-(Designer)-(9/26/13)
// Modified Method(s) : 
//Print_Tunnel_Cmts
//  `added checking for and printing comments in tunnel collision fields

// Created Method(s) : 
//INSP_CheckTunnelSpcFreq
//Description
//  `Check for any changes needed in the special member frequencies for Tunnel Inspections

// Created Form(s) : 
//[TunnelInfo];"SpecialFreqCheck"
//  `Form used in INSP_CheckTunnelSpcFreq

// Modified Method(s) : 
//TNL_InspData2Tunnel 
//  `added Check of special member frequencies method INSP_CheckTunnelSpcFreq

//End Mods_2013_09