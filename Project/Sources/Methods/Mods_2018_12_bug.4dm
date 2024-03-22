//%attributes = {"invisible":true}
//Method: Mods_2018_12_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/04/18, 16:49:09
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(12/4/18)
// Modified Object Methods : 
// [LSS_Inventory];"ListBoxOutput".Tools
//  `obj set vis = false when not permitted.

//**********`Modified by: Costas Manousakis-(Designer)-(12/5/18)
// Modified Form Methods : 
// [Dialogs];"BigAlert"
//  `don't allow the window to become less than original width or height

//**********`Modified by: Costas Manousakis-(Designer)-(12/7/18)
// Modified Forms : 
// [NTI_TunnelInfo];"NTIED_Print"
//  `change the title of TIN to BOAT when not TIN.
//  `Fix Title of subsection 2.9

//**********`Modified by: Costas Manousakis-(Designer)-(12/10/18)
// Modified Method(s) : 
// G_InitInspVars
//  `for any RRO bridge set INSP_MBTABridgeType_txt = "Commuter" to allow DOT rail div to snter Rail engine loads

//**********`Modified by: Costas Manousakis-(Designer)-(12/11/18)
// Modified Object Methods : 
// [Personnel];"Inspectors In".Field12
//  `added check to make sure other Personnel don't have the same 4D user ID
// [Personnel];"Inspectors In".PWUserHList
//  `added check to make sure other Personnel don't have the same 4D user ID

// Created Method(s) (usercall 591) : 
//Method: INSP_RatingReq_OM
//Description
// method for Rating request checkbox in bridge inspection input forms

// Modified Object Methods : (usercall 591) 
// [Inspections];"Critical Member".DE RatingRequest chkbox
// [Inspections];"Culvert Combined".DE RatingRequest chkbox
// [Inspections];"Damage Form".DE RatingRequest chkbox
// [Inspections];"RailCulvertCombined-RRC".DE RatingRequest chkbox
// [Inspections];"RailRoutineInput".DE RatingRequest chkbox2
// [Inspections];"Routine Combined".DE RatingRequest chkbox2
// [Inspections];"RoutineNewNBE".DE RatingRequest chkbox2
//  `use INSP_RatingReq_OM

// Modified Object Methods :  (usercall 592) 
// [LSS_Inventory];"ListBoxOutput".Inventory_LB
//  `restore the named selection "InventorySet" when returning 
//  `from the opening an inv record on Double click

//**********`Modified by: Costas Manousakis-(Designer)-(12/17/18)
// Modified Method(s) : 
// ut_StartMessage
//  `increased $maxcycle to 48 from 16

//**********`Modified by: Costas Manousakis-(Designer)-(12/20/18)
// Modified Method(s) : 
// NTI_OpenInspection
//  `make sure inspection record is loaded in RO when exiting method.
// [TIN_Inspections];"ReviewList".bShowAll
//  `The sort is done in NTI_GetMyPending
// NTI_ListPendingTINInsp
//  `The sort is done in NTI_GetMyPending
// NTI_GetMyPending
//  `Cleaned up method of retrieving pending based on insp resp - CallReference #593 
//  `sort the selection by the TIN sort method NTI_SortByFormula.

// Modified Forms : 
// "MethodsList".Copy2txt
//  ` added to copy the list to a text in pasteboard

//**********`Modified by: Costas Manousakis-(Designer)-(12/28/18)
// Modified Method(s) : 
// ut_ReturnUserDocFolder
//  `attempt to address CallReference #594
//  //use new constant "Documents folder" ; allow multiple levels of subforlders to be created

//```
//```    **** End of Release 7.2.0.a 11-Jan-2019
//```

//End Mods_2018_12_bug