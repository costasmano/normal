//%attributes = {"invisible":true}
//Method: Mods_2022_04
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/05/22, 12:21:43
	// ----------------------------------------------------
	//Created : 
	
End if 
//
//Change the way we identiify the Server IP address and whether we are in test or not
//Modified by: Chuck Miller (4/5/22 12:23:05) 
//OM_ControlOpenandMoveRatingPDF 
//OM_ControlOpenandMoveInspPDF 
//INSP_ReportIncompleteInsp 
//INSP_PrintToPDF 
//INSP_LoadForApprInspections
//Method: "BinRequestDisplayandMove"
//Method: [Bridge MHD NBIS];"Bridge Input".OpenRatingFolder


//**********`Modified by: Costas Manousakis-(Designer)-(2022-04-06)
//Method: PDF_CombinePdfs
//Description
// Combine pdfs using either pdftk on windows or python script join.py on mac
// Parameters
// $1 : $InputPdfs_ptr : pointer to array of filespecs to be combined
// $2 : $ResultFile_txt : filespec of output file

//Method: PDF_SetPDFtkPath
//Description
// Set/update the PDFtk path used 

// ut_ControlUserPrefs
//  `added C_TEXT(<>PDFTKLocation_txt)

// "EditPrefs"
//  `listbox not sortable

// [Town Address];"View Town Address_LB".Variable8
//  `added option to open quick report or print addresses

//```
//```    **** End of Release 8.0.0 2022-04-18
//```

// ut_testEmailSending
//  `added creating Outlook email if set in preferences.

//Converted old output forms to list boxes
//P_ListTemplates 
//P_ListSpecialReports 
//LST_MaintainListTable 
//[TableOfLists];"Output_LB"
//[Templates];"Output_LB"
//[zSpecialReports];"Output_LB"

//**********`Modified by: Costas Manousakis-(Designer)-(2022-04-22T00:00:00)
// G_WP_MakeDocument
//  `make [templates] read only
// M_WRT_BrInspRpt
//  `make [Templates] Read only
// M_WRT_CsltInsp_ComplexNTP
//  `make [Templates] Read only
// M_WRT_CsltInsp_ComplexReqFee
//  `made Templates table Readonly
// M_WRT_CsltInsp_NTP
//  `make [Templates] Read only
// M_WRT_CsltInsp_Review
//  `make [Templates] Read only
// M_WRT_CsltRating_NTP
//  `make [Templates] Read only
// M_WRT_CsltRating_ReqFee
//  `make [Templates] Read only
// PRJ_WRT_ProjectLetters
//  `make [Templates] Read only

//Method: INSP_CountInspImages
//Description
// Count Inpsection image types
// Parameters
// $0 : $Counts_o : object containing counts
//  .total
//  .photos
//  .sketches
//  .charts
// $1 : $InspId_L ( optional) default is current inspection ID

// INSP_FRZ_PrintCmts_WP
//  `use method INSP_CountInspImages  
// 

//  `use method INSP_CountInspImages  
// Print_CUL_Cmts_WP
//  `use method INSP_CountInspImages  
// Print_RTN_Cmts_WPx
//  `use method INSP_CountInspImages  
// Print_Tunnel_Cmts_WP
//  `use method INSP_CountInspImages  

//**********`Modified by: Costas Manousakis-(Designer)-(2022-04-27)
//Method: ACTLOG_RefIDReport
//Description
// Scan the sequences of RefID in [Activity Log] and produce a report
// indicating the ranges of RefIDs - will create a CSV file with
// RangeStart , RangeEnd, RangeSpan, RangeCount
//  // RangeSpan is the differnece between the last RefID in one range and the first RefID in the next range
//  // RangeCount is the number of records in the range

//**********`Modified by: Costas Manousakis-(Designer)-(2022-04-29)
// LSS_NonDamageAddHeader_WP
//  `When adding element text - first create a WP New, then use WP SET Text - Corrects failed WP import message
// LSS_AddHeader_WP
//  `When adding element text - first create a WP New, then use WP SET Text - Corrects failed WP import message
// TMPL_WPDirectFind
//  `added searching for WP templatees in addition to WRP

//End Mods_2022_04