//%attributes = {"invisible":true}
//Method: Mods_2018_10
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/03/18, 13:30:59
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(10/3/18)
// [LSS_Inspection];"TrafficSignalStructurePg1"
//Form Method: [LSS_Inspection];"SignStructurePg1"
//Form Method: [LSS_Inspection];"LightStructurePg1"
//Form Method: [LSS_Inspection];"ITSStructurePg1"
//  `added Owner to top row
//  `All header box data fields Arial9

//**********`Modified by: Costas Manousakis-(Designer)-(10/4/18)
// [LSS_Inventory];"ListBoxOutput"
//  `added Owner column to ListBox
// LSS_SortStructureType
//  `added sorting by Owner
// FM_InventoryInput
//  `added Owner
// LSS_LoadArraysForInputForm
//  `added calls to load v_165_034_atxt array for Owners
// [LSS_Inventory];"New_InventoryItem"
//  `added dropdown on form and code for [LSS_Inventory]LSS_Owner_s
// [LSS_Inventory];"Input"
//  `added dropdown for [LSS_Inventory]LSS_Owner_s

// Created Method(s) : 
//Method: Alert_DateTime
//Description
// Alert user if date and time of copmuter is more than a couple of hours off from internet time.
// currently only works on OSX computers

//**********`Modified by: Costas Manousakis-(Designer)-(10/12/18)
//Method: LSS_ModifyOwner
//Description
// modify the owner of selected records from the inventory list
// Modified Object Methods : 
//Method: [LSS_Inventory].ListBoxOutput.Tools
//Description
//

//**********`Modified by: Chuck Miller (10/11/18 16:42:35)
//Add code and fields to allow for entry and reporting of single posting
//[RatingReports]RecSinglePosting_L
//[Bridge MHD NBIS]PostingSingle
//[BridgeMHDNBISArchive]PostingSingle

//[RatingReports];"RatReportsIn"
//    //Method: [RatingReports];"RatReportsIn".Field23
//RatRep_SetUpRestrictions 

//[Bridge MHD NBIS];"SI & A Input"
//    //Method: [Bridge MHD NBIS];"SI & A Input".Field199
//    //Method: [Bridge MHD NBIS];"SI & A Input".Field200
//    //Method: [Bridge MHD NBIS];"SI & A Input".Field201
//    //Method: [Bridge MHD NBIS];"SI & A Input".SinglePosting

//G_SIA_GetRecPostings
//G_CBWeightPosting 
//G_CulverttoBMS 
//G_FracCrit2BMS 
//G_SIA2Inspection 
//LTR_VerifyTruckPosting   

//[Bridge MHD NBIS];"TunnelSIA"
//[Bridge MHD NBIS];"SI & A (Insp)"
//[Bridge MHD NBIS];"SI & A (Normal)"
//[Bridge MHD NBIS];"MHD Specific Items"

//[Conslt Rating];"RatingPrintForm_2"
//[Conslt Rating];"Rating Print Form"
//[Bridge MHD NBIS];"SI & A Input"
//[BridgeMHDNBISArchive];"SI & A (Normal)"
//[BridgeMHDNBISArchive];"SI & A (Insp)"
//[BridgeMHDNBISArchive];"MHD Specific Items"
//G_RoutinetoBMS 
//G_InspGetRatings 

//**********`Modified by: Costas Manousakis-(Designer)-(10/12/18)
// Modified Forms : 
// [LSS_Inspection];"Input_Signal"
// [LSS_Inspection];"Input_Sign"
// [LSS_Inspection];"Input_Light"
// [LSS_Inspection];"Input_ITS"
//  `changed headers of ut results colummns
// [LSS_UtResult];"Input"
//  `changed headers of Location field
// [LSS_UT];"UTPrintPg2"
//  `changed headers of ut results and re-arranged columns to match page1 of ut
// [LSS_UT];"UTPrint"
//  `changed headers of ut results

//**********`Modified by: Chuck Miller (10/17/18 16:42:35)
//new Method: LSS_NonDamageAddHeader
// LSS_PrintInspection
//  `use LSS_NonDamageAddHeader

//Date and time: 10/18/18, 11:18:58
//Method: LSS_FillTeamMembers
//Description
// G_CBWeightPosting
//Add code and fields to allow for entry and reporting of single posting

//**********`Modified by: Costas Manousakis-(Designer)-(10/19/18)
// Created Form(s) : 
//[Inspections];"RoutinePrPg3_New"


//**********`Modified by: Costas Manousakis-(Designer)-(10/23/18)
// LTR_VerifyTruckPosting
//  `changes for addition of field [Bridge MHD NBIS]PostingSingle

//**********`Modified by: Costas Manousakis-(Designer)-(10/25/18)
//Form: "SelectInvPhoto"
//Description
// dialog to select two inventory photos to be printed with bridge insp reports

//Method: INSP_CheckInvPhotoSelected
//Description
// check if the two inventory photos have been selected and if they exist.
// returns description of what is missing if anything
// Parameters
// $0 : $InvPhotoOK_txt

//**********`Modified by: Costas Manousakis-(Designer)-(10/26/18)
//Method: INSP_PostingEntry
//Description
// Called from on data change event of obj method of [Inspections]ActualPostxxx objects
// handle clearing single posting when H,3,3s2 are non-zero, and vice versa
// replaces the call to PushChange in the object methods
// Parameters
// $1 $changestack
// $2 $currobj_ptr

//Modified object methods of recommended posting and actual posting fields to use method INSP_PostingEntry
// Form [Inspections];"RailCulvertCombined-RRC"
// form [Inspections];"RoutineNewNBE"
// form [Inspections];"Routine Combined"
// form [Inspections];"Damage Form"
// form [Inspections];"Critical Member"
// form [Inspections];"Culvert Combined"

// method CheckDependencies
//  `changes : field [RatingReports]RecSinglePosting_L was added 

// Modified Object Methods : 
// [Bridge MHD NBIS];"SI & A Input".Variable197
//  `added field [Bridge MHD NBIS]PostingSingle and var vREcPostSingle
// [Bridge MHD NBIS];"SI & A Input".Variable Des Rating
//  `added field [Bridge MHD NBIS]PostingSingle

//**********`Modified by: Costas Manousakis-(Designer)-(10/29/18)
//Method: INSP_SelectInvPhotos
//Description
// Select the two inventory photos that will be printed with the current bridge inspection
//Method: INSP_UpdateSelInvPhotoLB
//Description
// Update the listbox of photos in the SelectInvPhoto dialog 
// Parameters

//**********`Modified by: Costas Manousakis-(Designer)-(10/30/18)
// [BridgeMHDNBISArchive];"SI & A (Insp)"
//  `Added single posting values - use method ARCH_Utils
//Method: [BridgeMHDNBISArchive];"Input".bPrint
//Description
//
// ARCH_Utils
//  `Additions for Single Posting fields
//  `added two tasks INITRRVARS  LOADRRVARS FILLPRINTVARIABLES
// mbta_ReturnBridgeType
//  `added optional parameter 1 for bridge category
// [BridgeMHDNBISArchive];"SI & A (Normal)"
//  `Added single posting values - use method ARCH_Utils
// [BridgeMHDNBISArchive];"MHD Specific Items"
//  `Added single posting values


//End Mods_2018_10
