//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/14/05, 12:53:20
	// ----------------------------------------------------
	// Method: Mods_2005_CM17
	// Description
	// All changes to add a Search method to search BINs based on
	//Pontis Element state condition.
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

// Modified by: costasmanousakis-(Designer)-(9/14/05 12:53:15)
//Created methods :
//M_SearchPontisElmts
//  `Main Method called from a menu
//M_PontisElementRpt 
//  `Report printing method
//CreateRandomSetForPontisElmt
//  `Method to do the actual search.
//G_PontisElmtQuery
//  `Perform the search on selected Pontis Elements
//SRCP_LoadElmCat 
//  `Method to load the pulldown for element categories
//SRCP_LoadElmArrays 
//  `Method to load the element array
//SRC_ResetForm_Pontis
//  `Method that resets the search dialog
//Created Forms:
//[Dialogs];"SearchPontisElmts"
//  `Dialog to specify the search criteria.
//[Cond Units];"CondUnitsPrt3"
//  `Print form for the report

//Modified Menu
//MenuBar 2 : Records
//  `Added menu Option "Search by Pontis Elements" which uses method M_SearchPontisElmts

// Modified Methods : 
//LOAD_aElem 
//LongName 
//  `Modified to account for new descriptions in the [BMS Categories]General Cat field.
//  `Added a general name inside [] which must be removed by Load_aElem and LongName.

// Modified Methods : 
//CreateRandomSetForDefElement 
//  `Fixed Query to Query Selection. Cleaned up if(False) coding.

// Modified Forms : 
//[BMS Categories];"Category Input"
//[Dialogs];"TypInputTemplate2"
//  `Adjusted Appearance and sizing options.

// Modified by: costasmanousakis-(Designer)-(10/6/2005 14:26:10)
// Modified Methods : 
//CreateRandomSet
//  `Adjusted code to strip " " and "_" from BDEPT; Do not search if nothing was entered;
//  `Go back to the criteria that was used (Bdept, BIn or Brkey); Display results.

// Modified Forms : 
//[Dialogs];"Search Bridge"
//  `Added variable to show search results.

// Modified Form Methods : 
//[Dialogs];"Search Bridge"
//  `Declare and initialize search results variable.

// Modified Methods : 
//Duplicate_Inspection 
//  `Save ID of BMS inspection from [Combined inspections] record to get the -1.

// Modified by: costasmanousakis-(Designer)-(10/11/2005 16:03:24)
// Modified Methods : 
//COND_UNIT_AFTER 
//Check_DupCU
//  `Moved Alert for Duplicate CU found from Check_DupCU to COND_UNIT_AFTER

// Modified by: costasmanousakis-(Designer)-(10/12/2005 13:55:08)
// Created Methods : 
//Check_CUdata 
//  `Copied and adjusted to return error text from code in ut_CheckForPontisErrors.
//  `Added check for Dupl CUs using method Check_DupCU

// Modified Methods :
//ut_CheckForPontisErrors
//  `Use new method Check_CUdata. Launch error file at end of method.
//G_CheckCondUnits 
//  `Use new method Check_CUdata.
//G_CheckCulvertInsp
//G_CheckRoutineInsp
//  `Adjust handling of return error text from method G_CheckCondUnits to avoid long text.
//  `Added requirement to have Pontis units.
//  `Clear local Text vars at the end.
//M_WRT_CsltInsp_Review
//  `Added check to make sure there is only one district in the list.

// Modified by: costasmanousakis-(Designer)-(10/13/2005 08:35:49)
// Modified Forms : 
//[Personnel];"Inspectors Out"
//  `Adjusted size and location of buttons.
//[Status Report];"I_StatusReport"
//[Status Report];"O_StatusReport"
//[Out of Freq];"I_OutofFreq"
//[Out of Freq];"O_OutofFreq"
//  `Changed forms to have MacOSX appearance and buttons

// Modified by: costasmanousakis-(Designer)-(10/17/2005 13:52:56)
// Modified Methods : 
//Server_GenCondRep 
//  `Save export files to an Exports folder under the Structure file location.

// Modified by: costasmanousakis-(Designer)-(10/20/2005 11:34:03)
// Modified Form Object Method : 
//[Standard Photos];"Standard Photos".ZZ5 - delete button
//  `Query the whole inspections table instead of Query Selection - Selection is cleared after a DELETE RECORD

// Modified Methods : 
//G_SIA2Inspection 
//  `Added initializing to field [Inspections]Item61_i.