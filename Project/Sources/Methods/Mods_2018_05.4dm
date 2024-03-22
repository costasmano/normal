//%attributes = {"invisible":true}
//Method: Mods_2018_05
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/01/18, 14:02:02
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
End if 
// add table [NTI_TunnelRatings]
//[NTI_TunnelRatings];"Input"
//[NTI_TunnelRatings];"TunnelRating_LB"
//[NTI_TunnelRatings];"UserMode"
//Change way ratings are selected and entered on tunnel insopections
//[NTI_TunnelInfo];"Input"
//[TIN_Inspections];"Input"
//NTI_CheckDependencies 
//NTI_InspectionInput_FM 
//FM_NTITunnelInput 
//FM_SaveTunnelRating 
//FM_TunnelRatingInput
//Tunnel_ReturnDescription
//Compiler_Tunnels
//Modify NTIED_Print printed form
//[NTI_TunnelInfo];"NTIED_Print"


//set to read only when appropriate
//INV_CreatePhotosList
//LB_Tasks

//Add menu to print certain inspections from [LSS_Inventory] list box
//Method: [LSS_Inventory].ListBoxOutput.bReport
//Add ability to print multiple inspections Inspection list on inventory input form
//[LSS_Inventory];"Input"
//  // Method: Object Method: [LSS_Inventory].Input.LSS_Print_L


//Set entry on new TIN input to Allow prefix of T or B\  //Allow prefix of T or B
//When B allow entry of ID and Vento Zone which does not match drop downs
//Both must be 3 characters
//[NTI_TunnelInfo];"New_TIN"
//Method: Object Method: [NTI_TunnelInfo].New_TIN.NTI_Prefix_txt
//  //Method: [NTI_TunnelInfo].New_TIN.NoEntry4_B
// //Method: [NTI_TunnelInfo].New_TIN.NoEntry6_B
//Method: NTI_SetEnterableForB


//Fix defect where if fewer characters not allowed
//ut_LimitLength//This is only used on New TIN input form


//**********`Modified by: Costas Manousakis-(Designer)-(5/11/18)
// Modified Table(s) : 
//[Status Report] 
//added field  Report]SD_Calc_New_b

//Add new fields[RatingReports]WithPedestrianAccess_b [RatingReports]WithRestrictions_b
//Set up which check boxes are enabled and disabled for thew following
//Only 1 of the follwong can be set to true
//[RatingReports]NoPosting
//[RatingReports]PostingWaived
//[RatingReports]RemainPosted
//[RatingReports]BridgeClosed
//If one of following set to true
//  //[RatingReports]NoPosting
//  //[RatingReports]PostingWaived
//  //[RatingReports]RemainPosted
//Then 
//[RatingReports]WithRestrictions_b  // can be entered and can be either true or false
//[RatingReports]WithPedestrianAccess_b // can not be entered and must be false
//If   //[RatingReports]BridgeClosed is set to true
//Then 
//[RatingReports]PostingWaived //can not be entered and must be false
//[RatingReports]WithPedestrianAccess_b  // can be entered and can be either true or false
//[RatingReports];"RatReportsIn"
//  //Method: [RatingReports].RatReportsIn.PostingStatus2
//  // [RatingReports];"RatReportsIn".PostingStatus1
//  //Method: [RatingReports].RatReportsIn.PostingStatus4
//  //Method: [RatingReports].RatReportsIn.PostingStatus3
//  //Method: [RatingReports].RatReportsIn.WithRestrictions_b
//  // [RatingReports];"RatReportsIn".WithPedestrianAccess_b
//RatRep_SetUpPosting (Field name(Self))
//RatRep_SetUpRestrictions

//Compiler_RatingRequests


// Fix issue where we are not checing for locked and loaded record during download 
//Modified by: Chuck Miller (5/17/18 16:45:49)
//Compiler_TransfLog
//ut_SQLDownloadNewRecords
//ut_SQLDownLoadLoadRecord
//ut_SQLUpdateLocalFields 
//ut_SQLUpdateLocalField 
//ut_SQLServerLink

//Write method to report on inspections still not completed withing 60 or 90 days
//Modified by: Chuck Miller (5/17/18 17:54:34)
// Server_ReportIncompleteInsp
//INSP_FillIncompleteInsp

//**********`Modified by: Costas Manousakis-(Designer)-(5/18/18)

// M_GenerateCondRep
//  `changes to allow for the new method of calculating SD
//  `use new dialog "BridgeStatRepParameters"

// ut_GenCondRepFromArchive
//  `ask for which method will be used in calculcating SD status (new FHWA (POOR=SD) or the old one
//  `Set new field [Status Report]SD_Calc_New_b depending on the type of SD Calculation.
//  `Set new fields [Status Report]UseLegacyOwner_b and [Status Report]DistrictMethod_L 
//  `depending on process vars STATREP_UseLegacyOwn_b and STATREP_DistrictMethod_L
//  `use form "BridgeStatRepParameters" te get the parameters

// [Status Report];"I_StatusReport"
//  `added on page 4 the new fields indicating the calculation methods - not enterable
// [Status Report];"O_StatusReport"
//  `re-arranged objects; moved object code from SRCreatedBy_txt into here

// [Status Report];"P_StatusReport_MDOT_5D"
//  `changed name of SD / FO label objects to OldSD, OldFO
// [Status Report];"P_StatusReport_HI"
//  `changed name of SD / FO label objects to OldSD, OldFO
// [Status Report];"P_StatusReport_MDOT"
//  `changed name of SD / FO label objects to OldSD, OldFO

// STATREP_ReportType
//  `use fields in status report instead of comment field
// STATREP_DefaultPrintForm
//  `for the new SD calc use "P_StatusReport_MDOT_POFA"

// SR_StatusRptPrint_FM
//  `adjust text of SD an FO labels depending on the calculation method of the report

// P_ReviewChanges
//  `make sure [owners of data] is RO or RW as needed

// [Activity Log];"Output"
//  `increased object sizes
// [Activity Log];"Input"
//  `made variables on form not editable; property adjustments to owners incl subform 

//Modified by: Chuck Miller (5/24/18 16:35:22)
//Add code to fix problem when downloading records as part of sycnh process as it did not check for lock status
//ut_SQLDownLoadLoadRecord
//ut_SQLServerLink 
//ut_SQLUpdateLocalField 
//ut_SQLUpdateLocalFields
//ut_SQLDownloadNewRecords

//Fix defect where empty [Activity Log] records creatd for [LSS_Photos] records
//when right click on picture and not phort record existed 
//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Signal"
//Changed DMeter Picture and UT Picture on all the above forms
//LSS_GotToInspectionPage
//End Modified by: Chuck Miller (5/24/18 16:35:22)


//**********`Modified by: Costas Manousakis-(Designer)-(5/29/18)
// Modified Method(s) : 
// SIA_Item8Category_OM
//  `removed reference to vIt8BrCatDes
// SIA_Item8Owner_OM
//  `removed reference to vIt8OwnerDes

// Modified Forms : 
// [Inspections];"Underwater Special Member"
//  `disabled entry of Inspection complete checkbox
// [Inspections];"Dive Form"
//  `disabled entry of Inspection complete checkbox
// [Inspections];"Dive LowCl"
//  `disabled entry of Inspection complete checkbox

//End Mods_2018_05