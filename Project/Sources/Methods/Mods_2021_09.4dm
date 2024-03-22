//%attributes = {"invisible":true}
//Method: Mods_2021_09
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/20/21, 15:27:58
	// ----------------------------------------------------
	//Created : 
	Mods_2021_09
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(9/20/21)

// POPUPMENUC   **** copied to v15dev
//  `added optional 4th param for form event 
// INSP_ElmSft_Input_FM   **** copied to v15dev
//    //execute on load events for objects on form to update pulldown arrays
// G_ElmtDefPopup   **** copied to v15dev
//  `added optional parameter $1 for $formEvent
// [ElementsSafety];"SafetyElmtTemplate".ElmtSelector
//  `fix  for 'flashing' of write areas. just use goto sel record and execute the on Load of the form method and WP area method
// [ElementsSafety];"ElementSafetyDive_SUB"
//  `set double-click on row on the LB to "Do Nothing"
// INSP_StdPhotoType_OM
//  `Added optional parameter formevent
// FM_StandardPhotosInput
//  `call INSP_StdPhotoType_OM with On Load parameter
// INSP_ImageNavigation_OM
//  `instead of loading a new form (dialog or modify record) , run the on Load code of the form method

//**********`Modified by: Costas Manousakis-(Designer)-(9/21/21)
// NTI_NavigateInput_OM
//  `When moving to other record don't call dialog/modify record, call the form method and WP area method with On Load parameter
// PON_NavigateInput_OM
//  `instead of loading a new form (dialog or modify record) , run the on Load code of the form method

//**********`Modified by: Costas Manousakis-(Designer)-(2021-09-23)

// "PONHELP"
//  `unchecked use embedded webkit on web area
// PON_PONHELP_FM
//  //Fix for use in OSX 10.14
//  `onload event just initialize webarea, then call on timer, and there call the On Outside call event


//**********`Modified by: Costas Manousakis-(Designer)-(2021-09-24)
// NTI_PONHELP_FM
//  //Fix for use in OSX 10.14
//  `onload event just initialize webarea, then call on timer, and there call the On Outside call event
//  `don't create temp file, instead use WA SET PAGE CONTENT

//**********`Modified by: Costas Manousakis-(Designer)-(2021-09-27)
// CNV_ImportPictures    **** Copied from v17
//  `remove hmfree
// ut_CNV_ExportPictures    **** Copied from v17
//  `replaced hmfree commands with GET PICTURE FORMATS
// dev_convertPicLibToJPEG    **** Copied from v17
//  `remove hmfree commands -use GET PICTURE FORMATS
// GetPictureTypes    **** Copied from v17
//  `use GET PICTURE FORMATS instead of hmfree coommands
// Temp_FixStdPhotoSizes    **** Copied from v17
//  `replaced hmfree commands with GET PICTURE FORMATS
// ut_CNV_CheckPictures    **** Copied from v17
//  `replaced hmfree commands with GET PICTURE FORMATS
// ut_CNV_ReportAllDeprecatedPics    **** Copied from v17
//  `replaced hmfree commands with GET PICTURE FORMATS
// PON_ELEMINP_FM    **** Copied from v17
//  `add form event to call to POPUPMENUC 
// NTI_ELEMINP_TIN_FM    **** Copied from v17
//  `add form event to call to POPUPMENUC 
// Form [Parameters];"Output_LB"    **** Copied from v17
//  `renamed form to Output_LB to change it from output form to listbox; added a listbox

//End Mods_2021_09