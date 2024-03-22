//%attributes = {"invisible":true}
//Method: Mods_2020_01_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 01/14/20, 11:40:37
	// ----------------------------------------------------
	//Created : 
	Mods_2020_01_bug
End if 
//

// Form "Preferences"
//  `added EmailMethod object and obj method
// M_HandlePrefs
//  `added code for EmailMethod
// Mail_SendInspRevuNotif
//  `use the <>EmailMethod variable to choose how to send emails

//Modified by: CJ (1/14/20 11:45:03)
//ut_NewSaveMethod
//Move changed clone code for new data file changes in and modify to make sure arrays are used and new function call to finish clone for empty data file
//clone_CreateSQLLimits 
//Form method
//CloneTables
//SQL_CloneElementSafety 
//SQL_CloneInspectionRelated 
//SQL_CreateNewDB


//**********`Modified by: Costas Manousakis-(Designer)-(1/23/20)
// G_InspParagProt
// //Work for CallReference #692
// `Added testing code to save the 4DWrite area at various steps for debugging purposes. for CallReference #692
// `while adding CRs to split the inserted comments, don't apply stylesheet 1 because it causes 
// `the formatting in the split paragraph to be lost.  for CallReference #692

//Method: CleanFileName
// Replaces illegal characters in a filename with an underscore "_"
// MUST NOT Include the extension
// Parameters
// $0 : $Result_txt
// $1 : $FileName_txt

// f_TrimStr
// Fixed cases where one of the trim options (Lead or trail) are false. 
// the start pos or trim length were not set correctly.

//**********`Modified by: Costas Manousakis-(Designer)-(1/29/20)
// Modified Forms : 
// [Bridge Design];"Design Print Form"
//  `fixed width of label on district box

// [Bridge MHD NBIS];"SI & A Input"
//  `added object "RAILNotice" on page 9 in the "MBTAHWYLoads" view
// SIA_SecureInputForm
//  `lock MBTARating loads and show RailNotice when TRO or RRO bridge


//End Mods_2020_01_bug