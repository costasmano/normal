//%attributes = {"invisible":true}
//Method: Mods_2023_02
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 13, 2023, 18:12:53
	Mods_2023_02
	// ----------------------------------------------------
	
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(2023-02-23)
//Method: M_SearchCritFindings
//Description
// Search for critical findings (FHWA) over a given time period for the current list of bridges
// reduce the list of bridges to the ones with critical Findings.
// Parameters
// ----------------------------------------------------

// CreateRandomSetForDefElement
//  `modifications
//  `-Clean up code to remove parts that were using the "GOTO Record" methodology 
//  `create two steps when searching for elements :
//  ` 1 - run through above water inspections starting from the latest routine type, but consider any multiple
//  `     inspections types after the routine. Exclude only FRZ inspections.
//  ` 2 - run through underwater inspections starting from the latest routine type (DVE or DVL), and consider any multiple
//  `     inspections types after the routine. Create Set "DVELMTSFILTERED"

// [Dialogs];"Search Def Element"
//  `create empty sets ELMTSFILTERED and DVELMTSFILTERED on load - clear both on unload

//**********`Modified by: Costas Manousakis-(Designer)-(2023-02-24)
//Method: NextElmtUpdate
//Description
// retrieve next  updates for current element in elementssafety
// Parameters
// $0 : $ResultObject
//  // .Description
//  // .Elementcollection

//End Mods_2023_02   