//%attributes = {"invisible":true}
//Method: Mods_2020_09_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/02/20, 11:53:29
	// ----------------------------------------------------
	//Created : 
	Mods_2020_09_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(9/2/20)
// [ServerProcesses];"Output_LB"
//  `add Code in form method to make table read only on Load
//  `Changed hilite set of LB to Userset
// [ServerProcesses];"Output_LB".bAdd
//  `added unload record

// INV_PrintInvInsp
//  `initialization of vPicture1 was commented out? removed comment

// FilesToArray
//  `convert from using AP pack

//**********`Modified by: Costas Manousakis-(Designer)-(9/3/20)
// M_SetItem75
//  `change the message folder name to include the server IP and port number
// Mail_BridgeStatusRpt 
//  `change the message folder name to include the server IP and port number
// Server_SetItem75
//  `change the message folder name to include the server IP and port number
// SR_ProcessQuarterly
//  `change the message folder name to include the server IP and port number
// ut_SRVMonthlyReports
//  `change the message folder name to include the server IP and port number
// ut_UpdateArrayLoaders
//  `change the message folder name to include the server IP and port number
// WKHR_ComputeAvgs
//  `change the message folder name to include the server IP and port number

//**********`Modified by: Costas Manousakis-(Designer)-(9/4/20)
// SFA_VerifyMountPoint
//  `Fixed arguments when calling the mountscript - needed to add {3} in arg2 to match arg1

//**********`Modified by: Costas Manousakis-(Designer)-(9/17/20)
// [Dialogs];"BigAlert".BCopyToClipBtn
//  `put the plain text in the clipboard without style tags
// ut_ControlDBSycnh
//  `re-arrange SQL_Logout to make sure there is no case where we don't log out.

//**********`Modified by: Costas Manousakis-(Designer)-(9/18/20)
// "LSS_InspectionApproval".Accept btn1
//  `save any comments if they were entered in the review dialog. Call Reference #747
// LSS_SendAcceptRejectEmail
//  `Send comments that might have been entered in the review dialog upon approval. Call Reference #747


//```
//```    **** End of Release 7.3.0.h 18-Sep-2020
//```

//**********`Modified by: Costas Manousakis-(Designer)-(9/22/20)
// PRINT_Closed
//  `Added missing code to combine pdfs at the end - Call Reference #748

//**********`Modified by: Costas Manousakis-(Designer)-(9/23/20)
// ut_UpdateArrayLoaders
//  `retrieve the next run timestamp and log it in the messages file

//End Mods_2020_09_bug