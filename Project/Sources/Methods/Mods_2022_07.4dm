//%attributes = {"invisible":true}
//Method: Mods_2022_07
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jul 11, 2022, 13:15:13
	Mods_2022_07
	// ----------------------------------------------------
	
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(2022-07-11)
// Modified Forms : 
//[Dialogs];"RecordInfo"
//named label object for modified by to modifiedLabel.
//in form method change the title according to property modifiedLabel of Form object

// G_InspInfo
//  `added object parameter to DIALOG command to change the label on the form

//**********`Modified by: Costas Manousakis-(Designer)-(2022-07-15)
// ACTLOG_RefIDReport
//  `added a header row to the csv report

//Method: XImportLogFiles
//Description
// import exported log files from a folder

// XImportLogFile
//  `update UUID fields before saving, just in case there is a duplicate from the export.

// Modified by: Chuck Miller-(Designer)-(7/19/22 12:51:55)
//Modified how passwords are changed in single user so that server password can be changed at the same time
//M_ChgPassword 
//compiler_ChangePassword
//ut_CheckPasswordRules
//"ChangePassword"//New form
//Method: FN_SetPassword

//End Mods_2022_07   