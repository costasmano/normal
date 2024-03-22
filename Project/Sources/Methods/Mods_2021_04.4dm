//%attributes = {"invisible":true}
//Method: Mods_2021_04
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/02/21, 14:08:19
	// ----------------------------------------------------
	//Created : 
	Mods_2021_04
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(4/2/21)
// INSP_ReviewAction
//  `Added a check for duplicate inspection reports.

// ut_OpenDocument
//  `use folder separator to determine platform

//Method: XAnalyzeActLogFile
//Description
// Analyze an Activity log file. Create report with RefIDs found in file, 
// number of owner records and if RefID found in local db with how manu Owners

//Change from auto to selecting input on sub forms by double clicking 
//Modified by: CJ (4/8/21 15:51:14)
//[Standard Photos];"LBStdPhotos"
//[Inspections];"Closed Bridge"
//[ElementsSafety];"ElementSafetyUW_SUB"
//[ElementsSafety];"ElementSafetyTunnelS_SUB"
//[ElementsSafety];"ElementSafetyTunnel_SUB"
//[ElementsSafety];"ElementSafetyDive_SUB"
//[ElementsSafety];"ElementSafetyCM_SUB"
//[ElementsSafety];"ElementSafety_SUB"
//[Cond Units];"Cond_Units_SUB"
//CTRL_SubFormDoubleClick 
//Compiler_Utilities

// INIT_UI_GV
//Reset stack size to use app version default
// NTI_UpdateDBonStartup
//Make sure no display when on server
// ut_SetUpBridgeInfoLinkTable
//Reset stack size to use app version default

//**********`Modified by: Costas Manousakis-(Designer)-(4/12/21)
// [Dialogs];"MyConfirm"
//  `made object vtMessage as multi-style text
//Method: [Inspections];"QCQAPrint"
//Description
//form method for new form QCQAPRINT.
// to be printed as pdf when generating the pdf for the inspection after approvals


//Added code to allow for selected of previously saved Users and Group File
//Modified by: CJ (4/13/21 15:57:01)
//Form "UserandGroupFiles"
//ut_SelectandLoadUGFile 
//ut_ReturnUGFilesFromServer
//ut_LoadUGOnServer
//Compiler_Utilities

//Added code to automatically load newest U and G file
//On Server Startup 

//04/15/21
//Trigger Inspections
//ut_ResetCreateApprovedPDF_d
//INSP_CreateApprovedPDFS

//**********`Modified by: Costas Manousakis-(Designer)-(4/20/21)
// [Standard Photos];"LBStdPhotos".PHotos_LB -copied to v17 4/20/21
//  `removed on Close detail event- moved CTRL_SubFormDoubleClick to on double clicked - removed InDoubleClick:=true

// INSP_LoadForApprInspections
//  `use system parameter INSPENABLEPDFSTORE = "TRUE" to turn this feature on or off

//**********`Modified by: Costas Manousakis-(Designer)-(4/21/21)
// PERS_ConvertAllStatsToObj
//  `force Json parse to return Is object
// PERS_UpdateLoginStats
//  `force Json parse to return Is object
// INSP_QCSaveApprovalInfo
//  `force Json parse to return Is object
// ut_GoogleBIN
//  `force Json parse to return Is object
//  `force ob get to return correct type
// XAnalyzeActLogFile
//  `force Json parse to return Is object
// XImportLogFile
//  `force Json parse to return Is object
// [Inspections];"QCQAPrint"
//  `force Json parse to return Is object
// INSP_SelectInvPhotos
//  `force ob get to return Is long
// INSP_GetConsProjMgr
//  `force ob get to return Is text
// Mail_SendInspRevuNotif
//  `force ob get to return correct type
// PON_CopyElements
//  `force ob get to return correct type
// PON_VerifyElementForExport
//  `force ob get to return correct type
// RES_OpenResourceFile
//  `force ob get to return correct type
// "SelectInvPhoto".ListBox1
//  `force ob get to return correct type
// "SelectInvPhoto".v_112_003_ad   
//  `force ob get to return correct type
// "SelectInvPhoto"
//  `force ob get to return correct type

//```
//```    **** End of Release 7.3.1 21-Apr-2021
//```

//**********`Modified by: Costas Manousakis-(Designer)-(4/23/21)
// ut_MountVolume
//  `added set Env Variable statements
//  `For mac , after LEP, do a Repeat loop to check if the volume was mounted.
//  `The open smb command is asynchronous and it will wait for the user to enter username and password

// ut_isSharedFolderMounted
//  `on windows if we use ut_MountVolume, return the drive letter that was selected in $3

// [Standard Photos];"Standard Photos"
//  `made sure navigation buttons were named bFirst, bPervious, bNext, bLast - cleared variables for them - no action

// FM_StandardPhotosInput
//  `added call to LSS_SetPrevNextButtons

// INSP_ImageNavigation_OM
//  `Enable the navigation from this method. Automatic action was removed from the navigation buttons on the form

// [ElementsSafety];"SafetyElmtTemplate"
//  `made sure navigation buttons are named bFirst, bPrevious, bNext, bLast.  Removed variables. Set automatic action to None

// INSP_ElmSft_Input_FM
//  `added call to LSS_SetPrevNextButtons - nav buttons on template are with no standard action

// INSP_ElementNavigation_OM
//  `Enable the navigation from this method. Also save record if modified.
//  `Automatic action was removed from the navigation buttons on the form


//**********`Modified by: Costas Manousakis-(Designer)-(4/23/21)
// all [Inspections] input forms with ElementsSafety subforms 
//  `Increased horizontal size of ElementsSafety subform object by 15 to better show the vert scroll bar

// INSP_ReviewAction
//  `added inspection type to the check for dupl insp reports

//```
//```    **** End of Release 7.3.1.b 23-Apr-2021
//```

//**********`Modified by: Costas Manousakis-(Designer)-(4/26/21)
// ut_DelayDBSynch
//  `Removed all send to clipboard commands
// M_Exec Transfer
//  `added option for other users to do delay transfers if Cmd or Shift key are pressed.


//End Mods_2021_04