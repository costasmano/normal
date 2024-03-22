//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 09/01/16, 12:56:35
//----------------------------------------------------
//Method: Mods_2016_09
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_09
	//Modified by: Chuck Miller (9/1/16 12:57:08)
	
End if 

//  Make sure UUIDs are never sent to activity log
// Modified Method(s) : 
//FlushGrpChgs
//FlushChanges

//Change from FlushChanges to FlushGRPChanges
//Method: [Foundation Type];"Input"
//Method: [inspection type];"Input"
//Method: [Integral Bridge];"Input"
//procedure: [ElementDict];"NewElement"

//**********//Modified by: Costas Manousakis-(Designer)-(9/1/16)
// Modified Method(s) : 
//NTI_GetReviewGroups
//  //use full paths in the DOM searches
//NTI_GetInspRequirements
//  //use fuul xPath in the Dom search "/NTI_INSPREQ/INSPTYPE"
//NTI_LoadDOMTrees
//  //added exrta checks for blank db parameters
//ut_DOM_FindElmtRef
//  //for alpha text strings use f_trimstr to remove spaces , linefeeds etc.
//NTI_TININSPListBox_OM
//  //on Right Click build the popup menu dynamically
//NTI_DoReviewInspection
//  //added test code to do review

// Modified Form Methods : 
//Form Method: [NTI_TunnelInfo];"ListBoxOutput"
//  //call NTI_LoadDOMTrees

//**********//Modified by: Costas Manousakis-(Designer)-(9/6/16)
// Modified Forms : 
//[Inspections];"RailRoutinePrPg1"
//  //fixed variable  for Dive column vRdN60_10

//**********//Modified by: Costas Manousakis-(Designer)-(9/6/16)
// Modified Forms : 
//[LSS_Inspection];"TrafficSignalStructurePg2"
//[LSS_Inspection];"TrafficSignalStructurePg1"
//[LSS_Inspection];"SignStructurePg1"
//[LSS_Inspection];"SignStructurePg2"
//  //changed label for Inventory Number HS -HIN, SI - SIN
// Modified Object Methods : 
//[LSS_Inventory];"New_InventoryItem".LSS_StructureClass_atxt
//[LSS_Inventory];"Edit_SIN".LSS_StructureClass_atxt
//  //changed label for Inventory Number HS -HIN, SI - SIN
// Modified Form Methods : 
//[LSS_Inventory];"New_InventoryItem"
//[LSS_Inventory];"Edit_SIN"
//  //changed label for Inventory Number HS -HIN, SI - SIN
// Modified Method(s) : 
//LSS_FillPage1_FM
//  //changed label for Inventory Number HS -HIN, SI - SIN

////////
////////   **** End of Release 6.6.1 6-Sep-2016
////////

//**********//Modified by: Costas Manousakis-(Designer)-(9/8/16)
// Modified Method(s) : 
//ActualDataToAssignmnt
//  //calculate Indirect cost 1st and then NetFee; Added special case to distinguish between Tunnel column setup and Bridge;  make sure a Header row was read

////////
////////   **** End of Release 6.6.1.a 8-Sep-2016
////////

//**********//Modified by: Costas Manousakis-(Designer)-(9/9/16)
// Created Form(s) : 
//[TIN_Inspections];"ReviewComments" 
//  //New Form to print Review Comments
//[TIN_Inspections];"ReviewList"
//  //New Form to List TIN Inspections for review

// Created Method(s) : 
//NTI_ListPendingTINInsp 
// List the pending TIN Inspections
//NTI_InspReviewLB_OM
// Object method for the ListBox in the Review Pending TIN inspections
//NTI_ReviewList_FM
// Form Method for the TIN Inspection Review form

//**********//Modified by: Costas Manousakis-(Designer)-(9/12/16)

// Modified Method(s) : 
//ut_LSSControlPictureMod
//  //make sure the other buttons  on the DMeter tab become visible after loading a sketch.
// Modified Forms : 
//[NTI_TunnelInfo];"ListBoxOutput"
//  //Added button to open inspection review screen. Moved OK button to right.

//**********//Modified by: Costas Manousakis-(Designer)-(9/13/16)

// Modified Table(s) : 
//[NTI_TunnelInfo]
//  // Changed field NTI_WillBeUUUIDKeuy_s to NTI_Future_b ; removed index- an AutoUUID field [NTI_TunnelInfo]NTI_TunnelInfo_UUIDKey_s was created

// Modified Method(s) : 
//LB_Tasks  ***** v15 only
//  //For Query selection make sure it is a Q_in_Sel by intersecting the results with the start set.
//M_SearchSel  ***** v15 only
//  // Make sure QuerySelection is done in selection by intersecting the results with the start set.

//**********`Modified by: Costas Manousakis-(Designer)-(9/14/16)
// Modified Form Methods : 
//[Cond Units];"CondUnitsPrt3"
//  // added search on BMS Elements

// Modified Method(s) : 
//CU_Print_FM
//  // added search on BMS Elements ; and an extra Else in the case statement when called from Print Selection
//INSP_PreviewBrM 
//  //use NTI_PrintNTEList for Cond Units also

// Modified Method(s) : 
//LTR_GetSVGVertCLRPic  ***** v15 only
//LTR_GetTruckPostPic  ***** v15 only
//SVG_ApplyScale  ***** v15 only
//SVG_FindSetTspan  ***** v15 only
//  //Re-enabled all SVG plugin calls - were disabled in v11

//**********`Modified by: Costas Manousakis-(Designer)-(9/15/16)
// Modified Method(s) : 
//prt_substdrep
//  `Added a Set print option(Orientation ;2) before the print form to make sure it is landscape

// Created Method(s) : 
//FORM_FixHairLine
// fixes printing problem of hairlines in 15.2 by making their size at least 1 pix

// Modified Methods and Form Methods : 
//11 project methods and 25 form methods
//  //added call to FORM_FixHairLine in the On Printing Detail event


//**********`Modified by: Costas Manousakis-(Designer)-(9/23/16)
// Modified Forms : 
//[LSS_Inspection];"TrafficSignalStructurePg1"   -- copied to v15
//  `increased size of  LSS_ROUTE_s field

//**********`Modified by: Costas Manousakis-(Designer)-(9/26/16)
// Modified Forms : 
//[RatingMember];"RatElmInc"
//  `modified  display format of ratings to show "N/A" for negative values
//[RatingMember];"RatMemberIn"
//  `modified  display format of ratings to show "N/A" for negative values
//  `added button "N/A" to enter -1 in all inv ratings 

//**********`Modified by: Costas Manousakis-(Designer)-(9/27/16)
// Modified Object Methods : 
//Object Method: [Contract Assignments];"Assignments In".btnRetrieveCost 
//  `Modifed to use TableOfList lists CONSRTG_ACTCOSTST and CONSINS_ACTCOSTST to get the status 
//  `that all BINs must be in for actual costs to be calculated.
//Object Method: [Cons Inspection];"Cslt Insp In".cboAssignmentStatus 
//  `Use TOL_ListToArray to load the list CONSINS_ASSIGNSTAT for this dropdown
//Object Method: [Conslt Rating];"Cslt Rating In".cboAssignmentStatus 
//  `Use TOL_ListToArray to load the list CONSRTG_ASSIGNSTAT for this dropdown

//**********`Modified by: Costas Manousakis-(Designer)-(9/28/16)
// Modified Forms/FormMethod : 
//[Inspections];"Dive Pr Pg 2 wrt"
//  `adjusted form header to 0; added vPageNo:=vPageNo+1 on print detail; moved REMARKS to center

// Created Form(s) : 
//[Inspections];"Culvert Pr Pg 2 wr"
//  `copied from [Inspections];"Culvert Pr Pg 2" and modified to print a 4D Write area instead of a pictiure

// Created Method(s) : 
//Method: Insp_PrintRemarks
//Description
// Print Inspection remarks assembled in a 4D Write area using a form with a 4D Write area on it.
// Replaces the method of using the result of WR Build Preview.
// Parameters
// $1 : $Area
// $2 : $FirstPageForm_txt (Optional) Form to be used o print the first page

// Modified Method(s) : 
//`Compiler_Inspections
//  `Added Insp_PrintRemarks

// Modified Method(s) : 
//INSP_FRZ_PrintCmts
//Print_CUL_Cmts
//Print_Dive_Cmt_a_new 
//Print_RTN_Cmts 
//Print_Tunnel_Cmts
//  `added temp call to Insp_PrintRemarks when user is design access

//End Mods_2016_09