//%attributes = {"invisible":true}
//Method: Mods_2016_08_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/05/16, 09:35:25
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(8/5/16)
// Modified Method(s) : 
//ut_SRVMonthlyReports 
//  `` set to report in english units

// Modified Form Methods : 
//Form Method: [LSS_Inspection];"SignStructurePg1"
//  `count "LSS_PanelType@" instead of "LSS_Panel@"  - it was counting both

//**********`Modified by: Costas Manousakis-(Designer)-(8/8/16)
// Modified Method(s) : 
//NTI_InputForm_INIT
//  `enabled this for all users

//**********`Modified by: Costas Manousakis-(Designer)-(8/9/16)
// Modified Method(s) : 
//NTI_CombineBIN2TIN
//  `when ready to add / modify recrords in [NTI_ELEM_TIN_INSP] make sure table is in read write mode
//Method: NTI_SaveImage
//  `add f_TrimStr ([TIN_Insp_Images]ImageDescr;True;True)
//Method: NTI_ImageInput_FM
//  `added C_PICTURE(Photo_pct)
//Method: NTI_INSP_AddImage_OM
//  `added READ WRITE([TIN_Insp_Images])
//Method: NTI_TinINSP_ImageLB_OM
//  `added  NTI_ListInspImages at end of double click
//Method: NTI_TININSPListBox_OM
//  `added code to reset window and listbox size
//Method: NTI_AddTIN_Inspection_OM
//  `added code to reset window and listbox size

// Modified Object Methods : 
//Object Method: [TIN_Inspections];"Input".bPrint 
//  `added check for changes in AreaGeneralRemarks
//Object Method: [TIN_Inspections];"Input".vPrintPreview 
//  `added check for changes in AreaGeneralRemarks

// Modified Forms : 
// [NTI_TunnelInfo];"InspectionList"
//  `Made Close button a 3D Button with icon  from  library 2209  resized and moved

// Modified Method(s) : 
//  Method: INSP_ExportInspection
//  `added check if this is run not in the context of an input form

// Modified Forms : 
//[Inspections];"SimpleInput"
//  `Added Export Button

//**********`Modified by: Costas Manousakis-(Designer)-(8/10/16)
// Modified Object Methods : 
//Object Method: [TIN_Insp_Images];"Input".Photo_pct 
//  `Removed  converting to Jpeg, added check for PDF - if PDF clear picture.

// Modified Forms : 
//Form Method: [TIN_Insp_Images];"PrintPhotoLand"
//  `added missing header fields  

//```
//```   **** End of Release 6.6.0.a 10-Aug-2016
//```


//End Mods_2016_08_bug