//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(6/20/08 14:36:13)
// Modified Object Methods : 
//[PRJ_ReportData];"ReportData.i".Button1
//  `Fix bug with date button not updateing correct field

// **********  ` Modified by: costasmanousakis-(Designer)-(6/23/08 13:03:38)
// Modified Method(s) : 
//ut_PRJImportData
//  `(remove quotes from Status, last action, bdept inputs
//PRJ_WRT_ProjectLetters
//  `Added Proj Manager to the cc list
//PRJ_LTR_RevwCmmt_fill
//  `Added bridge no, town, received date
//GetConsltAddress1
//  `Made an adjustment in the contact name to avoid ", ,"

// Created Method(s) : 
//F_GetCityOrTown
//  ` Return whether "Townname" is a City or Town

// Modified Object Methods : 
//[Dialogs];"ut_Request".ut_request_choises
//   `Allow adding of selected value to the request value.

// **********  ` Modified by: costasmanousakis-(Designer)-(6/25/08 10:17:26)
// Modified Forms : 
//[Invoice_Maintenance];"Invoice Maintenance In"
//  `Added checkbox to indicate payment of retainage. (retainage is marked negative)
// Modified Form Methods : 
//[Invoice_Maintenance];"Invoice Maintenance In"
//  `Added code to initialize the form when a retainage has been paid
// Modified Object Methods : 
//[Invoice_Maintenance];"Invoice Maintenance In".btnSave
//[Invoice_Maintenance];"Invoice Maintenance In".MailNotif
//  `Consider also if retainage os being paid when deciding whether to mail notification

// Modified Method(s) : 
//CM_UpdateInvoiceTotals
//  `Add the case if a retainage (<0) is being paid.
//CM_MailInvoiceNotice
//  ` if a retainage is being paid (<0) do not include TLFDEs , constr, dates of service, print abs value of retainage.

// **********  ` Modified by: costasmanousakis-(Designer)-(6/25/08 11:36:04)
// Modified Method(s) : 
//ut_UpgradeBINGroups
//  `assign new bins each to a different group.

// **********  ` Modified by: costasmanousakis-(Designer)-(6/25/08 12:06:18)
// Created Table(s) : 
//[PRJ_ProjectDetailsIncludedBINS]PDB_Date_d
//[PRJ_ProjectDetailsIncludedBINS]PDB_GroupNumber_l

// Modified Forms : 
//[PRJ_ProjectDetailsIncludedBINS];"UserList.o"
//  `Added the Group number field

// Created Form(s) : 
//[Bridge MHD NBIS];"AssignReplacement.dlg"
//[PRJ_ProjectDetailsIncludedBINS];"BinSelectionNoNew.dlg"
//[PRJ_ProjectDetailsIncludedBINS];"BinSelectionwithNew.dlg"

// Modified Method(s) : 
//PRJ_FillOldandNewBinArrays
//PRJ_MoveSelectedArray
//PRJ_ProcessAvailable
//PRJ_ProcessExisting
//PRJ_ProcessUnassigned
//Compiler_PRJ

// Created Method(s) : 
//PRJ_SetUpAvailableBins 
//PRJ_SetUpUnasssignedBins
//PRJ_PopulateForAssignReplacemen

//M_NEW_BIN
//  `Add new record to the current list- apply any sort

// Modified Object Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.i".Button1
//  `modifications for new groups 

// **********  ` Modified by: costasmanousakis-(Designer)-(6/26/08 13:01:58)
// Modified Method(s) : 
//ut_UpgradeBINGroups
//  `Added code to set to New records that are DES or have corresponding "REM" records

// **********  ` Modified by: costasmanousakis-(Designer)-(6/30/08 10:02:11)
// Modified Form Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.i"
//  `On Unload mark the record we were in so that it gets highlighted on the output fo  `rm.
//  `Added field RPJ_status on Project data page
//[PRJ_ProjectDetails];"ProjectDetails.o"
//  `Higlight the last record we were in as set in [PRJ_ProjectDetails];"ProjectDetails.i"
// Modified Object Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.o".bAdd
//  `Added a redraw window at the end

// Created Form(s) : 
//  `[PRJ_ProjectDetails];"NewBDEPTSelection.o"

// Modified Method(s) : 
//PRJ_SetAccessPage_2
//  `for Access allowed enable the PRJ_BridgeSection_atxt button

// **********  ` Modified by: costasmanousakis-(Designer)-(7/31/08 15:55:17)
//  `To fix run time error in compiled app.
//P_ListTownAddress
//  `Declare the aDistrictSelect array here instead of in the output form load event.
// Modified Object Methods : 
//[Town Address];"View Town Address".aDistrictSelect
//  `Declare the aDistrictSelect array in P_ListTownAddress instead of in the load event

// Modified Method(s) : 
//CM_UpdateInvoiceTotals
//  `Added declaration of $i,$j,$k
//  `Added code to check if the retainage has been paid on a previous invoice
//  `(find a minus retainage in the invoices) then don't subtract retainage from this invoice

// Modified Forms : 
//[Invoice_Maintenance];"Invoice Maintenance In"
//  `Increase ht of dollar variables, increased vert margin to 20

// **********  ` Modified by: costasmanousakis-(Designer)-(8/1/08 14:57:31)
// Modified Method(s) : 
//CM_UpdateInvoiceTotals
//  `(fixed logic error in yesterday changes

// Modified Forms : 
//[Work_Estimate];"Print3"
//  `adjusted form objects size,location, and some markers
// Modified Form Methods : 
//[Work_Estimate];"Print3"
//  ` added code to color lines according to content...
//  `adjusted the resizing of sub-items - indented them by 6 pixels.

// Modified Object Methods : 
//[Work_Estimate];"Input".WKHR_PageTitles
//  `bug fix of declaration of WKHR_ShowRevTotals_B

// Modified Method(s) : 
//WKHR_Input_GotoPage
//  `bug fix of declaration of WKHR_ShowRevTotals_B

// **********  ` Modified by: costasmanousakis-(Designer)-(8/5/08 09:29:11)
// Modified Method(s) : 
//ut_FixSequence
//  `Added check for multiple same name sequences

//M_SearchDefElement
//  ` chgd search win type and title; Changed wording of printing prompt 
//INSP_ElmSft_Inc_FM
//  `use method INSP_ElmtSfty_ItemNo

// Created Method(s) : 
//INSP_ElmtSfty_ItemNo
//  ` Get the Item no var for the elements safety

// Modified Method(s) : 
//G_PickFromList
//  `Added logic to add a window title; changed method of opening the window

// Modified Form Methods : 
//[Inspections];"Dive Special Pr Pg 1"
//[Inspections];"SpecialExtra"
//[ElementsSafety]"ElmtsSftyIncDive"
//[ElementsSafety]"ElmtsSftyIncDiveS"
//[ElementsSafety]"Rpt DefElem "

//  `Use method INSP_ElmtSfty_ItemNo

// Modified Method(s) : 
//G_Insp_ElmtArray_setup
//  `Use method INSP_ElmtSfty_ItemNo instead of a selection to array lookup
//INSP_DamagePg1_FM
//  `Use method INSP_ElmtSfty_ItemNo

// Created Method(s) : 
//DEFELMTSRC_Export
//  ` Control method to export ElementsSafety records from the search for deficient elements

// **********  ` Modified by: costasmanousakis-(Designer)-(8/6/08 12:29:53)
// Modified Method(s) : 
//M_DeficientElementRpt
//  `vItemNo and vElemdecs are calculated in the print detail
//  `changes to minimize print pages by printing as many bridges in one page.
//  `Don't sort bridges any more, they will be sorted before we run this method

// Modified Forms : 
//[ElementsSafety];"Rpt DefElem"
// Modified Form Methods : 
//[ElementsSafety];"Rpt DefElem"
//  `use method INSP_ElmtSfty_ItemNo and GetElmtNumber
//  `Modified Form to add the element comments as a text variable,
//  `added a new header section, adjusted the size to fit more on a page.
//  `Modified / added to the form method to handle the printing of the element comments and
//  `reduce page usage by printing more than one bridge per page.

// **********  ` Modified by: costasmanousakis-(Designer)-(8/7/08 09:38:49)
// Created Method(s) : 
//FN_AtWordBoundary
//  ` Determine whether we are at a word boundary.

// Modified Forms : 
//[ElementsSafety];"Rpt DefElem"
// Modified Form Methods : 
//[ElementsSafety];"Rpt DefElem"
//  `Modified form to use a rectangle to surround the comments instead of a border around the text block.
//  `Added code to adjust the size of the new rectangle
//  `Added code to split the comments text at a word boundary.


//Mods_2008_CM_5404 ("OTHERQUICKREPORT")
// Created Method(s) : 
//SIA_CustomQRBtn_OM
//  ` Method for a Quick report button that allows a choise for the
//  ` Master Table to be used from the NBI Stack info list form.
//CM_CustomQRBtn_OM
//  ` Method for a Quick report button that allows a choise for the
//  ` Master Table of the quick report in Contract_Maintenance
// Modified Forms : 
//[Contract_Maintenance];"Contract Maintenance Out"
//  `Added button "CustomQR"
//[Bridge MHD NBIS];"NBIS Stack Info"
//  `Added button "CustomQR"
//END OF Mods_2008_CM_5404 ("OTHERQUICKREPORT")

// Modified Method(s) : 
//GetDBIEinfo
//  `Get the DBIE phone from the personnel record as a check;
//  `Set the personnel table on read only

// **********  ` Modified by: costasmanousakis-(Designer)-(8/11/08 10:20:59)
//------ Various Changes
// Modified Method(s) : 
//ReSendLogEntries
//ut_LoadBridgeDesRecs 
//INSP_UPDATE_InspChildren
//  `use method X_CleanIDResTable
//------ END of Various Changes

// -------- INSPDWNLD Changes

// Created Method(s) : 
//INSP_DWNLD_Task
//  ` Preform various tasks during the download of inspections from remote server.

//INSP_PrepareDWNLD 
//  ` Prepare the for the download/update of a local inspection
//  ` from the remote server. The [Inspections] record must be loaded already.
//X_CheckRemoteLog 
//  ` Check the remote act log

// Modified Method(s) : 
//INSP_UPDATE_Combined 
//  `Fix code error in (($ErrCode_L=0) & (vRecsFound=1))
//INSP_UPDATE_PontisRec 
//  `Added ErrCode when not finding the remote ponits rec
//INSP_UpdateLocalInspFromRemote 
//  `Added a message when Done..
//  `Added INSP_UPDATE_ReLink_b..
//INSP_UpdateInspection 
//  `clean up some code
//  `Added INSP_UPDATE_ReLink_b..
//INSP_DeleteLocalInsp 
//  `1-Any deletion log entries do not get transfered back to the server.
//  `2-Added calls to clear the [FileIDRes table] from entries related to the inspection 
//  `being deleted. This method is called when downloading inspections from the server
//  `and  a local inspection is being replaced by the one on the server.  New [FileIDRes] entries
//  `will be generated when the server inspection gets copied down to the local DB.
//INSP_DWNLD_PontisRec 
//INSP_DownLoadInsp 
//INSP_DWNLD_InspRec 
//INSP_DWNLD_Images 
//INSP_DWNLD_ElmtsSfty 
//INSP_DWNLD_CUs 
//  `Clean the FileID Res table
//INSP_OP_ErrorCheck 
//  `Added custom err codes, so there are no double messages

//INSP_DownloadMissing 
//  `Testing for Designer to use the INSP_UpdateLocalInspFromRemote method instead of
//  `deleting the local inspection and then downloading the remote inspection.
//  `Also when testing for pending incoming changes, check only for inspection related records.

// -------- END of INSPDWNLD Changes

// **********  ` Modified by: costasmanousakis-(Designer)-(8/12/08 08:59:04)
//------ MODS TO PREPARE FOR 2004 conversion
// Modified Forms : 
//[Inspections];"Closed Bridge"
//[Inspections];"Critical Member"
//[Inspections];"Culvert Combined"
//[Inspections];"Damage Form"
//[Inspections];"Dive Form"
//[Inspections];"Dive LowCl"
//[Inspections];"Routine Combined"
//[Inspections];"Underwater Special Member"
//  ` Resized tabs by 5 points, moved all objects in all pages by 5 points down.

// **********  ` Modified by: costasmanousakis-(Designer)-(8/13/08 12:16:17)
// Modified Method(s) : 
//INSP_SortbyBDEPT
//  `Removed the call to SHORT_MESSAGE for more than 500 records.
//  `in preparation for 2004 conversion

// **********  ` Modified by: costasmanousakis-(Designer)-(8/14/08 16:25:42)
// Modified Method(s) : 
//G_GenRemarksArea 
//G_ElmtRemarksArea 
//G_OrientationTxtArea
//  `Added optional second parameter to pass the form event.

// **********  ` Modified by: costasmanousakis-(Designer)-(8/15/08 14:42:44)
// Modified Method(s) : 
//fGetFormEvent
//  `Added optional parameter
//  ` $1 : $FormEvent_L

// **********  ` Modified by: costasmanousakis-(Designer)-(8/20/08 08:20:55)
// Created Method(s) : 
//INSP_UpdateInspList
//  ` Update / get the current list of inspections for the current BIN.

// Modified Method(s) : 
//ADD_COMBINED_INSPECT
//INSP_DownloadMissing
//  `Use Method INSP_UpdateInspList
// Modified Form Methods : 
//[Bridge MHD NBIS];"CombinedInspections"
//  `Use method INSP_UpdateInspList
// Modified Object Methods : 
//[Bridge MHD NBIS];"CombinedInspections".bOpenInsp
//  `Removed IF(False) encased code, case statement for input form, use method INSP_UpdateInspList
//[Bridge MHD NBIS];"CombinedInspections".bDuplicate
//[Bridge MHD NBIS];"CombinedInspections".ChgInspTypeBtn
//[Bridge MHD NBIS];"CombinedInspections".ImportBtn
//  `Use method INSP_UpdateInspList

// **********  ` Modified by: costasmanousakis-(Designer)-(8/21/08 09:20:50)
// Modified Method(s) : 
//G_SpellCheckArea
//  `Fixed coding; adjusted where selection is left at the end of routine.

// **********  ` Modified by: costasmanousakis-(Designer)-(8/22/08 09:35:09)
// Created Method(s) : 
//PERS_ChangeEmployerName
//  ` Change the current employer name and adjusts them lists in the structure
// Modified Forms : 
//[Personnel];"Inspectors Out"
//  `Added PersTools_atxt object

// **********  ` Modified by: costasmanousakis-(Designer)-(8/27/08 09:31:57)
// Created Method(s) : 
//QR_MinElementValue
//  ` Search for the minimum element value of the recently approved inspections.

// **********  ` Modified by: costasmanousakis-(Designer)-(9/2/08 14:47:32)
// Modified Method(s) : 
//M_LoadSet
//  `Added sorting...

// **********  ` Modified by: costasmanousakis-(Designer)-(9/3/08 08:28:20)
// Created Method(s) : 
//UT_SET_Control 
//  ` Perform Set operations on the current list.

// Modified Method(s) : 
//M_SaveSet 
//M_LoadSet 
//M_AddSet 
//M_SubtractSet
//  `Use the new method UT_SET_Control

// **********  ` Modified by: costasmanousakis-(Designer)-(9/5/08 08:10:21)
// Created Method(s) : 
//WRUTIL_Function
//  ` Perform various functions in a 4D Write area
//INSP_4DWRITE_SaveToFld
//  ` Save a 4D Write area to a field doing some processing
//INSP_Comments_OM
//  ` Object method for the comments 4D Write area

// Modified Method(s) : 
//G_GenRemarksArea
//G_OrientationTxtArea
//  `Use method INSP_Comments_OM
//G_ElmtRemarksArea
//  `Use INSP_4DWRITE_SaveToFld

// Created Method(s) : 
//OP_LoadRecord
//  `Load a remote record in 4D Open
//OP_TestForBackup
//  `Test if the remote server is executing a backup

//QR_Itm22_Sta_Loc
//  `Return "State"| "Local" based on Item 22 or "1" | "2" if a number is requested
//QR_Itm26_Category
//  `Return a general descr of the Func Class category or  a number based on item 26
//  ` Interstate, (1), Arterial (2), Collector (3), Local (4)

// **********  ` Modified by: costasmanousakis-(Designer)-(9/10/08 08:57:35)
// Created Method(s) : 
//MATH_ArabicToRoman

// Modified Method(s) : 
//Init_Fields_DES1
//  `Use new method MATH_ArabicToRoman
//SIA_Feature_OM
//  `Fixed a bug in compiled where the case of I, ST, and US was not handled properly
//  `causing runtime errors

// Created Method(s) : 
//LoadNBIData
//  ` Parse a text line to NBI data items. The text should be a record line
//  ` formatted the same as the NBI submission tape. Will update the 
//  ` current record with the values extracted from the 'tape record'.
//  ` Can do either a Primary or Secondary record.

// Modified Method(s) : 
//ImportFEDrecord_Item8
//  `Modified code to use new method LoadNBIData. Also modified to create new records
//  `when they are not found, either primary or secondary.  This is mainly to be used to
//  `re-import into a blank DB data from a Fed sumbission. It will only add records to a blank DB.
//  `Also added a Flsuh Buffers command at a 40 count interval.

// Created Method(s) : 
//ut_ExportImportAuxTables
//  ` Export or import Auxiliary tables used to load pulldown menus
//  ` invarious parts of the application. Can be used to unload from the main
//  ` DB the needed info and then load it to a new blank db.

// **********  ` Modified by: costasmanousakis-(Designer)-(9/11/08 14:52:47)
// Modified Method(s) : 
//M_MasterList
//  `Use Set Print Option commands instead of PageSetup

// **********  ` Modified by: costasmanousakis-(Designer)-(9/15/08 15:27:34)
//*** IMAGESTORE ***
// Modified Method(s) : 
//INSP_ConvertSKCH
//  `Change the logic to include windows printing of Mac originated images
// Modified Object Methods : 
//[Standard Photos];"Standard Photos".Std Photo
//[Standard Photos];"Standard Photos".vRdPic2Blob
//  `Don't compress the image after it is loaded.

// **********  ` Modified by: costasmanousakis-(Designer)-(9/16/08 09:23:17)
// Modified Method(s) : 
//GetBIEinfo
//  `Fixed missing space after the middle name

// **********  ` Modified by: costasmanousakis-(Designer)-(9/23/08 09:15:04)
//Mods_2008_CM_5404 ("SELECTLIST")
// Modified Method(s) : 
//ut_executeMethod
//  `Save the last method / command in  a global var.

//TEMP_UpdSelList
//  `Adjust to receive the download from the FHWA UPACS site. Receive the Current Year Select List report.
//  `Will use the column Fed Agency. Will not use the BIN as a last check
//  `Columns needed are : Fed Agency (Y/N column), Item 8, Sufficiency rating
//  `Also enhanced the case of locked records. Will give a chance to keep trying to update the
//  `locked records, and if cancel will write the unchanged item8s with what they're supposed to be.
//  `Open the input file in Read mode.
//  `The report file now gets a timestamp in the name.
//  `Add some progress messages.
//  `At the end unload records and clear selection.
// END OF Mods_2008_CM_5404 ("SELECTLIST")

//Mods_2008_CM_5404 ("HOMEFOLDER")
// Created Method(s) : 
//ut_GetUserHomeFolder
//  ` Return the 'Home' for the current user. Finds a standard system/user 
//  ` folder and subtracts what's needed to get to the home root.

// **********  ` Modified by: costasmanousakis-(Designer)-(9/25/08 10:48:03)
//Mods_2008_CM_5404 ("HLISTSELECT")
// Created Method(s) : 
//TMPL_HListOnSelect
//  ` Custom method to act on the selection of an item in the
//  ` HList displayed on form [Dialogs];"ReportTemplateSelect"

// Modified Method(s) : 
//ut_ArrayToHL
//  `Added capacity to create sublists based on whether the item desc
//  `is in the format "Desc (Category)"
//TMPL_Do_Template_Choise
//  `Use new method TMPL_HListOnSelect to find the selected item.

// Modified Form Methods : 
//[Dialogs];"ReportTemplateSelect"
//  `Use new method TMPL_HListOnSelect to act on the selected item.

// Modified Object Methods : 
//[Dialogs];"ReportTemplateSelect".aHL_ReportTemplates
//  `Use new method TMPL_HListOnSelect to act on the selected item.

//END OF  Mods_2008_CM_5404 ("HLISTSELECT")

//Mods_2008_CM_5404 ("DESIGNMODS")
// Modified Method(s) : 
//InitProcessVar
//  `Use ◊aFeatDescr,... global vars for aFeatDescr_,IDaFeatDescr_,BINaFeatDescr_ process vars

//Init_Fields_DES1
//  `Stop creating global arrays ◊IDaFeatDescr,.. and ◊BINaFeatDescr,..  they are the same as the 
//  `◊aFeatDescr,.. arrays

// Created Method(s) : 
//INIT_FIELDS_ARRAYS
//  ` Declare global arrays used in method Init_Fields_DES.
//  ` Added comments to show matching process arrays. 

// Modified Method(s) : 
//ut_RetrieveBlobDocument 
//INIT_FIELDS_DES
//  `Use method INIT_FIELDS_ARRAYS for consistancy.

// **********  ` Modified by: costasmanousakis-(Designer)-(10/1/08 09:20:08)
//Changes to allow for two digit code in item 31- design load - so that the new LRFD loads can be designated
// Modified Method(s) : 
//INIT_FIELDS_ARRAYS 
//  `Changed size of ◊aDesLoadCod to A(2)
//InitProcessVar 
//  `Changed size of aItem31 to A(2)
//ut_CompareStoredBlobData
//  `Changed size of TEMP_A_DesLoadCod to A(2)

// **********  ` Modified by: costasmanousakis-(Designer)-(10/2/08 16:52:07)
// Modified Method(s) : 
//Duplicate_Inspection
//  `Don't clear the [Inspections]Agency; it is set in the call to G_SIA2Inspection

// **********  ` Modified by: costasmanousakis-(Designer)-(10/3/08 10:00:48)
//Mods_2008_CM_5404 ("DESIGNMODS") - continued
// Created Method(s) : 
//MHDDB_LookupCode_OM 
//  `Method that handles the object method called from the keyfields oninput forms in lookup tables
//  `such as Design Load, Design, 
//MHDDB_LookupTbl_FM 
//  `Method that handles the form method called from input forms in lookup tables
//  `such as Design Load, Design, 

// Modified Form Methods : 
//[Design Load];"Input"
//  `Added the method
// Modified Object Methods : 
//[Design Load];"Input".Code
//[Design Load];"Input".Description
//  `Added the method

// Created Method(s) : 
//DESLOAD_GeneralMethod
//  ` Method that contains modules used in the [Design Load]"Translation" form interface

// Modified Forms : 
//[Design Load];"Output"
//  `Added buttons to launch the translation table management, and to close the output form.
//  `moved the footer marker to accomodate the new buttons.

// Created Method(s) : 
//ut_TextToArray 
//  ` Translate a text variable delimited by a character to an array.
// Modified Method(s) : 
//ut_GetSysParameter
//  `Added the third optional parameter to read either the Description or the Value field

// Created Form(s) : 
//[Design Load];"Translation"
//  `Form to handle the translation of MHD Design load codes to FHWA codes.
//  `Will manage two stored parameters SIA_DESLOADCODE_MHD and
//  `SIA_DESLOADCODE_FHWA that hold the translation table and two global arrays
//  `◊MHDItm31Codes_atxt and ◊FHWAItm31Codes_atxt.

// Created Method(s) : 
//SIA_DesignLoadTrans
//  ` Translate MHD to FHWA codings for Item 31

// Modified Method(s) : 
//INIT_UI_GV
//  `Added arrays ◊MHDItm31Codes_atxt and ◊FHWAItm31Codes_atxt

// END OF Mods_2008_CM_5404("DESIGNMODS")

// **********  ` Modified by: costasmanousakis-(Designer)-(10/3/08 11:49:08)
// Modified Method(s) : 
//INSP_ConvertSKCH
//  `Temporarily don't do any translation on windows machines - it seems to crash the clients

//Mods_2008_CM_5404 ("MASSEDITSTRPRJ")
// Modified Method(s) : 
//ut_PRJApplyMassEdits
//  `Enable mass editing of the Structural Project Manager

// Modified Form Methods : 
//[PRJ_ProjectDetails];"Massedit.i"
// Modified Object Methods : 
//[PRJ_ProjectDetails];"Massedit.i".PRJ_SelectField_atxt
//[PRJ_ProjectDetails];"Massedit.i".PRJ_SelectionDD_atxt
//  `Enable mass editing of the Structural Project Manager

// **********  ` Modified by: costasmanousakis-(Designer)-(10/6/08 11:17:48)
// Modified Form Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.i"
//[PRJ_ProjectDetails];"ProjectDetails.o"
//  `Change set name PRJLASTRECORDIN to $PRJLASTRECORDIN (local set)
//  `with the process set the highlighting last record did not work in client-server enviroment

// **********  ` Modified by: costasmanousakis-(Designer)-(10/7/08 09:38:04)
// Modified Method(s) : 
//ut_RetrieveTableArrDoc
//  `Check the number of tables in the stored file does is less than the actual number. 


//``````Mods_2008_CM_5404("ACCESS")
//modifications made to enable read only access to most of the data. Prompted by request
//from S. Eslinger to have read access to all data.

// Modified Form Methods : 
//[Personnel];"Inspectors In"
//  `lock form for ReadOnly users
//[Personnel];"Inspectors Out"
//  `Hide Add btn for ReadOnly users
//[Bridge Design];"Bridge Design In"
//  `lock form for ReadOnly users
//[Contracts];"Contracts Out"
//  `Create var InspRtgContrAccess_b to control RO access - hide Add fro RO users
//[Contracts];"Contracts In"
//  `lock form using InspRtgContrAccess_b
//[Contract FundTransfer];"TransferFund In"
//[Contract AddFund];"AddFund In"
//[Contract ExtendTime];"ExtTime In"
//[Contract Assignments];"Assignments In"
//[Contract Invoice];"ContractInvoice In"
//[Contract Invoice AssignNo];"Invoice"
//  `lock form using InspRtgContrAccess_b
//[Contract_Maintenance];"Contract Maintenance Out"
//  `hide Add fro RO users
//[Contract_Maintenance];"Contract Maintenance In"
//  `Create var CM_ViewOnly_b to control RO access - lock form fro RO users
//[Invoice_AssignNo_Maintenance];"Input"
//[Invoice_Maintenance];"Invoice Maintenance In"
//[FundTransfer_Maintenance];"TransferFund In"
//[ExtendTime_Maintenance];"ExtTime In"
//[AddFund_Maintenance];"AddFun In"
//[Contract_Project_Maintenance];"Project Maintenance In"
//[Contract_Assignment_Maintenance];"Assignment Maintenance In"
//[Addendum_Maintenance];"Addendum In"
//[CM_ExtTimeFYAlloc];"Include"
//  `lock form using CM_ViewOnly_b

//[PRJ_ReportData];"ReportData.i"
//[PRJ_TypeStudy];"TypeStudy.i"
//[PRJ_SketchPlans];"SketchPlans.i"
//[PRJ_StructuralReview];"ProjectReview.i"
//[PRJ_ProjectTimeTracking];"ProjectTimeTracking.i"
//  `Access was OK, just included the bDelete button in the enabling/disabling statements

//[PRJ_DesignContracts];"Input"
//  `lock form for RO users
//[PRJ_DesignContracts];"Output"
//  `Disable/Hde the add and delete buttons for RO users
// Modified Method(s) : 
//PRJ_DC_OpenProjectDetail 
//  `Act on the double-click only if user is NOT an RO user

//PRJ_LoadDropDownLists
//  `Modified the PRJ_BridgeSection_atxt array values to match the names in the Personnel groups tables.
//ControlMenuBar
//  `Delete scour report item in Reports menu for Non-Inspection Admin users

// Modified Method(s) : 
//PRJ_ReturnAccessAllowed
//  `removed option to allow users belonging to the responsible section to have write access to the project.
//  `causes conflict with projects where there is no responsible section

// **********  ` Modified by: costasmanousakis-(Designer)-(10/9/08 11:31:59)
// Modified Table(s) : 
//[PERS_Groups]
//  ` changed field [PERS_Groups]PERS_Acting to integer, added field [PERS_Groups]PERS_Primary

// Modified Forms : 
//[PRJ_ProjectDetails];"ProjectDetails.o"
//  `Cosmetic : Added a hor line above the footer, extended the vertical lines to the new horiz line.

// **********  ` Modified by: costasmanousakis-(Designer)-(10/15/08 13:13:06)
// Modified Method(s) : 
//SIA_CustomQRBtn_OM
//  `Added the inventory photo inspection and photo tables.

// Created Method(s) : 
//ut_ExportABPBridgePhotos
//  ` utility to export to a folder elevation photos for ABP bridges.
//  ` 1-Will read a file containing pairs of ProjectFile_no and BDEPT
//  ` 2-Find inventory photo inspections for these bridges
//  ` 3-Assemble the latest inv photo inspection
//  ` 4-get the related Elevation photos
//  ` 5- Save them to a pre-determined folder using
//  `  ` "PFileNo-BDEPT-PhotoDesc.JPG"

// **********  ` Modified by: costasmanousakis-(Designer)-(10/28/08 16:47:40)
//Mods_2008_CM_5404 ("ContrAssgn")
// Modified Method(s) : 
//M_ContractRpt_Assignment2
//  `Remember the current selection of Contract assignments. 

// **********  ` Modified by: costasmanousakis-(Designer)-(10/31/08 10:11:45)
// Created Method(s) : 
//QR_RPCNames
//  ` Return the RPC names for the current Bridge record.

// Modified Method(s) : 
//INSP_4DWRITE_SaveToFld
//  `Fixed bug that did not get the 3rd parameter - the stack level


// **********  ` Modified by: costasmanousakis-(Designer)-(11/4/08 15:12:10)
// Created Method(s) : 
//QR_PNFInfo 
//  ` Return info needed for PNF Forms for bridge information

//QR_Item113
//  ` Return the description for Item113

// Modified Forms : 
//[Bridge MHD NBIS];"SI & A Input"
//  `Added button bPNFbtn on page 0 to copy the PNF Info to the clipboard

// **********  ` Modified by: costasmanousakis-(Designer)-(11/10/08 11:04:12)
// Created Method(s) : 
//CIR_GetRates
//  ` Retrieve the OverHead and NetFee Rates for
//  ` Consultant inspection, rating assignements.
//  ` Stores them in the process variables netFeeRate;overheadRate

// Modified Form Methods : 
//[Conslt Rating];"Cslt Rating In"
//[Cons Inspection];"Cslt Insp In"
//  `Use method CIR_GetRates

// Created Method(s) : 
//CIR_AssgnValues_OM
//  ` Calculate the values in the current contract assignment record based on
//  ` the field changed

// Modified Object Methods : 
//[Contract Assignments];"Assignments In". all objects for EST_ @ or Actual_@ fields
//  ` to use the new `CIR_AssgnValues_OM method
// Modified Forms : 
//[Contract Assignments];"Assignments In"
//  `Added lock button to allow editing of the rates.
// Modified Form Methods : 
//[Contract Assignments];"Assignments In"
//  `Initialize the rates from the contracts record

// **********  ` Modified by: costasmanousakis-(Designer)-(11/14/08 13:38:05)
// Modified Method(s) : 
//f_TrimStr
//  `Added LineFeed to the trim characters

//ut_PRJRetrieveProjectFileData
//  `Remove CharRets, LineFeeds, Tabs from description and trim it  

// Modified Form Methods : 
//[Contract_Assignment_Maintenance];"Assignment Maintenance In"
//  `Reload the list of projoects on the close detail event on page 2`

//CM_SetupRelated 
//  `Clear the selection of [Contract_Project_Maintenance] if there are no [Contract_Assignment_Maintenance]


// **********  ` Modified by: costasmanousakis-(Designer)-(12/1/08 16:52:47)
// Created Method(s) : 
//ut_RetrieveAllBridgeContracts
//  `Retrieve info about all contracts related to bridges from the [Contracts] , [Contract_Maintenance]
//  `and [PRJ_DesignContracts] tables. compile it into arrays, and stuff the arrays in a blob.

//ut_ExportAllBridgeContracts
//  `Export the contract info from ut_RetrieveAllBridgeContracts to a tab delim text file

// **********  ` Modified by: costasmanousakis-(Designer)-(12/5/08 08:41:55)
// Modified Method(s) : 
//M_SetItem75
//SET_Item75
//  `Added code to export various values to a tab delim text file.

// **********  ` Modified by: costasmanousakis-(Designer)-(12/9/08 09:11:44)
// Created Method(s) : 
//GetUOEInfo
//  `Retrieve information for the Underwater operations eng.
//M_WRT_DiveInspDHD_TRAN
//  `Generate the transmittal letter of Dive reports to the DHD, or the DBIE
// Modified Method(s) : 
//GetDHDinfo
//  `Added vDistrictNo_txt variable

// **********  ` Modified by: costasmanousakis-(Designer)-(12/16/08 09:11:44)
//Mods_2008_CM_5404 ("PRJDESRTRV")
// Modified Method(s) : 
//ut_PRJRetrieveDesignContracts 
//SQL_FillBuiltStatements 
//SQL_ClearArrays 
//  `Made modifications and additions to accomodate new  added fields in table [PRJ_DesignContracts]
//  `Adjusted the logic in the handling of the consultant name and ID

// **********  ` Modified by: costasmanousakis-(Designer)-(12/18/08 09:05:02)
//Mods_2008_CM_5404 ("PRESERVRETAIN")
// Modified Object Methods : 
//[Invoice_Maintenance];"Invoice Maintenance In".DERetainage
//  `Fixed Assignment Entries prompt;
//  `Changed code to calcultate the retainage based on the previous invoices.

//Mods_2008_CM_5404 ("COMMON")
// Created Method(s) : 
//QR_ScourCategory
//  ` Get the max scour priority ranking for a given BDEPT

// **********  ` Modified by: costasmanousakis-(Designer)-(1/8/09 12:23:21)
// Created Method(s) : 
//PRJ_SaveSet 
//PRJ_LoadSet 
//PRJ_AddSet 
//PRJ_SubtractSet
//  `Methods to handle disk sets for ProjectDetails table.

//Added above Items to the Search menu in the ProjectDetail menu.