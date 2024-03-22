//%attributes = {"invisible":true}
//Method: Mods_2021_12_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-12-01T00:00:00, 17:38:51
	// ----------------------------------------------------
	//Created : 
	Mods_2021_12_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-01)

// G_GetServerTCP
//  `changed stack size to 0 - method was crashing on server.

//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-02T00:00:00)
// M_ChgPassword         ***** Copied from v15bug        ***** Copied from v15dev
//  `After editing access, prompt to save the users and groups on server when on client
// ADDUSER_Utils         ***** Copied from v15bug        ***** Copied from v15dev
//  `After closing dialog, prompt to save the users and groups on server when on client


//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-07)
// SFA_GetAvailRatingRpts
//  `changed Open URL to use "file://" instead of "file:////" - fix problem opening on windows.

//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-08)
//Method: DEV_ConvertObjectSetColor        ***** Copied from v15dev
//Description
// convert Object set color to Object set rgb colors
// Parameters
// $0 : $NewMethod_b (method has been changed)
// $1 : $MethodText_ptr

//****** Release to PROD/QA  


//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-09)
// Duplicate_Inspectionv        ***** Copied from v15dev
//  `Copy/Merge NBEs only for inspection types defined in system parameter INSPTYPESWNBES default "RTN,RTA,CUL,CMI,OTH"

// NTI_DoReviewInspection        ***** Copied from v15dev
//  `Load RO the required [Nti_tunnelinfo], use method FM_ReturnInspectionTitle to show the inspection title
//  `format the description better

//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-13)
// ut_ScanSequences        ***** Copied from v15dev
//  `added two missing tables Ratingreportvehicles and Bridgestairs

//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-14)
// [Bridge Design];"Design Print Form"
//  `adjusted vert size of vars and labels to 11 from 9 for better fit of text

//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-15)
// changed all calls to New Process , LSpawnProcess or Execute on Server to use stack size 0, or <>LStackSize (which is 0)
// removed all calls to _O_SET Document type and _O_SET document creator

//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-16)
// INSP_AddTextToArea_WP
//  `adjust method of inserting the text. First create a blank WP area, then use WP SET TEXT w/ wk replace 
//  `handles errors when text contains & or other characters

//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-20)
// [Inspections];"Dive Template" ---- copied to v15dev        ***** Copied to v18
//  `made preview picture icon to move horizontal resize
// [Inspections];"Dive LowCl" ---- copied to v15dev        ***** Copied to v18
//  `enabled on Clicked event for Undermining checkbox
// [Inspections];"Dive Form" ---- copied to v15dev        ***** Copied to v18
//  `enabled on Clicked event for Undermining checkbox

// PHOTO_DelSIAorConsultantPages        ***** Copied to v18
//  `adjusted alert messages;fixed load record interactive
// PHOTO_LoadSIAorConsultantPages        ***** Copied to v18
//  `added descriptive alerts;fixed load record interactive
// G_Insp_LockFormOnOff        ***** Copied to v18
//  `moved here code from form method to handle attachments button
//  `added use of system parameter INSP_Attahcments_on to control visibility of button
// FM_RoutineCombinedInput        ***** Copied to v18
//  `moved attachments code to G_Insp_LockFormOnOff
// [Inspections];"AboveWater Template"        ***** Copied to v18
//  `moved attachments button here as a picture button with MADOTIcons/PaperClipbuttonsvg24.png

//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-23)
// ut_SQLReturnActLogRecords        ***** Copied to v18
//  `added missing [bridgestairs] table to Dive and District server downloads
// [Dialogs];"Search Def Element".ApprovalLevel        ***** Copied to v18
//  `mark that the elements need to be filtered only if there is a change in the selector
// [Dialogs];"Search Def Element"        ***** Copied to v18
//  `clear the ELMTSFILTERED set; initialize flag of filtered elements to false
// CreateRandomSetForDefElement        ***** Copied to v18
//  `Instead of looping through records use arrays to filter inspections.
//  `don't go trhough filtering again, unless needed. only time it needs to be done is
//  `if the condition on the status of the report is changed (level of approval)
// ELMSRCH_ElementFilter        ***** Copied to v18
//  `clean up code

//  ****  v18 ONLY ***`
// [Inspections];"AboveWater Template".PrintReport
//  `call INSP_SaveInspCommts

//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-27)
//Method: INSP_LoadElemsByInspType        ***** Copied to v18
//Description
// define a process object containing element definitions by inspection type for use in reports and listboxes
// where multiple inspection types are presented. Creates/updates process objects INSP_InspTypeElems
// INSP_InspTypeElems {
//    "RRR"    : attribute same as inspection type 
//          {  : object
//            { , , } : "ElemIDs" longinteger array of element numbers match to field [ElementDict]ElementNo
//            { , , } : "ElemLabels" text array of element numbers as printed on forms ie 1, 2, 1.a etc.
//          }

// GetParentPrefix        ***** Copied to v18
//  `use the BaseType if it is defined ; add PED
// GetElmtNumber        ***** Copied to v18
//  `use the BaseType if it is defined

//Method: INSP_GetParentPrefix        ***** Copied to v18
//Description
// Get the prefix of the parent element similar to GetParentPrefix but using 
// using object INSP_InspTypeElems_o defined by INSP_LoadElemsByInspType 
// Parameters
// $0 : $ElmNumber_txt
// $1 : $ElmNum_L (optional)

//Method: INSP_GetElmtNumber        ***** Copied to v18
//Description
// return the element number label usually returned by GetElmtNumber but 
// using object INSP_InspTypeElems_o defined by INSP_LoadElemsByInspType 
// Parameters
// $0 : $ElmNumber_txt
// $1 : $ElmNum_L (optional)

// LB_ProcessElemSftyQuery1        ***** Copied to v18
//  `use methods INSP_LoadElemsByInspType and INSP_GetElmtNumber to account for reports where insp type controls the 
//  `element numbering

// LSS_SetEntryColor        ***** Copied to v18
//  `converted object set color to object set RGB colors


//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-29)
//  *-*-*-*  START v18 ONLY *-*-*`
// G_Insp_ViewAllCmts
//  `call INSP_SaveInspCommts
// INSP_PreviewBtn_OM
//  `call INSP_SaveInspCommts
// [Inspections];"Closed Bridge".Page Preview Btn
//  `call INSP_SaveInspCommts
// [Inspections];"Culvert Combined".Page Preview Btn
//  `call INSP_SaveInspCommts
// [Inspections];"Dive Template".Button3
//  `call INSP_SaveInspCommts
// [Inspections];"PedestrianInspection-PED".Page Preview Btn
//  `call INSP_SaveInspCommts
// [Inspections];"RailCulvertCombined-RRC".Page Preview Btn
//  `call INSP_SaveInspCommts
// [Inspections];"RailRoutineInput".Page Preview Btn1
//  `call INSP_SaveInspCommts
// [Inspections];"Routine Combined".Page Preview Btn
//  `call INSP_SaveInspCommts
// [Inspections];"Tunnel Template".DE Button Save
//  `call INSP_SaveInspCommts
// [Inspections];"TunnelInspection".Page Preview Btn
//  `call INSP_SaveInspCommts
// [Inspections];"TunnelOverheadInspection".Page Preview Btn
//  `call INSP_SaveInspCommts

// INSP_Comments_WP_OM
//  `use the on data change event to mark the area as changed. - 
//  `do clean up and save changes on Losing focus - This is because on data change fires even before leaving the area.
// INSP_ElementNavigation_OM
//  `call INSP_Comments_WP_OM with on losing focus

// ====
//  went thru all forms with Write Pro Areas - checked events On load, On Unload, On Losing focus 
//  enabled in both form and WP objects ; set all Write Pro areas to Page view mode from embedded 
// ====

//  *-*-*-*  END v18 ONLY *-*-*`

//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-29)
//  *-*-*-* START v18 ONLY *-*-*`
// NTI_SaveAndUpdateComments_WP
//  `fixes for saving changes in comments other than general remarks
// [TIN_Inspections];"Input".DE GeneralRemarks_WP
//  `fixes for saving correctly comments other than GENERAL REMARKS
// NTI_ELEMINP_SAVE
//  `fix to save correctly element notes
//  *-*-*-*  END v18 ONLY *-*-*`

//**********`Modified by: Costas Manousakis-(Designer)-(2021-12-30)
// "ReLogRecords"        ***** Copied from v15DEV
//  `added a button to clear Parent data - usefull for LSS tables who have parent but don't use it in act log.


//End Mods_2021_12_bug