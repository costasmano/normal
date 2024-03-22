//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/06/11, 16:24:24
	// ----------------------------------------------------
	// Method: Method: Mods_2011_07
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_07
End if 

// Created Method(s) : 
//ut_Update6466fromText
//  ` Update items 63,64,65,66 in the [BridgeMHDNBISArchive] table from a text file

// Modified Method(s) : 
//SCPOA_Variables
//  `Added missing APPEND TO ARRAY(SCPOA_SectionPage_aL;10) for non-multiview viewers.


// **********  ` Modified by: costasmanousakis-(Designer)-(7/12/11 14:30:08)
// Modified form Method(s) : 
//[Dialogs];"GetInspExtraCmts"
//  `Removed the code on the Deactivate event. It was causing flashing of the window
//  `when the spellcheck was invoked.


//Modify how buttons get set so common code for all places
//[Inspections];"Culvert Combined"  `page 3
//  `Form method
//[Inspections];"RailRoutineInput"  `page 2
//  `Form method
//[Inspections];"Routine Combined"  `page 2
//  `Form method
//INSP_ResetButton 
//INSP_SetUpButtons




//Create code to allow for reseeting of last log in data and count after load of users and groups
//ut_SaveUserLogInInformation 
//ut_LoadUserLoginInformation 

//Change how date and time created are set
//ut_LoadUsersAndGroups 