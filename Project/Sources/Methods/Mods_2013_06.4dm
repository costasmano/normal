//%attributes = {"invisible":true}
//Method: Mods_2013_06
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/04/13, 09:57:20
	// ----------------------------------------------------
	//Created : 
	Mods_2013_06
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(6/4/13)
// Modified Forms : 
//[Contract Invoice]ContractInvoice In 
//  `set double-click on line and double-click on empty line to no action in  included assignment form 

//**********`Modified by: Costas Manousakis-(Designer)-(6/6/13)

// Modified Forms : 
//[RAILBridgeInfo];"RailInput"
//  `adjusted size of tab and set min hor and vert size - fixed spelling of Fatigue label

// Created Method(s) : 
//ut_WindowSize
//  ` Get curr window size and match window size to a previous dim
// Parameters
// $1 : $Task_txt "GET" | "MATCH" | "FITFORM"
// $2 : $WindowW_ptr
// $3 : $WindowH_ptr
// $4 : $Tbl_ptr (optional)
// $5 : $FormName_txt (optional - required if $4 is passed)

// Modified Method(s) : 
//COMPILER_Utilities
//  `added  ut_WindowSize

// Modified Method(s) : 
//SIA_BridgeInpNavCTRL
//  `in rail road info use new method ut_WindowSize to control window size 

// Modified Object Methods : 
//Method: Object Method: [Bridge MHD NBIS].Bridge Input.bTunnelSIA
//  `use new method ut_WindowSize to control window size 

// Modified Method(s) : 
//InitPers
//  `Added code to modify the  aAgency array to include employers of active inspectors from the personnel table
//  `Don't change RO state of  [Personnel] table if already read only

//**********`Modified by: Costas Manousakis-(Designer)-(6/7/13)
// Modified Method(s) : 
//INSP_InspReviewControl
//  `initialize ◊INSP_HWYBrgReview_b  INSP_RailBrgReview_b ◊INSP_TunnelReview_b  to false

// Created Method(s) : 
//Method: INSP_GetAllInspections
//Description
//  `Get all inspections that belong to me.  Called from a hidden button
//  `in Inspection review form mapped to Shift-cmd-G

//**********`Modified by: Costas Manousakis-(Designer)-(6/10/13)
// Created Form(s) : 
//[Inspections];"CustomInput"
// Created Method(s) : 
//Method: INSP_ut_ModInspRecord
//  `Description
//  ` Modify key fields in an Inspection record. Designed to run only from the Adminsitrative
//  `item under the Special menu.  Should only be run on the Central Boston server from a client

// Modified Forms : 
//[RAILBridgeInfo];"RailInput"
//[Bridge MHD NBIS];"RailTransitSIA"
//  `changed label Work Car to  Work Car Combination

//```
//```   **** End of Release 6.2.0.a 6/11/13
//```

// Add update progress bar and change code to deal with adjusted user names
//Modified by: Charles Miller (6/13/13 16:27:04)
//New form OneArrayLB
//ut_ControlLoadUserAndGroups
//ut_SaveUserLogInInformation 
//ut_LoadUserLoginInformation

//**********`Modified by: Costas Manousakis-(Designer)-(6/14/13)
// Created Method(s) : 
//TNL_InspData2Tunnel
//  ` Handle the copy of data from tunnel inspection report to SIA;
//  `Two steps 
//  `  `a) from [Inspections] to SIA ;
//  `  `b) [tunnelinspection] to [tunnelinfo]

// Modified Method(s) : 
//INSP_InspData2SIA
//  `Added case for Tunnel All items TAL and Overhead items TOV inspections.

//**********`Modified by: Costas Manousakis-(Designer)-(6/18/13)
// Modified Method(s) : 
//ARCHIVE_ExportNBI
//ARCHIVE_ExportNBItabDelim 
//  `Added $item8_txt to get fhwaItem8 field if it is populated

//COMPILER_Archive
//  `Added ARCHIVE_utCheckFields and  moved all archive method declarations here

// Modified Object Methods : 
//[BridgeMHDNBISArchive].Output.ArchiveReason_atxt
//[BridgeMHDNBISArchive].Output.ArchiveDate_ad
//  `added RegionTitle

// Created Method(s) : 
//Method: ARCHIVE_utCheckFields
//Description
//  `Verify that all fields in the master table are in the archive table
//  `Fields are named the same; verify fields exist; fields are same type; length is same for strings
// Parameters
// $1 : $MasterTbl_ptr
// $2 : $ArchiveTbl_ptr

//Method: ARCHIVE_UpdateField
//Description
//  `Update a field in the Archive table from the corresponding field in the main Bridge table
//  `Used in cases where errors/corrections made in SIA data in main table and a resubmission was made
//  `to FHWA for the corrections only.
// Parameters


//r001 ` Add code to alow for add, delete and duplicate 
//[InventoryPhotoInsp] and [InventoryPhotos]
//Modified by: Charles Miller (6/20/13 13:15:13)
//INV_GetBINInventoryPhotos
//INSP_DuplicateInventoryPhotos
//Method: Object Method: [Bridge MHD NBIS].Bridge Design.BridgeDesign
//Method: Object Method: [Bridge MHD NBIS].Bridge Input.bAddInvInsp

//Fix compiler issues with the following
//ut_ControlLoadUserAndGroups
//ut_SaveUserLogInInformation 
//ut_LoadUserLoginInformation

//**********`Modified by: Costas Manousakis-(Designer)-(6/21/13)
// Modified Form Methods : 
//Form Method: [Bridge Design]Bridge Design In 
//  `Moved FlushGrpChgs (2;->[Bridge MHD NBIS]BIN before the save record([Bridge MHD NBIS])

// Modified Object : 
//Object : [Bridge Design].Bridge Design In.vbDelete_BrgDes 
//  `Removed the auto  Delete action of the button - deletion handled in button method


//End Mods_2013_06