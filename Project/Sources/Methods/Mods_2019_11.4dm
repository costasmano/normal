//%attributes = {"invisible":true}
//Method: Mods_2019_11
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/29/19, 12:28:07
	// ----------------------------------------------------
	//Created : 
	Mods_2019_11
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(11/6/19)

// ADDED TABLES / FIELDS
// ----------------------------
// 37_50 = [RAILBridgeInfo]Rating_ES44AC
// 37_51 = [RAILBridgeInfo]Rating_ES44AC_Max
// 37_52 = [RAILBridgeInfo]Rating_ES44AC_fatigue_r
// 65_40 = [RatingReports]ScannedStored
// 190_1 = [RatingVehicleTypes]VehicleID, Indexed
// 190_2 = [RatingVehicleTypes]VehicleName_s, Indexed
// 190_3 = [RatingVehicleTypes]PostingVehicle_b
// 190_4 = [RatingVehicleTypes]RatingVehicleTypes_UUIDKey_s, Indexed
// 190_5 = [RatingVehicleTypes]InvRating
// 190_6 = [RatingVehicleTypes]OperRating
// 190_7 = [RatingVehicleTypes]Legacy
// 190_8 = [RatingVehicleTypes]Sequence
// 190_9 = [RatingVehicleTypes]LegacyInvFieldNo_L
// 190_10 = [RatingVehicleTypes]LegacyOprFieldNo_L
// 191_1 = [RatingReportVehicles]RatingVehicleID, Indexed
// 191_2 = [RatingReportVehicles]RatingID, Indexed, Relation, n->1: [RatingReports]RatingID 
// 191_3 = [RatingReportVehicles]InvRating
// 191_4 = [RatingReportVehicles]OperRating
// 191_5 = [RatingReportVehicles]Posting
// 191_6 = [RatingReportVehicles]RatingReportVehicles_UUIDKey_s, Indexed
// 191_7 = [RatingReportVehicles]VehicleID, Indexed

// created default output / input forms for [RatingVehicleTypes] , [RatingReportVehicles]

//Method: RatRep_LoadVehFormVariables
//Description
// load the vehicle variables of the input form

//Method: RatRep_SaveVehRecords
//Description
// Save the records for the vehicles
// Parameters

//Method: RatRep_VehiclesLB_OM
//Description
// object method for the rating vehicles Listbox in the the rating report input form
// Parameters

// SIA_ResetWidths
//  `dont't make listbox wider than the window width - leave 5 pixel right margin  
//  `and keep LB width to not exceed the calculated width

// [RatingReports];"RatReportsIn"
//  `New page 1 for SU and EV vehicles and code in on load and validate to load and save rating vehicles

//**********`Modified by: Costas Manousakis-(Designer)-(11/8/19)
// SIA_BridgeInput_FM
//  `account for form resizing for page 4
// SIA_OnDisplayDetail
//  `changes in the Rating reports tab for SU and EV vehicles - use Resources Xbox.png and blankbox.png 

// [RatingReports];"RatReportsIn".Variable8
//  `make sure to go to validate part

//**********`Modified by: Costas Manousakis-(Designer)-(11/19/19)
// ut_SetMessageDir
//  `always create folders under the users documents folder - 
//  `also no need to create any folders here because all are created in ut_ReturnUserDocFolder
// PON_CombineRecent
//  `4th optional parameter to show progress or not - default = true

//**********`Modified by: Costas Manousakis-(Designer)-(11/26/19)
// SIA_SetUpListBoxes
//  `additions in Rating reports

//**********`Modified by: Costas Manousakis-(Designer)-(11/29/19)
// [Bridge MHD NBIS];"Bridge Input"
//  `Changes in page 4 Ratings for SU and EV vehicles - changed LB and removed Inv/Oper text labels.
//  `enabled on Resize event on the form

//End Mods_2019_11