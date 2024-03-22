//%attributes = {"invisible":true}
//Method: Mods_2015_11
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/02/15, 11:42:55
	// ----------------------------------------------------
	//Created : 
	Mods_2015_11
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(11/2/15)
// Modified Method(s) : 
//ut_testEmailSending
//  `Added option for timeout ; include some information in the bosy of the msg; display the message body before sending.


//Modified by: administrator (11/10/15 16:43:48)
// Add ability to approve or reject  LSS inspections
//"LSS_InspectionApproval" -New form
//[LSS_Inventory];"Input"
//  ` Method: Object Method: [LSS_Inventory].Input.Inspection_LB
//  ` Method: Object Method: [LSS_Inventory].Input.LSS_Add_L
//  ` Method: Object Method: [LSS_Inventory].Input.LSS_Approved_L
//FM_InventoryInput
//Method: Object Method: LSS_InspectionApproval.vCancel
//Method: Compiler_LSS

//Add new method of assigning Tunnel number
//Modified by: administrator (11/10/15 16:45:30)

//[NTI_TunnelInfo];"New_TIN"
//  `Method: Object Method: [NTI_TunnelInfo].New_TIN.NTI_Number_s
//  `Method: Object Method: [NTI_TunnelInfo].New_TIN.NTI_Number_s
//  `Method: Object Method: [NTI_TunnelInfo].New_TIN.NTI_VentID_atxt
//  `Method: Object Method: [NTI_TunnelInfo].New_TIN.NTI_Owner_atxt
//  `Method: Object Method: [NTI_TunnelInfo].New_TIN.NTI_TunnelID_atxt
//Method: Form Method: [NTI_TunnelInfo]Input
//Method: Compiler_NTI 
//Method: NTI_CheckForValidate
//Method: NTI_FillDropDowns
//Method: NTI_SetTunnelNumber


// Add ability to approve or reject  LSS inspections
//Modified by: administrator (11/12/15 16:57:01)
//[LSS_Inspection];"Inspection_Template"
//FM_InspectionInput 
//LSS_SendAcceptRejectEmail
//Method: Object Method: [LSS_Inventory].Input.LSS_Approved_L

//Make sure lss records are in correct read/write or read only state
//LSS_ModifyPhotos 
//  `Method: Object Method: [LSS_Inventory].Input.LSS_Approved_L
// Method: Object Method: [LSS_Inventory].Input.LSS_Edit_L



//**********`Modified by: Costas Manousakis-(Designer)-(11/12/15)
// Created Method(s) : 
//Method: ut_ClearSavedPassword
//Description
//  `Clear the saved password created when "Remember Password" is checked in login dialog
// Modified Forms : 
//[LSS_Inventory];"Input"
//  `increased size of  LSS_Inventory]LSS_AssetNo_txt field.

//**********`Modified by: Costas Manousakis-(Designer)-(11/13/15)
// Created Project Form(s) : 
//"EmailDialog"
//  ` created to display email parameters

// Modified Method(s) : 
//Mail_SendInspRevuNotif
//  `If the email was not sent ok, show a window using form EmailDialog with the contents so that they can be copied to an email client.

//Modified by: administrator (11/17/15 16:09:39)
//Continue working on [NTI_TunnelInfo] subsystem
//[NTI_TunnelInfo];"ListBoxOutput"
//[NTI_TunnelInfo];"New_TIN"
//  `Method: Object Method: [NTI_TunnelInfo].New_TIN.bValidate
//  `Method: Object Method: [LSS_Inventory].New_InventoryItem.LSS_Cities_atxt
//NTI_CheckForValidate 
//NTI_FillDropDowns 
//NTI_SetTunnelNumber
//NTI_CheckTownSelection 
//NTI_ControlNextPrevMovement 

//**********`Modified by: Costas Manousakis-(Designer)-(11/18/15)
// Modified Method(s) : 
//PON_LoadMigratorResults
//  `Added code to track time elapsed and create a log file.

// Created Method(s) : 
//Method: ut_openBrInspManual2015
//Description
//  ` open link to the Bridge Inspection manual

// Modified menu(s) : 
//Menu Bar#1/Tools
//  `added item to open bridge inspection manual
//  `added item to clear saved password
//  `added separator lines
//menu bar BrgListmenu/Tools
//  `added item to open bridge inspection manual
//  `added separator lines

// Created Method(s) : 
//Method: ut_runApplescript
//Description
//  ` execute an applescript
// Parameters
// $0 : Result_txt
// $1 : $script_file_path_txt

//Modified by: administrator (11/19/15 16:11:54)
//[NTI_TunnelInfo];"Input"
//  `Method: Object Method: [LSS_Inventory].Input.bDelete
//  `Method: Object Method: [NTI_TunnelInfo].Input.Button
//  `Method: Object Method: [NTI_TunnelInfo].Input.AvailableBins_LB
//  `Method: Object Method: [NTI_TunnelInfo].Input.SelectedBins_LB
//  `Method: Object Method: [NTI_TunnelInfo].Input.Button3
//  `Method: Object Method: [NTI_TunnelInfo].Input.Button5
//Compiler_NTI 
//NTI_CheckForValidate 
//FM_NTITunnelInput 
//NTI_AssignBINtoTunnelTIN 
//NTI_RemoveBINfromTunnelTIN 

//Fix compiler errors
//ut_runApplescript 

//Crate methjod as an example for creating doc for xml
//ut_CreateXMLfromtableExample

//**********`Modified by: Costas Manousakis-(Designer)-(11/20/15)
// Modified Method(s) : 
//QR_Item21 
//QR_Item22 
//QR_Item31 
//QR_Item41 
//QR_Item26 
//QR_Item43B
//QR_Item42A 
//QR_Item42B 
//QR_Item107 
//  `add optional param $1 - changed all params to text
//QR_Item43A 
//  `made vsItem43a to a local var - all params to text
//QR_TLineTown 
//QR_TLineBrNo
//  `change param $0 to text

//**********`Modified by: Costas Manousakis-(Designer)-(11/24/15)
// Modified Object Methods : 
//Object Method: [Activity Log].Output.bzSearchLay 
//Object Method: [Activity Log].Output.bzSearch 
//Object Method: [Activity Log].Output.bzSearch 
//Object Method: [Activity Log].Output.bzAll 
//Object Method: [Activity Log].Output.bzSub 
//Object Method: [Activity Log].Output.bzOmit 


//**********`Modified by: Costas Manousakis-(Designer)-(11/30/15)
//ut_ControlUserPrefs
//  `added pref EmailMethod only in INIT; added task "INIT" to set up arrays with prefnames and pointer to pref variables.

//Compiler_Preferences
//  `added new vars and arrays

//InitPrefs
//  `call ut_ControlUserPrefs("INIT") before ut_setPrefSMTPServer

// Modified Form Method(s) : 
//[Inspections];"RailRoutine Culvert"
//  `fix accessibility  items - wrong variables were being filled.


//End Mods_2015_11