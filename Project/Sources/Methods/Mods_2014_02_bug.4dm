//%attributes = {"invisible":true}
//Method: Mods_2014_02_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/14/14, 15:23:28
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(2/12/14)
// Modified Method(s) : 
//LB_ProcessElemSftyQuery1 
//  `Made  vars for ELEMSafetyQuery2 non enterable

// Modified Object Methods : 
//ReLogRecords.RelogDo
//  `fixed bugs with missing definition of key field numbers

//ReLogRecords.TableList_atxt
//  `clear records found var

//COMPILER_Utilities
//  `Added all vars /arrays for the RELOG dialog

// Modified Form Methods : 
//[zSpecialReports]Input
//  `added var ZSPRPT_NewRecord_b to keep track of new record

//**********`Modified by: Costas Manousakis-(Designer)-(2/19/14)
// Modified Forms : 
//[Dialogs]GetInspExtraCmts 
//  `resized the textlabel and allowed to grow horiz; added the  Blankmenu and enabled menu for copy - paste operations

// Modified Method(s) : 
//SIA_SecureInputForm
//  `Allow agencies to enter UW inspection values - use new group UWInspectionItemEdit


// Modified Method(s) : 
//ut_SaveMethod
//  `added check if vars are defined

//**********`Modified by: Costas Manousakis-(Designer)-(2/20/14)
// Modified Method(s) : 
//G_Insp_SetPersUI 
//  `added calls to set the tunnel and proj mgr for Tunnel inspections

//```
//```   **** End of Release 6.3.0.d 02/20/2014
//```

//**********`Modified by: Costas Manousakis-(Designer)-(2/24/14)
// Modified Forms : 
//[RatingMember];"RatMemberIn"
//  `Removed  the "Default" value from the Rating Date. - it was resetting the date to the current date for an unsaved RtgReport record.

//End Mods_2014_02_bug