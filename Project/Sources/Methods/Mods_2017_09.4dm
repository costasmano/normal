//%attributes = {"invisible":true}
//Method: Mods_2017_09
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/11/17, 12:01:08
	// ----------------------------------------------------
	//Created : 
	Mods_2017_09
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(9/8/17)

// Created Method(s) : 
//Method: INSP_Data2Inventory
//Description
// Copy data from the inspection record to the inventory record
// this only copies required NBI data - not mass specific items
// meant to be called at the time of completion of the inspection report
// Parameters
// $0 : $OK_b 

//Method: INSP_Data2InventoryCheck
//Description
// Compare inv field with source field and add to pointer arrays if not the same
// Parameters
// $1 : $InvField_ptr
// $2 : $SourceField_ptr
// $3 : $FieldsToChange_ptr - pointer to array of pointers
// $4 : $SourceFields_ptr - pointer to array of pointers
// $5 : $UseVerify_b - optional : use method G_Insp_VerifyItem when comparing

//**********`Modified by: Costas Manousakis-(Designer)-(9/15/17)
// Modified Method(s) : 
// NTI_InspCompleteCheck
//  `do not clear inspcompldate when incomplete; and mark the date only first time that insp is complete

// [Inspections];"Dive Template".DE Button Accept
//  `add the conditions to save insp data to SIA 

// [Inspections];"Dive Template".DE Button Accept
//  `add the conditions to save insp data to SIA 

//**********`Modified by: Costas Manousakis-(Designer)-(9/18/17)
// Created Method(s) : 
//Method: Mail_SendTINRevuNotif
//Description
// send email notifications for TIN inspections
// Parameters

//**********`Modified by: Costas Manousakis-(Designer)-(9/20/17)
// Modified Method(s) : 

// G_Insp_SaveInspection
//  `modifications to save insp data to SIA upon first completion.

// NTI_DoReviewInspection
//  `enabled the review actions
//  `Use method Mail_SendTINRevuNotif for emailing

//**********`Modified by: Costas Manousakis-(Designer)-(9/22/17)
// Modified Method(s) : 
// INSP_UWSaveInsp
//  `if DBIE or TMldr are zeroed out, just do a pushchange
// Startup
//  `remove call to ut_ResetIPToServer

//**********`Modified by: Costas Manousakis-(Designer)-(9/25/17)
// Modified Method(s) : 
// INSP_aDiveMaster_OM
//  `loglink is done in  INSP_UWSaveInsp method 

// INSP_aUOE_OM
//  `loglink is done in  INSP_UWSaveInsp method 

// Object Method: [Inspections];"Dive LowCl".bEditTeam
// Object Method: [Inspections];"StormDamageInspection".bEditTeam
// Object Method: [Inspections];"Dive Form".bEditTeam
// Object Method: [Inspections];"Underwater Special Member".bEditTeam
//  `no need to copy arrays

// INSP_UWInputForm_FM
//  `build TM and TL arrays depending on the users'  Company / Agency

// InitPers
//  `for UOE engineer drop down look only under division = 0449

//**********`Modified by: Costas Manousakis-(Designer)-(9/26/17)
// Modified Method(s) : 
// [TIN_Insp_Images];"Input".bLast
// [TIN_Insp_Images];"Input".bNext
// [TIN_Insp_Images];"Input".bPrevious
// [TIN_Insp_Images];"Input".bFirst
//  `added NTI_SaveImage on Clicked event

// INSP_Data2Inventory
//  `calculate the change stack for the bridge table to be the last one $lastChangeStack_L

//**********`Modified by: Costas Manousakis-(Designer)-(9/27/17)
// Modified Method(s) : 
// MacroUtils
//  `fixed code in ModComments and NewName to check the method name containing left bracket
//  //Added EndofRelease

// "ReLogRecords".RelogDo
//  `do not show alert for [FileIDRes] problems if NRC record is not requested
//  `also must create NRC if Log Deletion is checked
//  //Added progress bar with quit option

// ReLogRecords.ParentTableList_atxt
//  `don't mark UUID fields as unique or indexed
// ReLogRecords.TableList_atxt
//  `don't mark UUID fields as unique or indexed

//End Mods_2017_09