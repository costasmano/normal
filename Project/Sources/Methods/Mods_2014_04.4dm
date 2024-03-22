//%attributes = {"invisible":true}
//Method: Mods_2014_04
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/02/14, 17:26:44
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04
End if 
//
// Created Method(s) : 
//ARCHIVE_UpdateRecord
//  `Update a record in the Archive table from the corresponding record in the main Bridge table
//  `Used in cases where errors/corrections made in SIA data in main table and a resubmission was made
//  `to FHWA for the corrections only.

// Modified Object Methods : 
//[BridgeMHDNBISArchive].Output.ARCH_TOOL_BTN_L 
//  `Added ability to get the tools arrays from the parameters table


//**********`Modified by: Costas Manousakis-(Designer)-(4/7/14)
// Created Method(s) : 
//ARCHIVE_MatchFields 
//  ` Match fields between a source tabel and the archive table; fill arrays with required pointers
// Parameters
// $1 : $SourceTable_ptr
// $2 : $ArchTable_ptr
// $3 : $SourceFldsarray_ptr
// $4 : $ArchFldsarray_ptr
// $5 : $ReasonFld_ptr
// $6 : $DateFld_ptr

// Modified Method(s) : 
//ARCHIVE_Store
//  `Use new method ARCHIVE_MatchFields to match the fields from the source to the archive table
//COMPILER_Archive
//  `added method ARCHIVE_MatchFields

//**********`Modified by: Costas Manousakis-(Designer)-(4/10/14)
// Modified Method(s) : 
//G_AddPontisToCombined
//INSP_TeamLeader_OM
//INSP_aBIE_OM
//INSP_aUOE_OM
//INSP_aDiveMaster_OM
//INSP_UWSaveInsp
//  `removed check for app version (◊LNK_CHANGE_Vers ) - use LogLink for all cases

// Modified Method(s) : 
//Duplicate_Inspection
//  `for Freeze thaw inspections, if  there is a text in the blob comments , move it to top of Comments and set the  blob to zero

// Created Form(s) : 
//[BridgeRankCalc];"Input"
//[BridgeRankCalc];"Output"
//[BridgeRankResult];"Input"
//[BridgeRankResult];"Output"


//**********`Modified by: Costas Manousakis-(Designer)-(4/14/14)
// Modified Forms : 
//[RAILBridgeInfo];"RailInput"
//  `added 315K rating loads in page 1, view 1

// Created Method(s) : 

//INSP_CountSpMbOnForm
//  `Count the number of Special members on current form.
//  `will count the number of vMemberX variables on the form.
// Parameters
// $0  : $NumMembers_L

//INSP_SetSpMbPrintForm
//  `Set the required special member form and elements per page
// Parameters
// $1  : $InspType_txt

// Modified Method(s) : 
//Print_SpecMem_pg1
//Print_SpecMem_pg3
//  `use method INSP_SetSpMbPrintForm to get form names and element counts

//**********`Modified by: Costas Manousakis-(Designer)-(4/15/14)
// Created Table(s) : 
//[ElmtRatingLoads]

// Created Method(s) : 
//INSP_SetElmtRtgVisibility
//  `Set the visibility of load rating fields and add if needed a record for [ElmtRatingLoads]

//INSP_ElmtLoadRated_OM
//  `New method for the Element Rated checkbox in ElementSafety input forms

// Modified Object Methods : 
//Object Method: [ElementsSafety].SafetyElementInputEx.vLoadRtgNA 
//Object Method: [ElementsSafety].Safety ElmInput.vLoadRtgNA 
//  `rating loads table added use  INSP_ElmtLoadRated_OM
//Object Method: [ElementsSafety].Safety ElmInput.SpecMemb Flag 
//  `use INSP_SetElmtRtgVisibility

// Modified Forms : 
//[ElementsSafety];"Safety ElmInput"
//[ElementsSafety];"SafetyElementInputEx"
//  `added fields for table [ElmtRatingLoads]

// Modified Method(s) : 
//G_InitInspVars
//  `added call to set INSP_MBTABridgeType_txt
//INSP_ElmSft_Input_FM
//  `added [ElmtRatingLoads] table
//Compiler_Inspections
//  `added INSP_MBTABridgeType_txt ; INSP_ElmtLoadRated_OM
//Duplicate_Inspection
//  `added table [ElmtRatingLoads] in the duplications sequence

//**********`Modified by: Costas Manousakis-(Designer)-(4/15/14)
// Modified Method(s) : 
//INSP_ExportInspection 
//  `added export of  [ElmtRatingLoads]

//INSP_ImportInspection
//  `added import of  [ElmtRatingLoads]


//**********`Modified by: Costas Manousakis-(Designer)-(4/22/14)
// Modified Table(s) : 
//[RAILBridgeInfo]
//  ` added fields [RAILBridgeInfo]Rating_HybridArtic_inv_r [RAILBridgeInfo]Rating_HybridArtic_oper_r
//[ElmtRatingLoads]
//  `added field [ElmtRatingLoads]R_HybridAritc_r


// Modified Forms : 
//[Bridge MHD NBIS];"RAIL_SIA_Input"
//[Bridge MHD NBIS];"RailTransitSIA"
//  `added Hybrid Artic loads under HWYRtg bridge loads

// Created Method(s) : 
//INSP_RailFCPg1_FM
// method for printing the MBTA hwy / rail / transit fract crit / CMI forms
// Parameters
// $1 : $FormEvent_L

//**********`Modified by: Costas Manousakis-(Designer)-(4/22/14)
// Modified Forms : 
//[Bridge MHD NBIS];"SI & A Input" 
//  `added Hybrid Artic loads under MBTARtg bridge loads

//**********`Modified by: Costas Manousakis-(Designer)-(4/22/14)
// Modified Method(s) : 
//PRINT_SIA
//  `Removed the querying of Rail info and tunnel info. not necessary since this is called from input form where records are already loaded.

//**********`Modified by: Costas Manousakis-(Designer)-(4/25/14)
// Created Method(s) : 
//INSP_LoadElmRtgDefs
//  ` Set up arrays for element ratings 
// Parameters
//$0 : $Numratings_L
// $1 : $VarPrefArray_ptr
// $2 : $FieldArray_ptr

//INSP_SetElmRatingValue
//  ` Set the value of element load ratings
// Parameters
// $1 : $RatingFiledArray_ptr
// $2 : $Value_r

// Modified Method(s) : 
//INSP_ElmtLoadRated_OM
//  `use methods INSP_LoadElmRtgDefs and INSP_SetElmRatingValue

//INSP_ReturnCMLength
//  `added  case for rail inspections and check for MBTA bridges

//G_Insp_AddGenCmts 
//G_Insp_AddOrientation 
//  `removed setting font and size

//COMPILER_InspElmtVars
//  `added Bus load and transit load ratings

//G_Insp_SetTitle
//  `For MBTA  fracture critical - add the bridge type 

//**********`Modified by: Costas Manousakis-(Designer)-(4/28/14)
// Modified Method(s) : 
//INIT_UI_GV
//  `LStackSize set to 1024*1024


//End Mods_2014_04