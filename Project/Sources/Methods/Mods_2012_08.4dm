//%attributes = {"invisible":true}
//Method: Mods_2012_08
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/13/12, 16:10:49
	// ----------------------------------------------------
	//Created : 
	Mods_2012_08
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(8/13/12)
// Modified Form  : 
//[Status Report];"P_StatusReport_HI"
//  `Added "Pre MADOT" to the label, changed logo to MADOT per request of T. Broderick

// Modified Method(s) : 
//SCPOA_ScourInpButton_OM
//  `Adjust the hor window size to add 10, and add the controlmenubar(3) and controlmenubar(2)

//**********`Modified by: Costas Manousakis-(Designer)-(8/14/12)
// Modified Forms : 
//[ScourPOA];"Print1-A"
//  `Fixed SCPOA_SourceOther_L_P check box - was not the right variable

//**********`Modified by: Costas Manousakis-(Designer)-(8/21/12)
// Modified Forms : 
//[Bridge Design];"design print form"
//  `Reset the display formats for number of spans and skew angle.

// Modified Method(s) : 
//PRINT_QAFORM
//  `Save the current inspection record and load it before printing so that the team leader and member information on page 1 is correct

//Modified by: Charles Miller (8/23/12 13:21:50)
//ut_ReturnBackupInfo
//  `Adjust how errors are returned by comparing backup size to disk space
//  `Also returned text about this error as well as back up status when not = 0

//**********`Modified by: Costas Manousakis-(Designer)-(8/29/12)
// Modified Method(s) : 
//SCPOA_Variables
//  ` in GETUWINSPECTS make sure we leave [Inspections] in read write state.

//*********
//********* End of release 6.0.8
//*********

//End Mods_2012_08