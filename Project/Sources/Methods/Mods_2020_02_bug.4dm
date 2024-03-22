//%attributes = {"invisible":true}
//Method: Mods_2020_02_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 02/18/20, 14:24:35
	// ----------------------------------------------------
	//Created : 
	Mods_2020_02_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(2/13/20)
// CM_MailInvoiceNotice
//  `use the <>EmailMethod variable to choose how to send emails
// CM_MailInvoiceNotice_2
//  `use the <>EmailMethod variable to choose how to send emails
// LSS_SendAcceptRejectEmail
//  `use the <>EmailMethod variable to choose how to send emails
// Mail_SendTINRevuNotif
//  `use the <>EmailMethod variable to choose how to send emails
// DEV_ConvertButtonCmd
//  `Improve regex pattern to match start and end of string 
// DEV_Convert_o_c_Declarations
//  `Fixed search patterns to handle begin and end of string

//**********`Modified by: Costas Manousakis-(Designer)-(2/19/20)
//Method: Form_GetObjDims
//Description
// Get the dimenstions of an object on a form. meant to be called outside of form execution.
// Can be a table or project (no table pointer) form. Can pass a pointer to a form variable or name of an object
// Parameters
// $1 : $InfoObject_o
// Input Attributes : "TablePointer", "FormName", "VarName", "VarPointer"
// Return Attributes : "Name","Width", "Height", "Left", "Top", "Right","Bottom"

// LSS_CountandPrintDamagePages
//  `adjustments made to compensate for windows display scaling when generating a WR preview picture CallReference #695
// LSS_PrintInspection
//  `adjustments made to compensate for windows display scaling when generating a WR preview picture CallReference #695

//**********`Modified by: Costas Manousakis-(Designer)-(2/25/20)

// Created Form(s) : 
//Form [Bridge MHD NBIS];"RemovedBridge"
//Description
// Dialog displayed when bridge is changed to REM in the ID input form

//Form Method [Bridge MHD NBIS];"ID Input"
//  `When changing category to REM change Item7 and 6A CallReference #685

//**********`Modified by: Costas Manousakis-(Designer)-(2/26/20)
// QR_ConsInspElecSubm
//  `changed sequence of search in [inspections] to improve speed - leave the agency search last.
//  `CallReference $701

// [Contracts];"Contracts Out"
//  `made all fields/vars in the detail section not-transparent so that the selected rows can be highlited
//  ` also moved them vertically and adjusted widths  - CallReference #702

//End Mods_2020_02_bug