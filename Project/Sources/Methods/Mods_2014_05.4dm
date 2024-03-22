//%attributes = {"invisible":true}
//Method: Mods_2014_05
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/02/14, 14:45:01
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(5/2/14)
// Modified Method(s) : 
//FM_SpecialExtra
//  `use method INSP_LoadElmRtgDefs to load the pointers for the load ratings;
//  `use these pointer arrays to load the element data
//  `use INSP_ReturnCMLength to get the remarks length

//**********`Modified by: Costas Manousakis-(Designer)-(5/6/14)
// Created Form(s) : 
//[Inspections];"RoutineSegmentalPg1"

//**********`Modified by: Costas Manousakis-(Designer)-(5/7/14)
// Created Method(s) : 
//INSP_GetTransitLoadDesc
//  `get the description of transit loads from other ElementSafety ratingload records


//**********`Modified by: Costas Manousakis-(Designer)-(5/14/14)
// Modified Method(s) : 
//ut_FitPrintFormObject
//  `added an increment between font size 1 and 9. changed the small size  box margin to 1

// Created Method(s) : 
//INSP_SetTransitRtgLabels
//  `set the printed label for transit load ratings in printed inspection forms -
//  ` works mainly for the TransitFCR forms
// Parameters
// $1 : $ElmRevCar_txt - collected from going thru the elements
// $2 : $ElmWorkCar_txt

// Modified Method(s) : 
//FM_SpecialExtra
//INSP_RailFCPg1_FM
//  `use method INSP_SetTransitRtgLabels - mainly for Transiit CMI, FCR inspections

//**********`Modified by: Costas Manousakis-(Designer)-(5/16/14)
// Created Form(s) : 
//[BridgeRankCalc];"Output"
//[BridgeRankCalc];"Input"


//**********`Modified by: Costas Manousakis-(Designer)-(5/19/14)
// Modified Method(s) : 
//ut_LoadBridgeRank
//  `use BrgRank_UpdSysParam
// Created Method(s) : 
//BrgRank_CopyToBridge 
//  `Copy rank from Bridge Rank Calculations to Bridge MHD NBIS table
// BrgRank_UpdSysParam
//Description
//  ` update the system parameter BRG_RANKINGDATE

//**********`Modified by: Costas Manousakis-(Designer)-(5/21/14)
// Created Method(s) : 
//BrgRank_DoRankCalc
//  ` Do the setup and Run Calculations for the Bridge Rank
//utf_ConnectedToBoston_b
//  ` Determines whether we are nunning as Client to the Boston Server or to the dev for testing. 
//  ` Parameters
//  ` $0 : $ConnectedToBoston_b
// SIA_Item5_OM
//  ` sets the variable and arrays used to enter Item 5
//  ` Parameters
//  ` $1 : $Item5Fld_ptr
//  ` $2 : $ChgStackNum_L
//  ` $3 : $FormEvent_L

// Modified Method(s) : 
//SIA_BridgeInpNavCTRL
//  `Enable Add Button for secondary records only in Boston and for InspectionReview Users

// Modified Forms and Form Method : 
//[NBIS Secondary];"2nd IN"
//  `Modifications to enable adding and editing secondary records
//  `with validation of item5

//**********`Modified by: Costas Manousakis-(Designer)-(5/22/14)
// Created Method(s) : 
//SIA_CheckOther2ND
//  ` Retrieves info on other Secondary records
// Parameters
// $1 : $OtherItm5arr_ptr
// $2 : $OtherItm6Aarr_ptr
// $3 : $BIN_s
// $4 : $Curr2NDKey_L

//SIA_GetItem5FromFeature
//  ` Determine parts of Item 5 based on the feature. returns 5B, 5C, 5D, 5E.
//  ` 5C - defaults to 1
// Parameters
// $1 : $Feature_txt
// $2 : $Item5b_ptr
// $3 : $Item5c_ptr
// $4 : $Item5d_ptr
// $5 : $Item5e_ptr

// Modified Method(s) : 
//Compiler_SIA
//  `added vars for Item5 

//**********`Modified by: Costas Manousakis-(Designer)-(5/23/14)
// Modified Object Methods : 
//[Bridge MHD NBIS].Bridge Input.bAdd
//  `added sorting by Item5

// Modified Method(s) : 
//COMPILER_Utilities
//  `added utf_ConnectedToBoston_b

//SIA_ControlDoubleClick
//  `set Read Write / Read Only for Secondary records according to privileges

// Created Method(s) : 
//ut_CheckMissingSeqScans
//  ` Method to check if there are sequences in the data file that are not in the ut_ScanSequences method
//  `Currently need to place a copy of the ut_ScanSequences in the clipboard , then run this method.
//  `It will place the missing seqs back in the clipboard so they can be pasted in ut_ScanSequences

// Modified Method(s) : 
//ut_ScanSequences
//  `Added missing sequences using ut_CheckMissingSeqScans
//  `added the button to print secondary SIAs


//**********`Modified by: Costas Manousakis-(Designer)-(5/27/14)
// Created Form(s) : 
//[NBIS Secondary];"print"

// Modified Forms : 
//Object Method: [Bridge MHD NBIS].Bridge Input.bPr2nd 

// Created Method(s) : 
//Method: SIA_PrintSecondary
//Description
//  ` print all secondary records listed. used in the Bridge Input form - secondary records page

// Created Method(s) : 
//ut_Google2ndary
//  `google a secondary record copied from ut_GoogleBIN

//SIA_Paste2NDLatLon
//Description
//  ` Copy the Lat and or Long values from the clipboard to the respective fields on
//  ` the  table [NBIS Secondar]. Designed to be run from a button on the input form.
//  ` copied from SIA_PasteLatLon

//**********`Modified by: Costas Manousakis-(Designer)-(5/30/14)

// Modified Form Methods : 
//[Dialogs];"InspectConfig"
//  `Added inspection category labesl in the INSP_SelType_atxt  array indicating whether inspection is Highway, rail, pedestrian, etc.

// Modified Object Methods : 
//[Dialogs];"InspectConfig".INSP_SelType_atxt
//  `Modified to account for the "labels" added in the INSP_SelType_atxt array.

//```
//```   **** End of Release 6.3.2 06/02/14
//```

//End Mods_2014_05