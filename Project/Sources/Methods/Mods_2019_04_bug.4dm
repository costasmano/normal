//%attributes = {"invisible":true}
//Method: Mods_2019_04_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/10/19, 11:46:09
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(4/9/19)
// SIA_Item5_OM
//  `change Item5D to text var to allow a route letter ex. 2A 
// [Bridge MHD NBIS];"SI & A Input"
//  `fixed filter Item5Main to correctly allow A for route number, added filter Item5TNL - use these directly instead of building them in code
// [NBIS Secondary];"2nd In"
//  `changed filter for Item5D to allow a letter in the route (ex . 2A), changed Variable Item5D_L to Item5D_txt

// Modified Forms : 
// [TIN_Inspections];"Input"
//  `Removed Roof girder , etc. from Rating report data.

//**********`Modified by: Costas Manousakis-(Designer)-(4/9/19)
// Modified Forms and form method : 
// [NTI_TunnelRatings];"TunnelRating_LB"
//Added label with title to be based on L1 from TunnelInfo in form method;
//hide Rating girder/slab columns ; resized LB and buttons; change dates to internal date short

// Modified Forms : 
// [NTI_TunnelInfo];"Input"
//  `hide columns for girder/slab ratings in listbox "TunnelRating_LB" , change size of listbox, change format of dates to internal date short
// [NTI_TunnelRatings];"Input"
//  `hide the girder and slab ratings
// [TIN_Inspections];"Input"
//  `Removed Roof girder , etc. from Rating report data.

// Modified Object Methods : 
// [NTI_TunnelInfo];"Input".TunnelRating_LB
//  `get the related TunnelRating records

//**********`Modified by: Chuck Miller-(Designer)-(4/11/19)
// [LSS_Inventory];"ListBoxOutput".bShowAll
//Fix issue with ditrict/category/type dd not working correctly
//Modified by: Chuck Miller (4/11/19 16:17:37)


//**********`Modified by: Costas Manousakis-(Designer)-(4/12/19)
// Modified Method(s) : 
// PRINT_ROUTINE_F
//  `for RRA page 2 print use form "RailRoutinePrPg2" CallReference #627

// Modified Object Methods : 
// "ReLogRecords".RelogDo
//  `When the New Record relation and Flush relation are 0, leave the parentkey and foreiggn key as the main key field,
//  `also include all other fields in the flushGrp except the key field. related to CallReference #628

//```
//```    **** End of Release 7.2.0.d 12-Apr-2019
//```

//**********`Modified by: Costas Manousakis-(Designer)-(4/18/19)
// Modified Method(s) : 
// ut_SQLDownloadNewRecords
//  `Reset MissingParent_B to false when it is OK (ie. for transfers to MHD BMS) - CallReference #631
// Modified Table(s) : 
//[Owners of Data]
//  // made table visible

//```
//```    **** End of Release 7.2.0.e 18-Apr-2019
//```

//**********`Modified by: Costas Manousakis-(Designer)-(4/22/19)
// Modified Object Methods : 
// [PON_ELEM_INSP];"SearchNBE".NBESearch_LB2
//  `remove extra call for a dynamic popup at the end of code for $col=1 

// Modified Forms : 
// [PON_ELEM_INSP];"SearchNBE"
//  `made both listboxes to grow vertically; added a horizontal splitter between the two.


// Modified Method(s) : 
// ut_OpenBridgeWebSite
// ut_OpenHistorySite
//  `use system parameter MADOT_WEBSITE for the web site address


//End Mods_2019_04_bug