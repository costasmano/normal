//%attributes = {"invisible":true}
//Method: Mods_2021_10_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-19T00:00:00, 18:16:41
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10_bug
End if 
//

//**********`Modified (2021-10-18)
// FM_UTResults        ***** Copied from v15DEV 
//  `don't use the [LSS_UT] selections - we are working off an LSS_UT record input form
// LSS_AddUTResultRecord                ***** Copied from v15DEV 
//  `no ned to check for UTRow since we are opening inside a UT input form - use LSS_SelectUTResults_New
//  `Must Save current LSS_UT record before adding if it's a new record
// [LSS_UT];"UltraSonicSubForm_New"               ***** Copied from v15DEV        
//  `enabled on load event on form - made plus button a 3D button for better effect when clicked
// [LSS_UT];"Input"               ***** Copied from v15DEV 
//  `cleared variables from navigation buttons

// [Inspections];"InspectionReview_LB"        ***** Copied from v15DEV
//  `added code on resize event to redraw the listbox

// INSP_aBIE_OM        ***** Copied from v15DEV
//  `change code to get the name from the aPeople array instead of cleaning names from the aBIE array.

// INSP_DTIE_OM        ***** Copied from v15DEV
//  `change code to get the name from the aPeople array instead of cleaning names from the Insp_DTIE_atxt array.

// TININSP_DTIE_OM        ***** Copied from v15DEV
//  `change code to get the name from the aPeople array instead of cleaning names from the Insp_DTIE_atxt array.

//Method: CurrentFormName        ***** Copied from v15DEV
//Description
// return the name of the current form - executed withing the context of a form method or a form object - relies on 
// Current method path
// Parameters
// $0: $formName_txt
// $1 : $methodpath_txt

// [Personnel];"Inspectors In"        ***** Copied from v15DEV
//  `resize window on load to fit input form

//```
//```    **** End of Release 7.3.1.e 22-Oct-2021
//```

//**********`Modified by: Costas Manousakis-(Designer)-(2021-10-26)
// [Bridge MHD NBIS];"RailTransitSIA"        ***** Copied from v15
//  `fixed wrong var for item 39
// [BridgeMHDNBISArchive];"RailTransitSIA"        ***** Copied from v15
//  `fixed wrong var for item 39

//**********`Modified by: Costas Manousakis-(Designer)-(2021-10-27)
// [Personnel];"ADDUserDialog"        ***** Copied to v15BugGix        ***** Copied from v15
//  `arranged the HL lists - added list to pick a user from inactives instead of creating a new one.
// ADDUSER_Utils        ***** Copied to v15BugGix        ***** Copied from v15
//  `added option to pick a user from the inactive users to use as new user :D

//**********`Modified by: Costas Manousakis-(Designer)-(2021-10-28)
// INSP_MyReviewInspections        ***** Copied to v15BugGix        ***** Copied from v15
//  `include search for team members in the search for MYINSPECTIONS 
// INSP_InspReviewDesTool_OM        ***** Copied to v15BugGix        ***** Copied from v15
//  `change from execute method to EXECUTE FORMULA

//**********`Modified by: Costas Manousakis-(Designer)-(2021-10-29T00:00:00)
// [Bridge MHD NBIS];"SI & A (Insp)"        ***** Copied to v15BugGix        ***** Copied from v15
//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
// [ElementsSafety];"Safety ElmInput"        ***** Copied to v15BugGix        ***** Copied from v15
//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
// [ElementsSafety];"SafetyElementInputEx"        ***** Copied to v15BugGix        ***** Copied from v15
//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
// [Inspections];"HighwayFCRInsp1"        ***** Copied to v15BugGix        ***** Copied from v15
//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
// [BridgeMHDNBISArchive];"RailTransitSIA"        ***** Copied to v15BugGix        ***** Copied from v15
//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
// [Bridge MHD NBIS];"RAIL_SIA_Input"        ***** Copied to v15BugGix        ***** Copied from v15
//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
// [Bridge MHD NBIS];"RailTransitSIA"        ***** Copied to v15BugGix        ***** Copied from v15
//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
// [Bridge MHD NBIS];"SI & A (Normal)"        ***** Copied to v15BugGix        ***** Copied from v15
//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
// [Bridge MHD NBIS];"SI & A Input"        ***** Copied to v15BugGix        ***** Copied from v15
//  `changed labels for MBTARTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
// [Inspections];"HighwayFCRInsppg2"        ***** Copied to v15BugGix        ***** Copied from v15
//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
// [RAILBridgeInfo];"RailInput"        ***** Copied to v15BugGix        ***** Copied from v15
//  `changed labels for HWYRTGs to TBusA, TBusB - reuquested by D. NG 10/19/2021

//```
//```    **** End of Release 7.3.1.f 29-Oct-2021
//```

//End Mods_2021_10_bug