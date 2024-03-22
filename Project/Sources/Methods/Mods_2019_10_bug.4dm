//%attributes = {"invisible":true}
//Method: Mods_2019_10_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/15/19, 15:32:47
	// ----------------------------------------------------
	//Created : 
	Mods_2019_10_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(10/01/19)
//Method: ut_SelectRandomRecords
//Description
// Create a random set of records from the current selection of a table
// Parameters
// $1 : $CurrTable_ptr
// $2 : $NumberOfRecords_L
// $3 : $Options_txt (highilght them, change the selection, put them in a set or selection)
// $4 : $SetorSelectionName_txt

//**********`Modified by: Costas Manousakis-(Designer)-(10/02/19)
// NTI_PONHELP_FM
//  `make all tables RO.
// PON_PONHELP_FM
//  `make all tables RO.

// [NTI_ELEM_TIN_INSP];"All_Item_Tunnel_Inspection_1"
//  `hide the district engineer variable, label and vertical line
// [TIN_Inspections];"Input"
//  `removed District Tunnel Eng'r


//**********`Modified by: Costas Manousakis-(Designer)-(10/09/19)
//Method: INSP_FldWorkCmpl_OM
//Description
// object method for the [Inspections]InspFldWorkComplDate field for CallReference #663
// Parameters

//Method: [TIN_Inspections];"Input".DE InspCompleteDate
//Description
// object method for the [Inspections]InspFldWorkComplDate field for CallReference #663
// Parameters

// Modified Object Methods : 
// [Inspections];"Closed Bridge".DE FieldWorkComplete
// [Inspections];"Critical Member".DE FieldWorkComplete
// [Inspections];"Culvert Combined".DE FieldWorkComplete
// [Inspections];"Damage Form".DE FieldWorkComplete
// [Inspections];"Dive Form".DE FieldWorkComplete
// [Inspections];"Dive LowCl".DE FieldWorkComplete
// [Inspections];"FreezeThawA".DE FieldWorkComplete
// [Inspections];"Routine Combined".DE FieldWorkComplete
// [Inspections];"RoutineNewNBE".DE FieldWorkComplete
// [Inspections];"StormDamageInspection".DE FieldWorkComplete
// [Inspections];"Underwater Special Member".DE FieldWorkComplete
//  `use method INSP_FldWorkCmpl_OM  CallReference #663

// G_Insp_LockFormOnOff
//  `lock field work complete date if it has been entered once. CallReference #663
// NTI_CheckInspComplete
//  `check if field work complete date is in the future. CallReference #663
// INSP_FieldWorkComplCheck
//  `check if field work complete date is in the future. CallReference #663
// G_Insp_SaveInspection
//  `add check for inspection date in the future -related to FldWorkComplete issue. CallReference #663

//**********`Modified by: Costas Manousakis-(Designer)-(10/18/19)
// SIA_Description_OM
//  `dont make change to the field, if a valid code has not been selected.
// [Bridge MHD NBIS];"BDEPT Input".Save
//  `list all errors found - add checks for Item7, 6A , InspResp

//**********`Modified by: Costas Manousakis-(Designer)-(10/22/19)
// G_AddElmtTxt2Area
//  `delete the last char if it is a carr.ret CallReference #655
// G_ElmtRemarksArea
//  `delete the last char if it is a carr.ret CallReference #655
// Print_Dive_Cmt_a_new
//  `when adding Element comments delete the last char if it is a carr.ret
//  `and  apply stylesheet 1 when adding linefeeds at the end  -  CallReference #655
// Print_RTN_Cmts
//  `apply stylesheet 1 when adding linefeeds at the end  -  CallReference #655
// Print_Comments
//  `when adding the element comments, delete the last char if it is a carr.ret CallReference #655
// G_InspParagProt
//  `better handling of paragraph settings when splitting text to handle bullets correctly CallReference #655
// INSP_4DWRITE_SaveToFld
//  `add a carriage return at the end of the on screen document before copying the styled text.
//  `This is to include paragraph formatting of the last paragraph in the save styled text. - CallReference #655
// Insp_PrintRemarks
//  `instead of scanning character by character to find starts and ends of pages, use page count
//  `when printing the last page, add a carriage return to preserve any paragraph formatting such as bullets - CallReference #655
// INSP_Comments_OM
//  `After loading or saving the 4D Write area, delete the last char because INSP_4DWRITE_SaveToFld adds a carriage return  CallReference #655
// [Inspections];"Dive Pr Pg 2 wrt"
//  `delete the last char inserted if it is a carr - ret  CallReference #655

// G_Insp_AddOrientation
//  `delete the last char if it is a carr.ret CallReference #655
//  `when moving to the end of the area, use twice the char count - CallReference #658
// G_Insp_AddGenCmts
//  `delete the last char if it is a carr.ret CallReference #655
//  `when moving to the end of the area, use twice the char count - CallReference #658

// CheckDependencies
//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
// G_InspGetRatings
//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
// G_WRT_GenericBridgeLetter
//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
// G_GetSIARecPosting
//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
// [Bridge MHD NBIS];"Bridge Input".AddRatingBtn
//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
// [RatingReports];"RatReportsIn".DeleteRatingBtn
//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
// SIA_ControlDoubleClick
//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
// G_SIA_GetRecPostings
//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
// SIA_BridgeInpNavCTRL
//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662

//**********`Modified by: Costas Manousakis-(Designer)-(10/24/19)
// ut_ArraysToText
//  `changed methodology to build an array of text blocks first and then combine into the result

//**********`Modified by: Costas Manousakis-(Designer)-(10/25/19)
// GetElmtNumber
//  `Added special case for PED - same as RR@ - CallReference #667
// Insp_SortElmtSfty
//  `use the same method for PED inspections as for RR@ inspections - CallReference #667

// Modified Forms : 
// [Inspections];"PedBridge_p2"
//  `fixed line work on page 0 
// [Inspections];"PedBridge_p1"
//  `adjusted location and objects on page 0, fixed the inspection date and format of other values on page 1 - CallReference #667

//Method: INSP_GetDefaultUOE
//Description
// Get the default UOE ID for a bridge inspection based on Insp resp 
// Parameters
// $0 : $DBIE_L
// $1 : $InspResp_txt

//**********`Modified by: Costas Manousakis-(Designer)-(10/28/19)
// Print_RTN_Cmts
//  `add message when assembling comments

//**********`Modified by: Costas Manousakis-(Designer)-(10/29/19)
// G_InspParagProt
//  `fix logic determining where to insert the (Cont'd) label when text spans multiple pages. 
// WRUTIL_Function
//  `added cases for codes 8211 (dash) , 8217 (single quote) 8220,8221 (double quote)


//```
//```    **** End of Release 7.2.0.f 30-Oct-2019
//```

//End Mods_2019_10_bug