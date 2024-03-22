//%attributes = {"invisible":true}
//Method: Mods_2020_03_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/02/20, 14:25:22
	// ----------------------------------------------------
	//Created : 
	Mods_2020_03_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(3/2/20)
//Method: Center_Window_2
//Description
//opem a window centered on the frontmost window
// Parameters
// $1 : $width_L
// $2 : $Ht_l
// $3 : $windowtype_L
// $4 : $winTitle_txt
// $5 : $closeBoxMethod_txt

//Method: ut_GetSysParamAttribute
//Description
// Get an attribute from a system parameter stored as an object (Json)
// Parameters
// $0 : $Attibute_txt
// $1 : $ParameterName_txt
// $2 : $Attribute_txt
// $3 : $DefaultAttr_txt (optional)

// M_SearchbyContractNo
//  `set window type to Movable dialog box - use new method Center_Window_2 to center on current window
// SRC_SearchByBridge
//  `use new method Center_Window_2 to center on top of current window

//**********`Modified by: Costas Manousakis-(Designer)-(3/5/20)
//Method: Temp_LogLinkPonElem
//Description
// create a loglnk act log entry for the selected Pon_elem_insp record, will 
// create LNK records for both parentID and grandparentID
// to be run as a formula from user mode and only from Boston Server because
// vsForward is NOT calculated - Method shared by component and host 

//**********`Modified by: Costas-(Designer)-(3/10/20)
// [Dialogs];"Search Bridge".bFind
//  `enabled using Item8 strings in the clipboard search - will check if strlen is 15 then extract the BIN and use that.

//**********`Modified by: CJM-(Designer)-(3/12/20)
//Method: FN_ReturnRecordCount

//**********`Modified by: Costas-(Designer)-(3/12/20)
// M_SetItem75
//  `removed old UpdateProgress call

//**********`Modified by: Costas-(Designer)-(3/17/20)
// M_WRT_CsltInsp_ReqFee
//  `added more checks in the list of cons inspections, 
//  //there must be records listed 
//  //Contract and assignment must be the same
//  //BIN records must be all either NBI or Non-NBI
//  //contract number must exist in the [contracts] table
//  //start use of system JSON parameter "CSINSP_LetterInfo" to get variables depending on if the list of inspections
//  //is for NBI bridges or non-nbi  

//**********`Modified by: Costas-(Designer)-(3/23/20)
// LSS_GetPendingInsp
//  `added group LSS_MassDOTAdmin for overall review of inspections 

//**********`Modified by: Costas-(Designer)-(3/25/20)
//Method: RatRep_LoadSU_EV_data
//Description
// get data from copy buffer to load into SU EV vehicle records
// will update the latest rating report record with that info and create act log entries.
// also update the notes in the rating report to indicate the update.
// example data (first set of values is inventory, second set is operating
//B_Dept | BIN | Date | SU4 | SU5 | SU6 | SU7 | EV2 | EV3 | SU4 | SU5 | SU6 | SU7 | EV2 | EV3
//A02001 | 28R | 3/13/20 | 11.3 | 11.7 | 11.8 | 12.1 | - | - | 32.4 | 33.5 | 33.7 | 34.7 | 32.3 | 32.6
//A13027 | 0FP | 3/16/20 | 16.1 | 17.7 | 19.8 | 22.1 | - | - | 27.2 | 29.9 | 33.5 | 37.4 | 26.9 | 27.7

//End Mods_2020_03_bug