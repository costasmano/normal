//%attributes = {"invisible":true}
//Method: Mods_2014_03
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/04/14, 10:33:27
	// ----------------------------------------------------
	//Created : 
	Mods_2014_03
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(3/3/14)
// Modified Forms : 
//[Bridge MHD NBIS];"RailTransitSIA"
//  `Fixed sizes and styles of objects

//[dialogs];"Search Def Element"
//  `changed the list in the dropdowns for comaprision conditions - re-worded them and added the comparison symbols; 
//  `made dropdowns taller and wider and increased form size

// Created Method(s) : 
//SIA_RAILINPUT_FM
//  `Form method for new input form [Bridge MHD NBIS];RAIL_SIA_Input 

//**********`Modified by: Costas Manousakis-(Designer)-(3/4/14)
// Modified Method(s) : 
//P_MDC
//  `Removed the search for Legacy Owner and Other Owner

//ut_GoogleBIN
//  `for admins added try Bing.

//SIA_BridgeInpNavCTRL
//  `removed call to SIA_RRVariableUtil ("LOAD") - called in the form method

//SIA_RRVariableUtil
//  `modified the messages when cancel 


//**********`Modified by: Costas Manousakis-(Designer)-(3/6/14)
// Modified Method(s) : 
//LB_ProcessContracAssigns
//  `Removed columns assignment#, boston pm, preserv eng, Designer.; added Date to FAPO.

// Modified Table(s) : 
//[Preservation_Reviews]
//  `added field [Preservation_Reviews]ReceivedHardCopy_d

// Modified Forms : 
//[Preservation_Reviews];"PreservReviewInput"
//  `Changed label of Received to By Email, added field ReceivedHardCopy_d on page 3

// Created Method(s) : 
//SCPOA_OpenURL
//Method: SCPOA_OpenURL
//Description
//  ` Object method for the buttons that open URL for usgs, nws etc.
// Parameters
//  $1 : $URLText_txt
// $2 : $HelpMessage_txt

//Compiler_SCPOA
//Compiler method for POAs; moved declaraions from Compiler_methods, Compiler_variables, Compiler_arrays

//COMPILER_Utilities
//  `added ut_getURLfromText

//**********`Modified by: C Miller-(Designer)-(3/11/14)
// Modified Method(s) : 
//LOGIN_BMSPontisTransfer
//  `Launch in a separate process


//```
//```   **** End of Release 6.3.1 Version 3/12/2014
//```

//**********`Modified by: Costas Manousakis-(Designer)-(3/20/14)
// Modified Method(s) : 
//ut_MapListofBridges
//  `Updated the code

//**********`Modified by: Costas Manousakis-(Designer)-(3/21/14)
//Compiler_Bridge
//  `additional vars for bridgeranking
// Modified Method(s) : 
//BridgeRankingCalculation
//  `  `  `additional vars for bridgeranking

//**********`Modified by: Costas Manousakis-(Designer)-(3/25/14)
// Modified Method(s) : 
//QR_SearchElements
//  `if no inspections found return a blank string
//  `unload records at the end
//QR_Item26OnOff
//  `added optional parameter for Item 26

// Created Method(s) : 
//ut_Rank 
//  ` Do a ranking based on values
//  ` $ValuesArray_ptr must be sorted already
// Parameters
// $1 : $ValuesArray_ptr
// $2 : $RankArray_ptr
// $3 : SortOrder_txt (Optional - default <)

// Modified Method(s) : 
//QR_SearchElements
//  `added 4th optional parameter to specify the BIN

//End Mods_2014_03