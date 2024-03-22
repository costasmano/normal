//%attributes = {"invisible":true}
//Method: Mods_2015_09_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/08/15, 16:11:23
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(9/2/15)

// Created Form(s) : 
//[LSS_Inventory];"Edit_SIN"

// Created Method(s) : 
//LSS_Edit_Inv_SIN
//  `Allow editing of the Structure inventory number (SIN, LIN,...)

//ut_ArrayToDynamicMenu
//  ` return a menu reference for use in  dynamic pop up menu 
// Parameters
// $0 : $menuRef (A16)
// $1 : $menuitems_ptr : ptr to array with the menu items 
// $2 : $nenuparameters_ptr : ptr to array with the menu item parameter 
// $3 : $Star_ (A1) : (optional) star option for ADD menu item. to ignore special chars in the menu item
// ----------------------------------------------------

// Modified Forms : 
//[LSS_Inventory];"Input"
//  `added button "Edit Tools" that shows a menu to either edit the mile point or edit the last 5 digits of the SIN number

//**********`Modified by: Costas Manousakis-(Designer)-(9/9/15)
// Modified Method(s) : 
//ut_SQLReturnActLogRecords 
//  `When checking for deleted records add [TunnelInspection] and [PON_ELEM_INSP]
//  `When checking for children of deleted Inspections use field [Activity Log]Parent ID NOT [Activity Log]Local ID

//ut_ACTLOG_addInsp
//  `Under The "INSPECTIONS" task add  [TunnelInspection] and [PON_ELEM_INSP]

//COMPILER_Utilities
//  `added ut_ArrayToDynamicMenu

// Modified Forms : 
//[LSS_Inventory];"Input"
//  `added button "Edit Tools" that shows a menu to either edit the mile point or edit the last 5 digits of the SIN number

//**********`Modified by: Costas Manousakis-(Designer)-(9/14/15)
//[Bridge MHD NBIS];"Rpt RPC"
//[Bridge MHD NBIS];"Rpt Mstr"
//[BridgeMHDNBISArchive];"Rpt Mstr"
//[BridgeMHDNBISArchive];"Rpt Mstr Detail"
//[BridgeMHDNBISArchive];"Rpt Mstr Hdr0"
//[BridgeMHDNBISArchive];"Rpt RPC Detail"
//[BridgeMHDNBISArchive];"Rpt RPC FedAid"
//  `increased vert size of text for v14/v13 migration

// Modified Object Methods : 
//[LSS_Inspection];"Inspection_Template".bValidate
//  `Reload images after saving when on images tab

// Modified Object Methods : 
//[LSS_Photos];"Input".LSS_PhotoTypes_atxt
//  `if user click on blank line  reset pulldown to the field value.


//**********`Modified by: Costas Manousakis-(Designer)-(9/15/15)
// Modified Forms : 
//[Bridge MHD NBIS];"Bridge Input"
//  `made  all buttons  on page 1 not  focusable

//[Dialogs];"Preferences"
//[Dialogs];"TransferSet"  
//[Dialogs];"DesRating"
//[Dialogs];"CondRatingHlpUW"
//[Dialogs];"Item75Costs"
//[Dialogs];"SelectPontisInsp"
//[Dialogs];"BridgeDesignHelp"
//[Dialogs];"MyConfirm"
//[Dialogs];"ReSendActLog"
//[Dialogs];"BigAlert"
//[Dialogs];"SpecialReportSelect"
//[Dialogs];"ut_Request"
//[Dialogs];"PRJ_BPGM_Search"
//[Dialogs];"TwoListMove"
//[Dialogs];"SaveLists"
//[zDialogs];"PrintReport"
//  `buttons made  shorter to fix highlight in v13+ 10.10.x+

//[Dialogs];"DependencyCheck"
//  `Accept All button made wider

// Modified Method(s) : 
//FM_PhotoInput 
//  `for new record initialize  phototype and sequence based on last used type,  if first time default to photo
//LSS_FillAccessibility
//  `fixed pointers $Used_ptr and $Need_ptr: were pointing to wrong variables.
//FM_SavePhotoInput
//  `added reduction of image size
//LSS_UpdateDMeterorUltraPicture
//  `do not compare blobs if size = 0
//LSS_AccessibilitySave
//  `Added check for changes in the description.
//  `fixed pointers $Used_ptr and $Need_ptr: were pointing to wrong variables.
//LSS_SaveDMorUTPicture
//  `compare blobs only when blob sizes are equal - otherwise update is true
//  `added form events to handle drag and drop


//**********`Modified by: Costas Manousakis-(Designer)-(9/17/15)
// Modified Forms : 
//[LSS_Inspection];"Input_Signal"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_ITS"
//  `enabled all on drag and drop events for the DMeter, UTSketch pictures

// Modified Object Methods : 
//[LSS_Inspection];"Input_Signal".LSS_DMeterPicture_pct 
//[LSS_Inspection];"Input_Signal".LSS_UTPicture_pct
//[LSS_Inspection];"Input_Sign".LSS_DMeterPicture_pct
//[LSS_Inspection];"Input_Sign".LSS_UTPicture_pct 
//[LSS_Inspection];"Input_Light".LSS_DMeterPicture_pct 
//[LSS_Inspection];"Input_Light".LSS_UTPicture_pct
//[LSS_Inspection];"Input_ITS".LSS_DMeterPicture_pct
//[LSS_Inspection];"Input_ITS".LSS_UTPicture_pct
//  `drag and drop

// Modified Forms : 
//[LSS_Photos];"Input"
//  `enabled all on drag and drop events for the DMeter, UTSketch pictures
// Modified Object Methods : 
//[LSS_Photos];"Input".Photo_pct
//  `Added code to handle dragging the picture and dropping it on itself

// Modified Method(s) : 
//add_change_del code
//  `placed code in IF FALSE

//Compiler_LSS
//  `drag and drop mods

//**********`Modified by: Costas Manousakis-(Designer)-(9/25/15)
// Modified Method(s) : 
//PON_ELEMINPUTIL
//  `added  task option "SETPARENT_GP_TXT"
//  `use this task under "RESETUI"

//PON_ELEMINP_FM
//  `use new option  PON_ELEMINPUTIL("SETPARENT_GP_TXT")
//PON_ELEMINP_SAVE
//  `Check also if the parent or grandparent key of children is still the same; 
//  `Search again for all inspection elements- dont use set "PON_LISTINSPELEMS". set gets updated when back to the list.
//  `If actions occur while in input form, the set does not get updated.
//  `do the check only if the element is not a smart flag (defect)

//**********`Modified by: Costas Manousakis-(Designer)-(9/28/15)
// Modified Method(s) : 
//TEMP_RecalcBMSInspHI
//  `for NBE inspections need to load the [Inspections]  record
//  `Use a confirm before running the update

// Modified Method(s) : 
//LSS_Edit_MilePoint
//  `changed to enable or disable edit - added parameter 1 ("EDIT" | "LOCK")
//Compiler_LSS 
//  `add LSS_Edit_MilePoint

//**********`Modified by: Costas Manousakis-(Designer)-(9/28/15)
// Modified Method(s) : 
//PON_NewBrMElementCheck
//  `Do not require elements for non-NBI bridge records - wiil still  run checks if there are any elements entered.


//**********`Modified by: Costas Manousakis-(Designer)-(9/28/15)
// Modified Method(s) : 
//INSP_PrintInspBtn_OM 
//  `removed case for "RRR" inspection which was with "RT@" case

//**********`Modified by: Costas Manousakis-(Designer)-(9/30/15)
// Modified Method(s) : 
//INV_PrintInvInsp
//  `initialize vPicture1 to a balnk picture also.  

//End Mods_2015_09_bug