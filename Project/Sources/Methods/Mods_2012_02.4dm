//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/07/12, 12:46:29
//----------------------------------------------------
//Method: Mods_2012_02
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r001
	//Modified by: Charles Miller (2/7/12 12:46:30)
	
End if 
//add method to open prefernces
//ut_OpenPreferences

//SaveActivityLogRecord_b to true at start
//ut_SQLCreateNewRecord

//Fix a variety of forms where format problems caused display issues

//r001`Exclude Administrator and Designer
//ut_LoadUserLoginInformation 
//ut_SaveUserLogInInformation 

//Fix for leaving the bridge record unloaded.
//INSP_InspData2SIA

//Add time out code to external server
//ut_SetTimeOuts
//On StartUp
//On Server Startup

//Modified by: Charles Miller (2/9/12 14:39:06)
//r002 `Fix bug where sql update with a 0 size picture fails
//ut_SQLTellServerGrp_2 

//r002   `Fix bug where resolve pointer not retuning corect data
//Modified by: Charles Miller (2/9/12 14:43:44)
//f_Var_to_Series 
//PopulatePrintFormField 
//WKHR_LoadVariables_2 
//WKHR_StoreVariables 
//WKHR_StoreVariables_2 
//WKHR_ZeroAll 
//INSP_FillElementInfo 
//WKHR_StoreOrigEngEst 
//INSP_FillPreElementInfo 
//ut_ZeroByPointer
//WKHR_LoadItemHRs

// **********  ` Modified by: Costas Manousakis-(Designer)-(2/10/12 )
//Method: M_QuickReport
//  `changed auto relations before the QR to true;true from true;false
//G_SetInspFont 
//  `Made sure the vInspFontName and vInspFontSize are initialized
// Method: WRUTIL_Function
//  `Added code for the Plus minus sign;  Use a system parameter CHAR_REPLACED to get the 
//  `ascii replacement codes

// **********  ` Modified by: Costas Manousakis-(Designer)-(2/12/12 )
// Modified Object Methods : 
// [Standard Photos].Standard Photos.
//  `Add the on After Edit event
//fGetFormEvent
//  `added some new form events
//BMSExternal_Transfer 
//  `Don't spawn a process for ut_ControlDBSycnh; need to  capture end time at the ut_SetNextRunTimeStamp
//Method: temp_buildChar_replace
//  ` build the string to replace upper ascii characters ; save in parameter CHAR_REPLACED
//ut_buildChar_replace
//  ` build the string to replace upper ascii characters ; save in parameter CHAR_REPLACED

// Modified Forms : 
//[inspections].FrzThawPg1
//  `Fixed format of sTown variable


// **********  ` Modified by: Costas Manousakis-(Designer)-(2/13/12 )
// Method: P_INV_Review 
//  `Use similar logic to find the pending inv inspections as in the regular inspection review
// Method: Form Method: [InventoryPhotoInsp];"ReviewDialog"
//  `Use the array ◊INSP_MyDistricts_atxt to find if the person is a reviewer 
//Project Method : Print_RTN_Cmts
//  `Fixed missing Item 62 and GENERAL for RRR type inspections
//General Method G_AddHeader
//  `Added the GENeral case for RRR inspections

//r003
//Modified by: Charles Miller (2/14/12 13:10:13)
//Modify launch of user mode to be in its own process
//ut_LaunchUserMode
//ut_FindProcess 
//ut_DisplayUserMode 

//Modify user mode to that no entry on output form is allowed

//Remove the parameter in new process as it is an interprocess variable anyway
//PRJ_StartOrResumeProjSelection


//Add function call to get backup info
//ut_GetBackupInfo 
//ut_ReturnBackupInfo
//ut_GetServerBackUpData
//ut_ReturnExternalBackUpData

//r003`Make adjustment so long running methods to get MMARS amounts only run if time is after 8:00 PM or before 6:00 AM
//ut_PRJCtrlRetrieveProjectData
//ut_PRJCntrlRetrieveOfAmounts

//Fix bug and bring up alerts re who was skipped or not found
//ut_LoadUserLoginInformation


// **********  ` Modified by: Costas Manousakis-(Designer)-(2/17/12 15:35:32)
// Modified Method(s) : 
//GetDBIEccInfo
//  `  `Changed all string variables to text variables
// Method: INSP_InspData2SIA
//  `Fix for leaving the bridge record unloaded.

//Modified by: Charles Miller (2/21/12 16:25:01)
// ut_SQLTellServerField
//r003 `Fix bug to make sure 0 picture size is never sent over

// **********  ` Modified by: Costas Manousakis-(Designer)-(2/22/12 10:28:25)
// Modified Form: 
//[Bridge MHD NBIS]SI & A (Insp) 
//  `Fixed wrong field displayed for Accessibility Other

// Created Method(s) : 
//Server_QuitServer
//  ` Method to quit the server.  Meant to be run as part of batch job
//ut_getFormVariables

//Modified by: Charles Miller (2/23/12 10:04:06)
//Modified [Activity Log] transfers so that when an error occurs an alert displays
//ut_ControlDBSycnh
//ut_SQLDownloadNewRecords 

// **********  ` Modified by: Charles Miller-(Designer)-(2/23/12 15:35:32)
// Created Method(s) : 
//SIA_OnDisplayDetail
//SIA_ControlDoubleClick
//SIA_SetUpListBoxes
//SIA_GoToPage
//ut_ControlLBSetUp
//SIA_ResetWidths

// Modified Forms : 
//[Bridge MHD NBIS];"Bridge Input"
//  `Added listboxes for ConsultantInspections, ConsultantRatings, RatingReports, Secondary, Bridge Design 
//with object methods
// Modified Object Methods : 
//[Bridge MHD NBIS].Bridge Input.ZZ9 `
//  `show hide the stuff for listboxes

// **********  ` Modified by: Costas Manousakis-(Designer)-(2/25/12 )
// Modified Method(s) : 
//G_InspParagProt
//  `Fix code so that the second paragraph cut in half does not loose all formatting when the Apply stylesheet is done
//  `Also so that the remaining text does not get new bullet or a first line indent.

// **********  ` Modified by: Costas Manousakis-(Designer)-(2/26/12 )
// Created Method(s) : 
//ut_verifyVars
//  ` Verify existance of variables in POA forms
//SCPOA_FormTester

// **********  ` Modified by: Charles Miller-(Designer)-(2/28/12 )
//SIA_BridgeInpNavCTRL

// Modified Object Methods : 
//[Bridge MHD NBIS].BridgeTemplate.ZZ9
//  ` go to page 1 if not on page 1, cancel if on page 1

// **********  ` Modified by: Costas Manousakis-(Designer)-(2/29/12 )
// Modified Method(s) : 
//WRUTIL_Function
//  `Modified coding so that ClenChars can do replacements using embeded WR commands in the CHAR_REPLACED
//  `parameter. Allows to enter superscript, subscript, underlines etc for better representation of special characters 

// Created Method(s) : 
//SCPOA_AddtlVars
//SCPOA_InstCountMsrChkBoxes
//  ` Make sure Install countermeasure checkbox is on 
//SCPOA_Print_A
// `copied from SCPOA_Print
//SCPOA_InpFormMethod_A
//  `copied from SCPOA_InpFormMethod
//  `excluded call to SCPOA_Variables ("SETVERSION")

//SCPOA_Variables
//SCPOA_PostFloodChecks
//SCPOA_PrintFormsA_FM
//  `Changes for the new version of POA
//SCPOA_PrintPG1_FM
//  `add SCPOA_FillFormPicButtons and new form -A

//SCPOA_ListPOAs
//SCPOA_ScourInpButton_OM
//  `New input form "Input-A"
//SCPOA_PhotoListBox_OM
//  `increased the number of pictures to 5 for the new FVC
// Created Form(s) : 
//[ScourPOA]FieldVerificationCardpg1
//[ScourPOA]FieldVerificationCardpg2
//[ScourPOA]Summary-A
//[ScourPOA];"Print1-A"
//[ScourPOA];"Print2-A"
//[ScourPOA];"Print3-A"
//[ScourPOA];"Print4-A"
//[ScourPOA];"Print5-A"
//[ScourPOA];"Print6-A"

//INSP_AddElmtCat2HL
//  `check if bridge is RRO or inspection type is RR@

//End Mods_2012_02