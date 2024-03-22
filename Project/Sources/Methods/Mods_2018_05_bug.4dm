//%attributes = {"invisible":true}
//Method: Mods_2018_05_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/02/18, 10:05:11
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(5/1/18)
// Modified Method(s) : 
// INSP_ImportInspection
//  `Modifications to allow importing an inspection to a different BIN.

//**********`Modified by: Costas Manousakis-(Designer)-(5/2/18)
// Modified Forms : 
// [NTI_ELEM_TIN_INSP];"All_Item_Tunnel_Inspection_1"
//  `renamed objects for NTI_Contracts , NTI_Segment

// Modified Method(s) : 
// FM_All_Items_Tunnel_Inspection
//  `fit to print NTI_Contracts and NTI_Segment

//**********`Modified by: Costas Manousakis-(Designer)-(5/3/18)
// Modified Forms : 
// [NTI_TunnelInfo];"Input"
//  //Modified page 5 of [NTI_TunnelInfo];"Input"  Special Member Target and Actual Dates were poiting to Overhead items dates

//**********`Modified by: Costas Manousakis-(Designer)-(5/4/18)
// Modified Method(s) : 
// NTI_ElmtRemarksArea
//  `need special case when working with [tin_inspections]comments

// NTI_SaveandUpdateComments
//  `fixed type of id relations in FlushGrpChgs from 1 to 2

// Modified Forms : 
// [TIN_Inspections];"Input"
//  `made max value of the inches in clearance postings to 11.
// [TIN_Inspections];"ReviewList"
//  `added dashes to the tunnel number column

//```
//```    **** End of Release 7.1.0.b 04-May-2018
//```

//**********`Modified by: Costas Manousakis-(Designer)-(5/9/18)

// Modified Forms : 
// [Bridge MHD NBIS];"Bridge Input"
//  `Renamed Add objects on the Tunnel insp page (11) to "New TunnelInsp" , and to "Add New BrgInsp" on insp page (7)
//  `Also removed variable names from the Add and Duplicate insp buttons.
// Modified Object Methods : 
// [Bridge MHD NBIS];"Bridge Input".Add New BrgInsp
//  `Renamed objects on the Insp page (7) to "Add New BrgInsp" to avoid conflicts with the Tunnel Inspection page (11)
//  `Also removed variable names from the Add and Duplicate insp buttons
// [Bridge MHD NBIS];"Bridge Input".New TunnelInsp
//  `Renamed objects on the Tunnel insp page (11) to "New TunnelInsp" to avoid conflicts with the Inspection page (7)
//  `Also removed variable names from the Add and Duplicate insp buttons

// Modified Form/ Methods : 
// [ElementsSafety];"FreezeThawInp_1A"
//  `unload the record when inspection is locked
//  `corrected enterable/editable object names so they start correctly with "DE FRZ"

// Modified Object Methods : 
// [ElementsSafety];"FreezeThawInp_1A".ElmtSelector
//  `when table is RO switch to RW so we can use Modify record. Record is unloaded in the input form


//```
//```    **** End of Release 7.1.0.c 09-May-2018
//```

//Move code from development to
//Fix defect where empty [Activity Log] records creatd for [LSS_Photos] records
//when right click on picture and not phort record existed. Changed DMeter and UT Sketch pages
//Modified by: Chuck Miller (5/24/18 16:34:03)
//LSS_GotToInspectionPage 
//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Signal"


//Method: NTI_SetEnterableForB
//Description
// allow entry to ID and vent zone depending on NTI_Prefix_txt
// [NTI_TunnelInfo];"New_TIN".NTI_Prefix_txt
//Set entry on new TIN input to Allow prefix of T or B
// NTI_CheckForValidate
//  `use object name instead of variable for bValidate
// [NTI_TunnelInfo];"New_TIN".NoEntry6_B
//Set entry on new TIN input to Allow prefix of T or B
// [NTI_TunnelInfo];"New_TIN".NoEntry4_B
//Set entry on new TIN input to Allow prefix of T or B
// [NTI_TunnelInfo];"New_TIN"
// renamed NoEntry6 to NoEntry6_B and NoEntry4 to NoEntry4_B to Allow prefix of T or B


//```
//```    **** End of Release 7.1.0.d 31-May-2018
//```

//End Mods_2018_05_bug
