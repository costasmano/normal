//%attributes = {"invisible":true}
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-05-02T00:00:00, 16:57:28
	// ----------------------------------------------------
	//Created : 
	Mods_2022_05
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(2022-05-03)
// WP_CleanupComments
//  `added setting line height to 100%
// INSP_AddTextToArea_WP
//  `after adding the Texttoadd to the wparea range, make sure the whole range has lineheight=100%
// LSS_NonDamageAddHeader_WP
//  `after adding the text make sure line height is 100%
// G_AddElmtTxt2Area_WP
//  `added setting the line height of all text to 100%
// LSS_AddHeader_WP
//  `added setting of Line height to 100% for the whole range at the end 
//  `No need to add a CR after the title text.
// LSS_ErrorMethod
//  `Use system parameter LSS_ErrorFooter for the text to append at the end of the message.

//**********`Modified by: CJ Miller-(2022-05-03)
// modified to use Listbox output
//m_MaintainProjectFile 
// new form for listbox output
//[PRJ_ProjectFile];"Output_LB"
//LST_MaintainListTable
//P_ListSpecialReports
//[zSpecialReports];"Output_LB"
//P_ListTemplates
//[Templates];"Output_LB"
//P_CondRep 
//[Status Report];"Output_LB"
//P_ListServerProcesses 
//[ServerProcesses];"Output_LB"
//G_DisplayTable_generic

//Change input forms to use list boxes 
//[Activity Log];"Input"
//Page 2 File iD res replaced form
//[FileIDRes Table];"output"
//Page 3 Owners of data replaced form
//[Owners of Data];"Inc. Owner Data"
//[BMS Inspections];"Inspections In"
//replaced form [Cond Units];"Cond Units Inc"

//**********`Modified by: Costas Manousakis-(Designer)-(2022-05-13)
// Modified Forms : 
// [Dialogs];"GetInspExtraCmts"
//  `added Multistyle text area with style buttons;  uses Form.Multistyle passed from Dialog command
//  `adjusted size of buttons and minimum width

//Method: f_TrimStyledText
//Description
// Trim a styled text similar to f_trimStr
// Parameters
// $0 : $styledtextTrimmed
// $1 : $paramObject
//   .texttotrim : styledtext
//   .trimleading : true/false default true
//   .trimtrailing : true/false default true

// G_InspExtraCmtsBtn
//  `changed window type to Plain form window, added parameter Multistyle in the DIALOG command.
//  `use method f_TrimStyledText to trim the styled text

// G_Insp_ReplyRevCmts
//  `window type to plain form window

//Method: SORT_Object_Array
//         Purpose: Simple Bubble Sort for an array object
//         $1 - Pointer - Pointer to the object array
//         $2 - Text - Property name to sort on
//         $3 - Boolean - Direction: True< = Ascending, False = Decending

//Method: ParsePersonnelexport
//Description
// Method to parse XML export from the External server from Personnel and FileID res table
// and update another server's Personnel table with the machine login info

// TMPL_Do_Template_Choise
//  `use components to create Excel file when doing a print of QR to 4D View , or QR to HTML

//```
//```    **** End of Release 8.0.0.a 2022-05-18
//```

//Modified by: Chuck Miller (5/24/22 10:54:51)
//Continue coding and testing changes from modify selection to use of list boxes
//[PRJ_ProjectDetails];"ProjectDetails.i"  //Method: Mods_2022_05
//  // Object Method: Button1
//[PRJ_ProjectFile];"PRJ_FileSelection_LB" - new form
//[TableOfLists];"PRJ_Selection_LB" - new form
//PRJ_ControlSelect
//PRJ_SelectorCreateAttribute
//[Bridge MHD NBIS];"PRJ_Selection_LB"
//[Conslt_Name];"PRJ_Selection_LB"-new form
//[TableOfLists];"PRJ_Selection_LB" - new form
//[TableOfLists];"PRJ_Selection_LB" - new form
//[PRJ_DesignContracts];"PRJ_Selection_lb"
//[PRJ_ProjectFile];"PRJ_FileSelection_LB" - new form
//[TableOfLists];"PRJ_Selection_LB" - new form
//[Inspections];"DisplayCoRE_LB"
//[Inspections];"Pontis Form"
//[Inspections];"Routine Combined"
//P_ReviewLogged
//P_OutofFreqRep
//MOd_File//not used anywhere
//P_ScourReport

// ControlMenuBar       **** in BugFix
//  `Added menu item to "Reports" menu after the "Quick Reports..." item
// TMPL_Do_Template_Choise
//  `Use the Header and footer defined in the QR to fill the title and subtitle.
//  `Verify that the report table is the same as the current form table.
//Method: QR_RunReportToExcel       **** in BugFix
//Description
// run a quick report from a file and save to an excel output
// run from a list form
// Parameters
// $1 : $CurrentTable_ptr (optional)

//**********`Modified by: Costas Manousakis-(Designer)-(2022-05-26)
//Bridge_NBISSearchPicker_OM       **** in BugFix
// clean On Load code; change so that all found records are selected; and scroll to the first one

//PersGroupSearchPicker_OM       **** in BugFix
//PersonnelSearchPicker_OM       **** in BugFix
// change so that all found records are selected; and scroll to the first one

//ADDUSER_Utils       **** in BugFix
//collect the usernames and passwords created and when closing the form save them to a text file or place them in the pasteboard

//**********`Modified by: Costas Manousakis-(Designer)-(2022-05-27)
// [Inspections];"InspectionReview_LB".QRPrintButton       **** in BugFix
//changed button to 3D Button custom with a submenu; adjusted widht and rearranged other buttons to fit
// added code to popup a menu with choices to open QR editor or execute a quick report file to excel

//**********`Modified by: Costas Manousakis-(Designer)-(2022-05-31)
// QR_RunReportToExcel       **** in BugFix
//  `use resolve pointer instead of Table($ptr)

//Method: QR_RunStoredQRtoExcel       **** in BugFix
//Description
// execute a stored quick report to Excel. Can be  used using execute formula
// Parameters
// $1 : $masterTable_ptr
// $2 : $TemplateName_txt

// "SelectListBox".LB_Reports       **** in BugFix
//  `added error catching in the execute formula statement

// TMPL_Do_Template_Choise       **** in BugFix
//  `clean up code

//End Mods_2022_05