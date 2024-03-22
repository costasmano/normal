//%attributes = {"invisible":true}
//Method: Mods_2018_01
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 01/02/18, 12:01:18
	// ----------------------------------------------------
	//Created : 
	Mods_2018_01
	Mods_2017_12
End if 
//
//Continue with new tin inspection print form and fields

//FM_All_Items_Tunnel_Inspection
//Compiler_FieldVariables 
//clone_ClearFieldVariables 
//Clone_ArrayToSelection 
//TIN_SetYNorNA 
//SFA_getServerFileList 
//NTI_PrintNTEList 
//NTI_PrintInspection 
//NTI_Print_TIN 
//NTI_InspectionInput_FM 
//NTI_FillDropDowns 
//NTI_AddTIN_Inspection
//ut_CheckRatingBDEPTandBIN 
//[TIN_Inspections];"Input"
//[NTI_ELEM_TIN_INSP];"All_Item_Tunnel_Inspection_2"
//[NTI_ELEM_TIN_INSP];"All_Item_Tunnel_Inspection_1"
//New fields
//[TIN_Inspections]ActualFieldMeasure_L
//[TIN_Inspections]PostedClearance_L
//[TIN_Inspections]SigninPlaceAdvance_s
//[TIN_Inspections]SigninPlaceAtTunnel_s
//[TIN_Inspections]RatingReport_d
//[TIN_Inspections]RatingReportDateofInsp_d
//[TIN_Inspections]RatingReportInvertGirder_s
//[TIN_Inspections]RatingReportInvertSlab_s
//[TIN_Inspections]RatingReportRoofGirder_s
//[TIN_Inspections]RatingReportYN_B
//[TIN_Inspections]WeightPostingActual3_r
//[TIN_Inspections]WeightPostingActual3S2_r
//[TIN_Inspections]WeightPostingActualH_r
//[TIN_Inspections]WeightPostingActualSingle_r
//[TIN_Inspections]WeightPostingNA_B
//[TIN_Inspections]WeightPostingRec3_r
//[TIN_Inspections]WeightPostingRec3S2_r
//[TIN_Inspections]WeightPostingRecH_r
//[TIN_Inspections]DamageBy_s
//[TIN_Inspections]DamageDate_d
//[NTI_TunnelInfo]NTI_Segment_s
//[NTI_TunnelInfo]NTI_Contracts_s


//Modified by: Chuck Miller (1/11/18 14:15:56)
//Add inspection type to display
//[NTI_TunnelInfo];"InspectionList"
//NTI_TININSPListBox_OM 
//Changed description from routine to all items
//NTI_AddTIN_Inspection 


//work on some picky special issues on form
//[NTI_ELEM_TIN_INSP];"All_Item_Tunnel_Inspection_1"
//NTI_ELEMINP_TIN_FM 
//NTI_CreateParams 
//Compiler_FieldVariables 
//clone_ClearFieldVariables 
//Clone_ArrayToSelection


//Retokenized to fix issue when changing from LSS_PushGroupChanges to ACT_PushGroupChanges
//add_change_del code
//LSS_UpdateDMeterorUltraPicture 
//LSS_SetPrevNextButtons 
//LSS_InspectionRecSave 
//LSS_AccessibilitySave 
//FM_TeamMembersInput 
//FM_SaveVerticalClearance 
//FM_SaveUTResults 
//FM_SaveUT 
//FM_SaveTunnelInfo 
//FM_SaveTowerDistance 
//FM_SaveSignPanel 
//FM_SavePhotoInput 
//FM_SaveInventoryInput 
//FM_SaveElementInspection 
//FM_SaveDMeter
//NTI_SaveImage 

//Enable or disable preview button depending on page
//Method: [TIN_Inspections].Input.Tab Control

//chnage title on tunnel inspection reports
//NTI_Print_comments_TIN 
//NTI_PrintSketchChart 
//NTI_PrintInspection 
//NTI_PrintImages 
//[NTI_ELEM_TIN_INSP];"All_Item_Tunnel_Inspection_2"

//Change method of showing preview on tunnel inspection to use following form with only appropriate items chec
//Object Method: [TIN_Inspections];"Input".vPrintPreview 
//Object Method: [TIN_Inspections];"Input".print
// "PrintTINInspRpt"


//**********`Modified by: Costas Manousakis-(Designer)-(1/16/18)
// Modified Forms : 
// [Inspections];"Closed Bridge"
// [Inspections];"Closed Insp Pg1"
// [Inspections];"Culvert Combined"
// [Inspections];"Culvert Pr Pg 1"
// [Inspections];"CulvertPrPg1_v2"
// [Inspections]RailCulvertCombined-RRC
// [Inspections]RailRoutine Culvert
// [Inspections]RailRoutine Arch Pr Pg 2
// [Inspections];"Routine Combined"
// [RAILBridgeInfo];"RailRoutinePrPg2"
// [RAILBridgeInfo];"RailRoutinePrPg2"
// [Inspections];"RailRoutineInput"
// [Inspections];"Routine Pr Pg 2"
// [Inspections];"RoutineNewNBE"
// [Inspections];"RoutinePrPg2_v2"
// [Inspections];"TunnelInspection"
// [Inspections];"TunnelOverheadInspection" 
// [Inspections];"TunnelOverPg1"
// [Inspections];"TunnelRoutinePg1"
// [Inspections];"RailRoutine Arch Pr Pg 1"
// [Inspections];"TunnelRoutinePg1-sample"
//  `increased allowed entry in Total Hrs


//End Mods_2018_01
