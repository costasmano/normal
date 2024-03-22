//%attributes = {"invisible":true}
// ********** ` Modified by: costasmanousakis-(Designer)-(6/14/2007 09:08:07)
// Modified Method(s) : 
//PRJ_BPGM_LoadSorts
//  `Use new field [PRJ_ProjectFile]PF_Advertised_d for ad Date
// Modified Forms : 
//[PRJ_ProjectDetails];"BridgeProgram"
//  `Use new field [PRJ_ProjectFile]PF_Advertised_d for ad Date

// ********** ` Modified by: ManousakisC (6/15/2007)
// Modified Method(s) : 
//PRJ_LoadConstructionContract
//  `Added calculation of estimated bid to replace the one from ProjectFile
//PRJ_LoadProjectFileData
//  `Modified the format of Estimated Bid text var
// Modified Forms : 
//[PRJ_ProjectDetails];"ProjectDetails.i"
//  `Modified alignment of est bid, and format of low bid

// ********** ` Modified by: costasmanousakis-(Designer)-(6/18/2007 11:01:01)
// Modified Field(s) : 
//[PRJ_ProjectDetails]PRJ_NonBridge_s
//  `Made field indexed. needed for QUERY WITH ARRAY commands.

// Modified Method(s) : 
//f_TrimStr
//  `Adjusted code to better handle single char results.

// Modified Forms : 
//[PRJ_SketchPlans];"SketchPlans.i"
//[PRJ_StructuralReview];"ProjectReview.i"
//[PRJ_TypeStudy];"TypeStudy.i"
//  `Added buttons to enter Today's date in corresponding fields

// Modified Form Methods : 
//[PRJ_TypeStudy];"TypeStudy.i"
//[PRJ_SketchPlans];"SketchPlans.i"
//  `On a new record set the received date as the current date

//******Search for Str Proj Manager
// Created Method(s) : 
//PRJ_BPGM_InitSRCHVars

// Modified Method(s) : 
//PRJ_BPGM_CleanSearchVars 
//PRJ_BPGM_ClearOtherSrch 
//PRJ_BPGM_CreateSearchSet 
//  `Added code to handle the searches for Str Prj Mgr.

//PRJ_BPGM_CustomSearch 
//PRJ_DET_CustomSearch 
//  `Use new method PRJ_BPGM_InitSRCHVars

// Modified Forms : 
//[Dialogs];"PRJ_BPGM_Search"
//  `Added objects to search for Str Proj mgr
// Modified Form Methods : 
//[Dialogs];"PRJ_BPGM_Search"
//  `Removed unneeded code. Initialization happens at calling methods PRJ_@_CustomSearch .

// Modified Method(s) : 
//PRJ_PrintProjisUpdate
//  `Check if user presses OK at the PRINT SETTINGS dialog

// Created Method(s) : 
//PRJ_PrintSummarySht 
//  `Print the summary page for each record.

// Modified Object Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.o".bPrint
//  `Made Second print Option to be the Print summary page for listed records

// Modified Form Methods : 
//[PRJ_ProjectDetails];"PRJ_Details.rpt"
//  `Added check if we need to calculate the variables. Used by method PRJ_PrintSummarySht

// Modified Forms : 
//[PRJ_ProjectDetails];"PRJ_Details.rpt"
//  `Added field [PRJ_Contractor]CTR_CompanyName_s.

// ********** ` Modified by: costasmanousakis-(Designer)-(6/19/2007 08:35:47)
// Modified Method(s) : 
//CM_MailInvoiceNotice
//  `Added insertion of Consultant Name in the subject and the body of the message .

// Modified Forms : 
//[Conslt Rating];"View Cslt Rating"
//  `Added "ORANGE" to the lis of the Search by Color/ Apply Color Pulldowns.
// Modified Form Methods : 
//[Conslt Rating];"View Cslt Rating"
//  `Handle the new ORANGE color applied to the records.

// Modified Method(s) : 
//PRJ_LoadBridgeData
//  `For Inspection date get only the one after the Ad Date

// ********** ` Modified by: costasmanousakis-(Designer)-(6/20/2007 09:28:54)
// Modified Method(s) : 
//PRJ_DET_CustomSearch
//  `Add code to sort results by Bridge No

// Modified Object Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.o".bShowAll
//[PRJ_ProjectDetails];"ProjectDetails.o".bShowSubset
//[PRJ_ProjectDetails];"ProjectDetails.o".bQuery
//  `Add code to sort results by Bridge No
//[PRJ_ProjectDetails];"ProjectDetails.o".bOrderBy
//  `Added code to clear the sort buttons.

// ********** ` Modified by: costasmanousakis-(Designer)-(6/25/2007 13:44:17)
// Modified Object Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.i".PRJ_DEProjectFileNo_l
//  `If the entered file number is found, make the proper assignements. 

// ********** ` Modified by: costasmanousakis-(Designer)-(6/26/07 14:11:08)
// Created Method(s) : 
//PRJ_SortByAdDate 
//PRJ_SortByStrPrjMgr
//  `Methods that sort leaving 'blank' entries at the bottom, and doing secondary sort by Bridgenum

// Modified Object Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.o" - sort by ad date button, sort by str prj mgr
//  `use the new PRJ_SortBy...  methods

// ********** ` Modified by: costasmanousakis-(Designer)-(6/27/07 16:13:25)
// Modified Method(s) : 
//CM_PrintCostPlusTransfer_Letter
//  `Fixed error where the revised and original ammounts are reversed. The CM_CalFor_SumAndCost_Letter
//  `method calculates the original ammounts - not the revised ones.
//CM_GetPersonnelData
//  `Fixed offset for getting the extension.
//CM_CalFor_SumAndCost_Letter
//  `Save and then restore the FundTransfer selection

// ********** ` Modified by: costasmanousakis-(Designer)-(7/24/2007 10:31:34)
// Modified Method(s) : 
//ut_PRJSortByBridge
//  `Increment the $Position_l counter to avoid searching from the same element again
//PRJ_NoBridgeFound
//  `Try to get the town name from the bridge number entered.
//PRJ_ControlPageMovement
//  `Make sure city/town is not enterable at the start.
//  `And the Bridge / NonBridge  summary labels.

// ********** ` Modified by: costasmanousakis-(Designer)-(8/8/2007 08:57:32)
// Modified Method(s) : 
//XGetServerGrp
//   `Compress the ActData blob before saving the Act Log Record.
//PRJ_LoadBridgeData
//  `Fix compile error "$InclBins_as:=PRJ_DEBin_s" -> "$InclBins_as{1}:=PRJ_DEBin_s"
//  `Do all Query([inspection]) only if array $InclBins_as has any elements.

// Modified Object Methods : 
//[Bridge Design];"Bridge Design In".cboProjectType
//  `Added code to check for the difference between the list items and the stored values in
//  `Project Type in the on load event. A change was made in adding two spaces around the
//  `"-" in the type description.

// ********** ` Modified by: costasmanousakis-(Designer)-(8/9/2007 14:31:39)
// Modified Method(s) : 
//CheckDependencies
//  `Fixed bug where the "found" recom single posting value was taken
//  `from the [inspections] table and not the [Ratings] table.

// Modified Forms : 
//[Activity Log];"Input"
//  `Re-arranged/re-sized objects on the form for more clarity.

// Created Method(s) : 
//ut_ReLogTemplateRecs
//  ` Re-Create log entries for a selection of records in the [Templates] table.

// ********** ` Modified by: costasmanousakis-(Designer)-(8/15/2007 11:12:09)
// Modified Object Methods : 
//[Dialogs];"ReportTemplateSelect".RptSaveToDisk
//  `Use the "selected list item" command to get which report was selected.

// Created Method(s) : 
//QR_GetProjInfoNo
//  `Function for quick reports to get the projet info number related to the current bridge record.

// ********** ` Modified by: costasmanousakis-(Designer)-(8/16/2007 16:57:10)
// Modified Method(s) : 
//PRJ_BPGM_RelateToBINs
//  `Set tables [PRJ_ProjectDetailsIncludedBINS] [PRJ_ProjectDetails] to read only.

// ********** ` Modified by: costasmanousakis-(Designer)-(8/20/2007 11:10:13)
// Modified Object Methods : 
//[Inspections];"InspectionReview".GetAllDistrInsp
//  ` Use RELATE MANY SELECTION command instead of the previous long query...

// Modified Method(s) : 
//CM_PrintLumpSumTransfer_Letter
//  `Fixed error where the revised and original ammounts are reversed. The CM_CalFor_SumAndCost_Letter
//  `method calculates the original ammounts - not the revised ones.

// ********** ` Modified by: costasmanousakis-(Designer)-(8/20/2007 16:57:58)
// Modified Method(s) : 
//WKHR_InitVars
//  `Added variable WKHR_AllowRevieCmts_b to lock reviewer edits.

// Modified Form Methods : 
//[Work_Estimate];"LineEntry"
//  `Use variable WKHR_AllowRevieCmts_b to lock the reviewer edit boxes.
//[Work_Estimate];"Input"
//  `Define WKHR_AllowRevieCmts_b according to startup conditions

// ********** ` Modified by: costasmanousakis-(Designer)-(8/21/2007 12:16:38)
// Created Method(s) : 
//ut_FixSequence
//  ` Fix an Int/LInt sequence in the [Sequences] table.
//ut_ScanSequences
//  ` Scan all sequences using ut_FixSequence method.

// Modified Forms : 
//[zSpecialReports];"Output"
//  `Assigned keyboard shortcuts to the various buttons except Add, Delete, done.
//  `Assigned new help item to the Add button.
// Modified Form Methods : 
//[zSpecialReports];"Output"
//  `Set the window title at the On Click event
//  `Set the custom Help for the Add button in the Onload event.
// Modified Object Methods : 
//[zSpecialReports];"Output".bAdd
//  `Save the set, and add the new record to it.
//  `If the Shift key is down, make a copy of the first selected record
//  `by saving the values of the selected record and setting a flag.
// Modified Form Methods : 
//[zSpecialReports];"Input"
// `Check for the Copy record flag and if set initialize the stored values
// ` essentially making a copy of a selected record

// ********** ` Modified by: costasmanousakis-(Designer)-(8/22/2007 08:36:18)
// Modified Method(s) : 
//INSP_ExportInspection
//  `Save and then restore the selections of [ElementsSafety] [Standard Photos] [Field Trip]

// ********** ` Modified by: costasmanousakis-(Designer)-(8/22/2007 11:44:13)
// Modified Method(s) : 
//ut_StartMessage
//  `Added ability to use process variable for a folder to save the message files into.

// Created Method(s) : 
//ut_SetMessageDir
//  ` Define the full name of the directory where the files generated by the ut_StartMessage
//  ` method will be created.  If folder does not exist, it will be created.

// Created Method(s) : 
//f_Insp_Revision5
//  ` Verify revision 5 of inspection forms.
//INSP_Item107Desc
//  ` Define the description and size of Item 107 for Inspection reports.
//INSP_Item43Desc
//  ` Define the description and size of Item 43 for Inspection reports.
//INSP_ConvertSKCH
//  ` Convert a sketch or chart to thumbnali for printing to avoid pixelation if not done.
//INSP_PrintSketchChartSingle
//  ` Print a single sketch or chart.
//INSP_PrintSketchChart
//  ` Print the current selection of Sketches or Charts.
//INSP_GetStrTypeBtn
//  ` Update Inspection with struct/deck code from SIA.

// Modified Method(s) : 
//PreviewCurrentPhoto 
// `Added parameter to consolidate methods PreviewCurrentAndNextPhotos PreviewCurrentPhoto 
// `PreviewPreviousAndCurrentPhotos using a CASE statement.
//PrintPreviewImages
//  `Use the new method PreviewCurrentPhoto with a parameter.
//Print_Dive_photos
//  `Use the new INSP_PrintSketchChart method.

// Modified Object Methods : 
//[Inspections];"Routine Form".bGetStrType
//[Inspections];"Critical Member".bGetStrType
//[Inspections];"Culvert Form".bGetStrType
//[Inspections];"Closed Bridge".bGetStrType
//[Inspections];"Damage Form".bGetStrType
//[Inspections];"Routine Combined".bGetStrType
//[Inspections];"Culvert Combined".bGetStrType
//  `Use method INSP_GetStrTypeBtn

// Modified Method(s) : 
//INIT_UI_GV
//  `Added var ◊InspFormRevDate_5:=!09/29/07!

// Modified Form Methods : 
//[Inspections];"Routine Form"
//[Inspections];"Critical Member"
//[Inspections];"Culvert Form"
//[Inspections];"Routine Pr Pg 1"
//[Inspections];"Routine Arch Pr Pg 1"
//[Inspections];"Closed Bridge"
//[Inspections];"Closed Insp Pg1"
//[Inspections];"Damage Form"
//[Inspections];"Routine Combined"
//[Inspections];"Culvert Combined"
//  `Use new methods INSP_Item43Desc  INSP_Item107Desc

// Modified Object Methods : 
//[Inspections];"FC Pr (Pg 1)".vItem43
//[Inspections];"FCPrPg1_v2".vItem43
//  `Cleared Object method - calls moved to method INSP_FCPrPg1_FM

// Modified Object Methods : 
//[Bridge MHD NBIS];"Inspections".vItem107
//[Bridge MHD NBIS];"CombinedInspections".vItem107
//  `Use new method INSP_Item107Desc  

//[Inspections];"FC Pr (Pg 1)".vItem107
//[Inspections];"FCPrPg1_v2".vItem107
//  `Cleared Object method - calls moved to method INSP_FCPrPg1_FM

// Modified Method(s) : 
//CheckDependencies 
//CheckStructureType 
//INSP_CulvertPrPg1_FM 
//INSP_DamagePg1_FM
//  `Use new methods INSP_Item43Desc  INSP_Item107Desc
//INSP_FCPrPg1_FM
//  `Use new methods INSP_Item43Desc  INSP_Item107Desc, moved here from the 
//  `object methods.

// Modified Forms : 
//[Inspections];"Closed Insp Pg1"
//[Inspections];"Culvert Pr Pg 1"
//[Inspections];"CulvertPrPg1_v2"
//[Inspections];"Damage Pg1"
//[Inspections];"DamagePg1_v2"
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"FCPrPg1_v2"
//[Inspections];"Routine Arch Pr Pg 1"
//[Inspections];"Routine Pr Pg 1"
//  `made sure vItem43 is the same in all of them.

// Modified Object Methods : 
//[Inspections];"Routine Form".bGetStrType
//[Inspections];"Critical Member".bGetStrType
//[Inspections];"Culvert Form".bGetStrType
//[Inspections];"Closed Bridge".bGetStrType
//[Inspections];"Damage Form".bGetStrType
//[Inspections];"Routine Combined".bGetStrType
//[Inspections];"Culvert Combined".bGetStrType
//  `Use method INSP_GetStrTypeBtn.

// ********** ` Modified by: costasmanousakis-(Designer)-(8/23/2007 11:23:09)
// Created Method(s) : 
//INSP_Item21Desc 
//INSP_Item22Desc 
//INSP_Item41Desc
//  ` Set and size Items 21,22,41 description on Inspection print forms.

// Modified Form Methods : 
//[Inspections];"Routine Arch Pr Pg 1"
//[Inspections];"Routine Pr Pg 1"
//[Inspections];"Closed Insp Pg1"
//  `Use the   INSP_Item21Desc   `INSP_Item22Desc   `INSP_Item41Desc methods

// Modified Method(s) : 
//INSP_CulvertPrPg1_FM 
//INSP_DamagePg1_FM 
//INSP_FCPrPg1_FM
//  `Use the   INSP_Item21Desc   `INSP_Item22Desc   `INSP_Item41Desc methods

// Created Method(s) : 
//SIA_Item41Desc
//  ` Set variable vItem41 description for general use.

// Modified Object Methods : 
//[Bridge MHD NBIS];"SI & A (Insp)".vItem41
//[Bridge MHD NBIS];"SI & A (Normal)".vItem41
//[Bridge MHD NBIS];"Inspections".vItem41
//[Bridge MHD NBIS];"CombinedInspections".vItem41
//[Conslt Rating];"Rating Print Form".vItem41
//  `Use method SIA_Item41Desc.

// Modified Method(s) : 
//PRJ_ControlPageMovement
//  `Fixed error in Type study case - checking sel in [Sketch palns..] instead of [type]

// Modified Form Methods : 
//[PRJ_TypeStudy];"TypeStudy.i"
//[PRJ_StructuralReview];"ProjectReview.i"
//[PRJ_SketchPlans];"SketchPlans.i"
//  `Added code and variable PRJ_2ndAddSubRecord_b to avoid keep entering new records
//  `after the first time.

// Modified Method(s) : 
//PRJ_FillReviewersDisplay
//  `Cleaned code still using the old PRJ_ReviewersID_al array instead of PRJ_StructReviewersID_al

// ********** ` Modified by: costasmanousakis-(Designer)-(8/24/2007 12:49:11)
// Modified Forms : 
//[Dialogs];"User_Group_List"
//  `Made various additions/changes to the objects, form method.

// ********** ` Modified by: costasmanousakis-(Designer)-(8/28/2007 15:40:56)
// Modified Method(s) : 
//Compiler_PRJ
//  `Added var ◊PRJ_SelectedBIN_txt.

// Modified Form Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.i"
//  `Parse var ◊PRJ_SelectedBIN_txt from the selection of Bridge

// Modified Method(s) : 
//PRJ_ResetBridge
//  `Use var ◊PRJ_SelectedBIN_txt to initialize the BIN
//PRJ_BridgesEntry
//  `Call PRJ_LoadPage2Bins for a singular selection.

// Modified Forms : 
//[Bridge MHD NBIS];"PRJ_Selection.o"
//  `Added the Item8 Category field in the display; Increased form margins; 
//  `Assigned shortcuts to buttons.
// Modified Object Methods : 
//[Bridge MHD NBIS];"PRJ_Selection.o".Button1
//  `Include the BIN in the return variable.
// Modified Form Methods : 
//[Bridge MHD NBIS];"PRJ_Selection.o"
//  `On double click Include the BIN in the return variable.

// Modified Method(s) : 
//INIT_UI_GV
//  `Added vars ◊PRJ_Color_Not_editable, ◊PRJ_Color_Editable.
//  `Implemented those wherever the -(15+(256*12)) or -(15+(256*0)) were refered to.

// ********** ` Modified by: costasmanousakis-(Designer)-(8/29/2007 11:01:50)
// Created Method(s) : 
//LTR_GetLetterDate
//  `Get the date of letter for letters to towns.

// Modified Method(s) : 
//G_WRT_BrInspRpt
//  `Re-did logic to better handle mutiple towns,multiple districts and townline bridges.
//G_WRT_GenericBridgeLetter
//  `Use method LTR_GetLetterDate

// Modified Method(s) : 
//G_RoutinetoBMS
//  `Also handle Culvert inspections 

// Created Method(s) : 
//INSP_InspData2SIA 
//INSP_DiveDates2SIA 
//  `Handle copying data from inspection reports to SIA

// Modified Method(s) : 
//P_ReviewInspcts
//  `Added case for Mark Griffin (DCR) and variable for single approval level.
//G_Insp_ApproveReject 
// `Modified to use the new INSP_InspData2SIA, INSP_DiveDates2SIA methods.
// `Also handle the case of single approval level.

// ********** ` Modified by: costasmanousakis-(Designer)-(8/30/2007 10:56:44)
// Modified Forms : 
//[Dialogs];"MyConfirm"
//  `Added vars vButtonOK_txt,vButtonCancel_txt at the top of the form.
//  `They are used to resize the OK, Cancel buttons because the BEST OBJECT SIZE did not work for the buttons.
//  `Also moved OK and CANCEL buttons to be right-aligned with the text area.
//  `Made min ht of form to 90
// Modified Form Methods : 
//[Dialogs];"MyConfirm"
//  `Coded resizing of buttons to fit specified text. Work similar to the 4D Confirm dialog

// Created Method(s) : 
//ut_importAddress
//ut_GetConsEmail
//  ` Retrieve/Specify the email address for a consultant company.
//ut_GetSysParameter
//  ` Retrieve a parameter from the [Parameters] table, using a default
//  ` if not found.
//PERS_GetMyInfo
//  ` Load Personnel data for the current user

// Modified Method(s) : 
//INIT_UI_GV
//  `Call PERS_GetMyInfo.

// Created Method(s) : 
//WKHR_MailReviewNotice
//  ` Mail a notice of approval or rejection of a work hour proposal

// Modified Method(s) : 
//WKHR_ApprvReject_OM
//  `Call method WKHR_MailReviewNotice.

// Modified Form Methods : 
//[PRJ_TypeStudy];"TypeStudy.i"
//[PRJ_SketchPlans];"SketchPlans.i"
//  `Initialize reviewer to the current struct proj manager.

// ********** ` Modified by: costasmanousakis-(Designer)-(8/31/2007 10:59:36)
// Modified Forms : 
//[Invoice_Maintenance];"Invoice Maintenance In"
//  `Added button "MailNotice"

// Modified Form Methods : 
//[Invoice_Maintenance];"Invoice Maintenance In"
//  `Setup boolean to check if date processed has been modified ;
//  `Hide button  "MailNotice" if date processed is 00/00/00

// Modified Object Methods : 
//[Invoice_Maintenance];"Invoice Maintenance In".DateProcessed
//  `Just set the CM_InvoicePrcDateChg_b to true if changed.
//[Invoice_Maintenance];"Invoice Maintenance In".btnSave
//  `Send notice if CM_InvoicePrcDateChg_b and invoice total > 0; Also prompt user.
//[Invoice_Maintenance];"Invoice Maintenance In".MailNotice
//  `Send notice if invoice total > 0; Also prompt user.

// Modified Forms : 
//[Work_Estimate];"Input"
//  `Changed location/size/alignment of objects on page 1;
//  `Change the label for description to handle addendums.

// Modified Form Methods : 
//[Work_Estimate];"Input"
//  `Added code to define the description;
//  `Better handle saving related Assignment or Addendum records

// Created Method(s) : 
//CM_RelateWorkHour 
//  `Get the related work hour estimate for and assignment or addendum

// Modified Form Methods : 
//[Addendum_Maintenance];"Addendum In"
//[Contract_Assignment_Maintenance];"Assignment Maintenance In"
//  `Use method CM_RelateWorkHour

// Modified Object Methods : 
//[Contract_Assignment_Maintenance];"Assignment Maintenance In".CreateWorkHours
//[Contract_Assignment_Maintenance];"Assignment Maintenance In".ViewWorkHours
//  `Remove the on load code (handled in form on load)
//  `Use method CM_RelateWorkHour

// Modified Forms : 
//[Addendum_Maintenance];"Addendum In"
//  `Added buttons to Create and view work hour estimates

// Modified Method(s) : 
//WKHR_CreateProposal
//  `Handle Work estimates for Addendums; Copy rates from work estimate for assignment

// Modified Method(s) : 
//WKHR_ProposalToAssgn
//WKHR_PAREMOTE_LoadRec
//WKHR_PAREMOTE_Search
//WKHR_PAREMOTE_SetLinks
//WKHR_PAREMOTE_UpdateValues
//WKHR_ProposalToAssignRemote
//  `Handle case when Work estimate is for Addendum 

// Modified Object Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.o".bAdd
//  `Add the new project to the previous list of projects and sort by Bridge number

// **********  ` Modified by: costasmanousakis-(Designer)-(9/7/2007 14:06:16)

// Modified Method(s) : 
//G_Insp_LockFormOnOff
//  `Allow Area Engineers to delete inspections.

// **********  ` Modified by: costasmanousakis-(Designer)-(9/11/2007 12:21:22)

// Modified Object Methods : 
//[Contract_Assignment_Maintenance];"Assignment Maintenance In".Button1 NTPLetter
//  `Added a check for existing or approved fee proposal.

// Modified Method(s) : 
//GetConsltAddress
//  `Added checking of optional parameter for "DESIGN" consultant

//CM_Print_NTP_Letter
//CM_PrintAddenAssignm_Letter 
//CM_PrintRFP_Letter 
//  `Call GetConsltAddress with the "DESIGN" option.

// Modified Method(s) : 
//InitPers
//  `When building the team leaders include area engineers and the bridge inspection engineer

// **********  ` Modified by: costasmanousakis-(Designer)-(9/12/2007 12:12:16)
// Created Method(s) : 
//G_PrintOptions
//  `Handle the setting of print options.

// Modified Object Methods : 
//  `Various object methods where the commands SET PRINT OPTION(orientation | paper option ) were used.
//  `Replaced the calls with call to G_PrintOptions.

// Modified Method(s) : 
//  `Various project methods where the commands SET PRINT OPTION(orientation | paper option ) were used.
//  `Replaced the calls with call to G_PrintOptions.

// Modified Method(s) : 
//LSpawnProcess
//  `Increased the $1, $3 parameters to string(31) from string(25).
//LNextView
//  `Increased the $1 parameter to string(29) from string(25).

// **********  ` Modified by: costasmanousakis-(Designer)-(9/13/2007 16:57:56)
// Created Method(s) : 
//SIA_SearchByTown
//  ` Search by town name for bridges in town and neighboring towns

// Modified Forms : 
//[Dialogs];"ListType"
//  `Added Search by Town option button

// Modified Method(s) : 
//M_LoadBINfile
//  `Added Search by town name capability

// **********  ` Modified by: costasmanousakis-(Designer)-(9/14/2007 12:17:32)
// Modified Method(s) : 
//G_DisplayTable_generic
//  `Added ability to sort on variable number of fields
//P_ListSpecialReports
//  ` Sort the list to 3 fields.

// **********  ` Modified by: costasmanousakis-(Designer)-(9/17/2007 09:14:03)
// Modified Forms : 
//[PERS_Groups];"Input"
//  `Added field [PERS_Groups]PERS_Acting
//[Personnel];"Inspectors In"
//  `Added variables to show how many inspections is the current user a member of.

// Modified Method(s) : 
//F_WRT_ContractAdmin
//  `Find the Contract Admin from the PersGroups table.

// Created Method(s) : 
//TMPL_WRDirectFind
//  `Look for a string or a variable in the current list of templates.  
//  `Will look only in 4D Write templates (WR@)

// Modified Method(s) : 
//PRJ_LoadProjectFileData
//  `Added var to display actual ad date; display blank for 00/00/00 dates

// **********  ` Modified by: costasmanousakis-(Designer)-(9/18/2007 08:36:38)
// Modified Menu(s) : 
//  `Gave names to Menus 6 and 7
//  `Made menu 7 (MaintConsltContrMenu) use the old Edit menu mechanism so that it has the Edit menu

// Modified Method(s) : 
//P_ListTownAddress
//  `Changed the way protections for the table are set. 
//  `Use a case statement to set who has Write access.
//  `Use the width of the output form for the window opened

// Modified Form Methods : 
//[Town Address];"View Town Address"
//  `Hide the add button when table in readonly mode; Close form when Quiting
//[Town Address];"Town Address In"
//  `Set the field colors when table in readonly mode

//P_ListConsAddress
//  `Changed the way protections for the table are set. 
//  `Use a case statement to set who has Write access.
//  `Use the width of the output form for the window opened

// Modified Form Methods : 
//[Conslt Address];"View Conslt Address"
//  `Hide the add button when table in readonly mode; Close form when Quiting
//[Conslt Address];"Conslt Address In"
//  `Set the field colors when table in readonly mode

// Modified Method(s) : 
//P_ListConsRating
//  `Set tables to readwrite only when user in ReadWrite group.
// Modified Forms : 
//[Conslt Rating];"Cslt Rating In"
//  `Added new options to cboAssignmentStatus object and cboConsRatSource
// Modified Form Methods : 
//[Conslt Rating];"Cslt Rating In"
//  `Made changes to load options for cboFillRtgStatus from Table of Lists
// Modified Object Methods : 
//[Conslt Rating];"Cslt Rating In".cboAssignmentStatus
//[Conslt Rating];"Cslt Rating In".NBISLetter
//  `Code rating as Green when marked as completed.

// Modified Forms : 
//[Conslt Rating];"Rating Print Form"
//  `Re-arranged and added variables to print the new options of 
//  `Assignment status and Source.
// Modified Form Methods : 
//[Conslt Rating];"Rating Print Form"
//  `Calculate the new variables of status and Source.

// Modified Object Methods : 
//[Contract Assignments];"Assignments In".btnRetrieveCost
//  `Include consideration for Assign status = "Rejected w/o penalty" in calculation of actual costs.

// **********  ` Modified by: costasmanousakis-(Designer)-(9/28/2007 09:00:53)

// Modified Method(s) : 
//INSP_PrintSIA
//  `Set vars vPgs, vPgf to 0 so that page number does not get printed. Per F.Rastegari

//  `******* Changes to remember what search was made before
// Created Method(s) : 
//SRC_DeclareBrgVars
//  `Declare the process variables used in searching based on bridge bin, bdept
// Modified Method(s) : 
//SRC_SearchByBridge
//  `Use the new method SRC_DeclareBrgVars
// Modified Method(s) : 
//CreateRandomSet
//  `Use the new method SRC_DeclareBrgVars
//  `Also store the type of search in new variable SRC_StartFieldArea_s.
// Modified Form Methods : 
//[Dialogs];"Search Bridge"
//  `Move to the appropriate area based on the variable SRC_StartFieldArea_s.

// **********  ` Modified by: costasmanousakis-(Designer)-(10/1/2007 09:57:51)
// Modified Object Methods : 
//NBISLetter ; cboAssignmentStatus
//  `Fixed compiler error

// Modified Method(s) : 
// Compiler_QuickReport
//  `declare Report_SortList_i

// **********  ` Modified by: costasmanousakis-(Designer)-(10/2/2007 16:21:06)
// Modified Object Methods : 
//[PRJ_ProjectDetails];"BridgeProgram".PRJ_QRDescriptions_atxt
//  `Fixed the call to QR Report to be for table [PRJ_ProjectDetails]

// Modified Method(s) : 
//PRJ_BPGM_ListFromBINs
//PRJ_DisplayBridgePgm
//  `Moved array declarations out of if(not compiled) statement

// **********  ` Modified by: costasmanousakis-(Designer)-(10/3/2007 08:14:22)
// Modified Method(s) : 
//PRJ_BPGM_LoadArrays_2
//  `Added declaration of local arrays and include use of initial inspections from [inspections] table
//  `to determine states of under construction.
//PRJ_BPGM_ListDetailData
//  `Use of initial inspections from [inspections] table
//  `to determine states of under construction.

// **********  ` Modified by: costasmanousakis-(Designer)-(10/5/2007 14:33:47)

// Modified Method(s) : 
//PRJ_BPGM_InitSRCHVars 
//PRJ_BPGM_CreateSearchSet 
//PRJ_BPGM_CleanSearchVars
//  `Added Project File No.

// Modified Forms : 
//[Dialogs];"PRJ_BPGM_Search"
//  `Added Project File No.

// Modified Forms : 
//[Conslt Address];"Conslt Address In"
//  `Added a pulldown to select matching address in [Conslt_Name] table;
//  `Added a button to make the consname field editable;
//  `Display the link id to table [Conslt_Name];

// Modified Table(s) : 
//[AddFund_Maintenance]
//  `Added field [AddFund_Maintenance]FiscalYear : Longint

// Modified Method(s) : 
//CM_PrintAmendment_Letter
//  `Include Fiscal Year.

// Modified Forms : 
//[AddFund_Maintenance];"AddFun In"
//  `Include Fiscal Year.

// **********  ` Modified by: costasmanousakis-(Designer)-(10/9/2007 08:50:51)
// Modified Method(s) : 
//ut_ControlFieldReset
//  `Use open form window for dialog.  Load array aFilesToBeFixed - aFilesToBeSkipped is handled by dialog.

// Created Form(s) : 
//[zDialogs];"ResetDialog"
//  `Missing dialog used in method ut_ControlFieldReset.

// Created Method(s) : 
//RSTDLG_MoveElements_OM
//  `Method used in objects and form method of dialog [zDialogs];"ResetDialog"

// **********  ` Modified by: costasmanousakis-(Designer)-(10/10/2007 13:59:15)
// Modified Method(s) : 
//SQL_ClearArrays 
//SQL_FillBuiltStatements 
//ut_PRJRetrieveConstructionCont
//   ` Added array PRJ_ComplDate_2_atxt to get more recent completion dates from table tblcompletion

// **********  ` Modified by: costasmanousakis-(Designer)-(10/11/2007 15:16:30)
// Created Method(s) : 
//G_GetDataSegments_server
//G_GetDataSegments_Client
//  `Pair of routines to get data segment info from the server to the client

// Modified Method(s) : 
//ut_PRJRetrieveConstructionCont
//  `Go thru all [PRJ_ProjectDetails] recs with PF_FileID>0 to update construction contracts,
//  `not just the ones with [PRJ_ProjectDetails]CP_ConstructionProjectID_l = 0;
//  `Also in case of multiple contracts use only contracts with a contract number

// **********  ` Modified by: root-(Designer)-(10/16/2007 15:23:57)
// Modified Forms : 
//[PRJ_ProjectDetails];"ProjectDetails.o"
//  `Adjusted width of str proj mgr

// Modified Form Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.o"
//  `Fixed the On activate event to resize the window to the form width.