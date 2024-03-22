//%attributes = {"invisible":true}
//Method: Mods_2017_07_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/06/17, 14:58:11
	// ----------------------------------------------------
	//Created : 
	Mods_2017_07_bug
End if 
//

// [Personnel];"Inspectors Out"
//  `changed fields to be not-transparent, and made background same color as the rect behind.
//  //(If transparent there was no row hilighting)


//Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
//SIA_ControlDoubleClick 
//SIA_BridgeInput_FM 
//SCPOA_InpFormMethod_A 
//SCPOA_DetBrgListBx_OM 
//RtgReq_AdtlLB_OM 
//PRV_ReviewLB_OM 
//PRV_InputForm_FM 
//PRV_BridgeLB_OM 
//PON_NBE_LB_OM 
//PON_ELEMPROTLB_OM 
//PON_ELEMDAMLB_OM 
//NTI_TININSPListBox_OM 
//NTI_TinINSP_ImageLB_OM 
//NTI_ReviewList_FM 
//NTI_NTE_LB_OM_TIN 
//NTI_NTE_LB_OM 
//NTI_InspReviewLB_OM 
//NTI_InspectionInput_FM 
//NTI_ELEMDAMLB_OM 
//LSS_ModifyVerticalClearance 
//LSS_ModifyUTResults 
//LSS_ModifyUT 
//LSS_ModifyTowerorPost 
//LSS_ModifySignPanels 
//LSS_ModifyPhotos 
//LSS_ModifyElement 
//LSS_InspReviewLB_OM 
//LSS_ControlDmeterModification 
//FM_InspectionInput 
//DCM_WO_Input_FM 
//DCM_WO_BrgList_OM 
//DCM_P_Input_FM 
//DCM_C_Input_FM 
//CRTG_ReviewLBControl 
//CRTG_ReviewLB_OM 
//Compiler_Utilities
//PRV_InvoicesLB_OM
//CINSP_LBControl 
//clone_MoveElements 
//INV_InvInspListObjM 
//INV_PhotoListObjM 
//LB_ProcessContracAssigns 
//LSS_ModifyElement 
//LSS_ModifyUT 
//Mods_2017_07_bug 
//NTI_ELEMDAMLB_OM 
//NTI_InspReviewLB_OM 
//NTI_NTE_LB_OM 
//NTI_NTE_LB_OM_TIN 
//NTI_TinINSP_ImageLB_OM 
//NTI_TININSPListBox_OM 
//PON_ELEMDAMLB_OM 
//PON_ELEMPROTLB_OM 
//PON_NBE_LB_OM 
//PRJ_DC_OpenProjectDetail 
//PRV_BridgeLB_OM 
//PRV_InvoicesLB_OM 
//PRV_ReviewLB_OM 
//RtgReq_AdtlLB_OM 
//RtgReq_LB_OM 
//SCPOA_DetBrgListBx_OM 
//SCPOA_FieldNotes_OM 
//SCPOA_PhotoListBox_OM 
//SIA_ControlDoubleClick



// Method: Object Method: OmitList_HL
//Object Method: hL2 on [Dialogs];"Inspection"
// Object Method: PRJ_UnassignedBins_atxt
// Object Method: aIt8OwnerDesIncluded
//Method: Form Method: [Contract_Assignment_Maintenance]PreservationList
//Method: [Contract_Assignment_Maintenance].PreservationList.SelectListBox
//Method: [DCM_Contracts].DistrMaintInput.DCM_AssgnListBox
//Method: [DCM_Contracts].DistrMaintInput.DCM_CO_BR_LB


//Method: [DCM_Contracts].DistrMaintInput.DCM_AssgnListBox
//Method: [DCM_Contracts].DistrMaintInput.DCM_CO_BR_LB
//Method: [Inspections].TunnelInspection
//Method: [LSS_Inspection].LSS_InspectionLB
// Method: Object Method: [LSS_Inventory];"ListBoxOuput".List Box
//Method: Object Method: [NTI_TunnelInfo].Input.AvailableBins_LB
//Method: Form Method: [NTI_TunnelInfo];"ListBoxOutput"
//Method: [Inspections].TunnelInspection
//Method: Form Method: [NTI_TunnelInfo];"ListBoxOutput"
//Method: Object Method: [NTI_TunnelInfo].OutputListBox.List Box
//Method: Object Method: [ServerProcesses].Output.SelectListBox
//PON_ELEMINP_FM 
//INV_CreatePhotosList 
//FM_NTITunnelInput 
//RtgReq_Input_FM  
//SCPOA_DetBrgListBx_OM


//This one has to be changed to a real LB
//INV_InvInspListObjM


//next 2 probably do not matter
//Method: Object Method: [NTI_TunnelInfo].Input.SelectedBins_LB
//Method: Form Method: [LSS_Inspection]."InspectionReview"


//Tghe following methdos not changed as they did not appear to be used anyplace
//DCM_ProjDailyControl_OM

//Changed form group arrays to selection list box
//[InventoryPhotoInsp];"Input"

//Mods_2017_07_bug   //Fixed spelling mistakes on two forms
//[PON_ELEM_INSP];"SearchNBE"
//[PON_ELEM_INSP];"Input"

//Completed 10- year rating report
//M_Create10YearRating 

//Modified by: Chuck Miller (7/28/17 14:50:51)

//


//Modified by: Chuck Miller (8/15/17 12:05:44)

//End Mods_2017_07_bug