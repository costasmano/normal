//%attributes = {"invisible":true}
//Method: Mods_2015_12_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/04/15, 10:38:54
	// ----------------------------------------------------
	//Created : 
	Mods_2015_12_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(12/1/15)
// Modified Method(s) : 
// Method: ut_GenCondRepFromArchive
//  `adjusted to include area calculations; show alert if no records were found

//**********`Modified by: Costas Manousakis-(Designer)-(12/2/15)
// Modified Method(s) : 
//QR_Archive_SDNextYear 
//  `was  returning var QRCust2_L instread of $SDNextYear_L

// Modified Method(s) : 
//Compiler_TransfLog 
//  `placed method declarations in if (False)

//**********`Modified by: Costas Manousakis-(Designer)-(12/8/15)
// Modified Method(s) : 
//Method: NTI_XMLScript
//  `added C_TEXT($0;$1) !!
//Method: NTI_FillDropDowns
//  `fixed select for Town Data to get the Place code

//```
//```   **** End of Release v6.5.0.a 12/04/2015
//```

//**********`Modified by: Costas Manousakis-(Designer)-(12/12/15)
// Modified Method(s) : 
//LSS_CustomSearch
//  `Set the window title after closing the Dialog

// Modified Object Methods : 
//Method: Object Method: [NTI_TunnelInfo].Input.bValidate
//  `added [NTI_TunnelInfo]NTI_ModifiedTimeStamp_s and [NTI_TunnelInfo]NTI_ModifiedBy_s
//Method: Object Method: [NTI_TunnelInfo].New_TIN.bValidate
//  `Added [NTI_TunnelInfo]NTI_CreatedBy_s and [NTI_TunnelInfo]NTI_CreatedTimeStamp_s

//**********`Modified by: Costas Manousakis-(Designer)-(12/14/15)
// Modified Object Methods : 
//[LSS_Inventory];"Input".LSS_Approved_L
//  `Set window title to "inspection review" when opening review dialog.

// Modified Method(s) : 
//G_GetUWRatings
//  `Added progress messages and an Alert at the end when a UW inspection was found.

//G_Insp_SetPersUI 
//  `added Case for MPA inspection resp. if Insp resp does not fall in a case then leave DistNo blank.
//  `This will pick the blank name from the personnel table

//**********`Modified by: Costas Manousakis-(Designer)-(12/15/15)
// Modified Method(s) : 
// Method: M_WRT_CsltInsp_ReqFee
//  `for variable vEndOfInspMonth consider case when the month might be during the next year

//**********`Modified by: Costas Manousakis-(Designer)-(12/21/15)
// Modified Method(s) : 
//Method: PON_ut_compareNBEs
//  `use the current datatransfer settings as default IP and to search in FileIDRes table
//  `make sure we found records in the FileIDRes table for the destination - otherwise abort 

// Created Method(s) : 
//Method: ut_ArrayToText
//Description
// Convert and array to a text variable. Can handle String, text, Date, integer, longint, real
// Can specify the separator between the array elements. default is charriage return (char(13))
// Can also specify a prefixfor each of the array elements. default is ""
// Parameters
// $0 : $MyText_txt
// $1 : $array_ptr
// $2 : $Delimiter_txt (optional)
// $3 : $Prefix_txt (optional)
// $4 : $Format_txt (optional)

//COMPILER_Utilities
//  `added ut_ArrayToText


//**********`Modified by: Costas Manousakis-(Designer)-(12/23/15)
// Modified Forms /Form method: 
//[LSS_Inventory];"New_InventoryItem"
//  `initialize LSS_RouteDesignation_s
//  `Added Route Suffix Checkbox 
//  `Added * to indicate required fields

// Modified Object Methods : 
// Object Method: [LSS_Inventory].New_InventoryItem.LSS_RouteDesignation_atxt
// Object Method: [LSS_Inventory].New_InventoryItem.LSS_Route_L
//  `Added route suffix to add "A"  after route number
// Modified Method(s) : 
//Compiler_LSS
//  `LSS_RouteSuffix_L

//Object Method: [ScourPOA].Input-A.SCPOA_Descr2_txt
//  `Fix on Right click popup menu; and  if statement in on mouse enter

//Changes to ALL Forms
// Fixes for move to v14 or 15 to make sure object method only runs using approriarte form event

//End Mods_2015_12_bug