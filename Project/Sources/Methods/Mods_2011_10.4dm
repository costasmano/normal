//%attributes = {"invisible":true}
If (False:C215)
	Mods_2011_10
End if 

// **********  ` Modified by: costasmanousakis-(Designer)-(10/3/11 10:19:35)
// Modified Forms : 
//[Conslt Rating];"Cslt Rating In "
//  `Named the object for NBISLetterPostStatus_s to "Display9".  since it was not named like that it would not display when
//  `the pulldown was clicked the first time; it required a second click.

// Modified Form Methods : 
//[Bridge MHD NBIS];"MHD Specific Items"
// CJ Miller`10/04/11, 12:50:56      ` remove references to
//`[Bridge MHD NBIS]Year Rehab'YearReh
// Modified Method(s) : 
//INSP_CulvertPrPg1_FM
//  ` CJ Miller`10/04/11, 12:43:29      ` remove usage of subtabl
//   `LAST SUBRECORD([Bridge MHD NBIS]Year Rehab)
//SCPOA_Variables
//  ` CJ Miller`10/04/11, 12:49:19      `remove String([Bridge MHD NBIS]Year Rehab'YearReh)

// **********  ` Modified by: costasmanousakis-(Designer)-(10/5/11 10:37:38)
// Created Method(s) : 
//ut_KeepConnOpen
//  ` Attempt to keep a 4D Client connection open.
//ut_LaunchKeepOpen
//  ` Launch the keepopen method as a local process. only for external server

// Modified Forms and method: 
//[Templates];"Input"
//  `Added pages 5 and 6 Document and hierarchical List

//ut_SaveBlobDataToDoc
//  `Change blob compression from fast to compact mode

//TMPL_HListOnSelect 
//  `Verify the aHL_ReportTemplates is a list
// Modified Form Methods : 
//[Dialogs];"ReportTemplateSelect"
//  `Verify the aHL_ReportTemplates is a list

// Created Method(s) : 
//ut_cleanDupsinNBISecondry 
//  ` clean duplicate records in NBIS Secondary

//INSP_InspReviewControl 
//  ` Handle the new Inspectioin Review arrays.

// Created Method(s) : 
//SIA_SET_Item67 
//SIA_SET_Item68 
//SIA_SET_Item69 
//SIA_AASHTO_SuffRat 
//  `Methods to calculate AASHTO For archive records

// **********  ` Modified by: costasmanousakis-(Designer)-(10/6/11 10:08:56)
// Modified Method(s) : 
//InitPers
//  `Adjusted code to include both MHD Underwater and Mass Highway employees in team leader / member lists

// Created Method(s) : 
//INSP_MyReviewInspections
//  ` Get the list of inspections that i (current user) supposed to review in my pending list.
//  `Return the list of Inspection responsibiliites
//  ` Parameters
//  ` $0 : $InspTitles_txt

//INSP_ReviewAction
//  ` Action on clicking the approve button

//INSP_GetReviewRules
//  ` Get the review rules for an inspection based on owner and type. fill the results in pointers
//  ` Parameters
//  ` $0 : $Done_b
//  ` $1 : $InspOwn_txt
//  ` $2 : $InspType_txt
//  ` $3 : $DBIEReqd_ptr
//  ` $4 : $AreaReqd_ptr
//  ` $5 : $FinalStage_ptr


// **********  ` Modified by: costasmanousakis-(Designer)-(10/17/11 11:31:24)

// Modified Method(s) : 
//ut_ConstructXMLSpreadSheet
//  `Started Work on adding Footers

// Modified Object Methods : 
//[Bridge MHD NBIS];"CombinedInspections".ChgInspTypeBtn
//  `Use Query({inspections]) instead of Relate Many([combined inspections]) to find the needed record

// Modified Method(s) : 
//P_ListTownAddress
//  `Increased number of districts to 6

// Modified Object Methods : 
//[Conslt Rating];"View Cslt Rating".aDistrictSelect
//[Cons Inspection];"View Cslt Insp".aDistrictSelect
//[Town Address];"View Town Address".aDistrictSelect
//  `Added a 6th district

//[Inspections];"InspectionReview".aDistrictSelect
//  `Check for INSP_SelectbyRespNew_b for the transition to Inspection Resp
//[Inspections];"InspectionReview".bzApprove
//  `test of G_Insp_ApproveReject_new

// Modified Forms : 
//[Dialogs];"ut_Request"
//  `modified object properties to handle vertical sizing better.

// Modified Method(s) : 
//Mail_SendInspRevuNotif
//  `Will now be able to send emails to Mass DOT team leaders, also notfy the DBIE

//INSP_InspReviewControl
//  `Gave all privilegese to Designe group

// **********  ` Modified by: costasmanousakis-(Designer)-(10/18/11 08:16:00)
// Modified Method(s) : 
//ut_Request
//  `Added BlankMenu to enable cut and Paste.

// Modified Method(s) : 
//INIT_UI_GV
//  `Define new global var ◊CurrentUser_Name for function Current user

//PERS_GetMyInfo
//INSP_MyReviewInspections
//INSP_InspReviewControl
//  `Use new global variable ◊CurrentUser_Name

// Created Form(s) : 
//[BridgeMHDNBISArchive];"MHD Specific Items"
//[BridgeMHDNBISArchive];"Rpt Mstr"
//[BridgeMHDNBISArchive];"Rpt Mstr Detail"
//[BridgeMHDNBISArchive];"Rpt Mstr Hdr0"
//[BridgeMHDNBISArchive];"Rpt RPC Detail"
//[BridgeMHDNBISArchive];"Rpt RPC Footer"
//[BridgeMHDNBISArchive];"Rpt RPC Header0"
//[BridgeMHDNBISArchive];"Rpt RPC Header1"
//[BridgeMHDNBISArchive];"SI & A (Insp)"
//[BridgeMHDNBISArchive];"SI & A (Normal)"

// Created Method(s) : 
//ARCH_M_MasterList
//ARCH_M_RPC_Report

// Modified Method(s) : 
//GetOwnerTrans
//GetDeficTrans
//GetFCTrans
//HistoricalTrans
//QR_RPCNames
//  `Added Optional parameter(s)

// Created Method(s) : 
//ARCH_Utils
//  ` Utility method to do various tasks for Archive table when printing
//  ` Parameters
//  ` $1 : $Task_txt ("TOWNLINE" | "AccessibilityPrint" | "RATINGS" | "RANK")

// Created Method(s) : 
//GetRtgOvrLoadEng
//  ` Get the ratings and overload engineer info

//CRTG_LetterInfo
//  ` Load required variables for Cons Insp and Rating Letters

// Modified Method(s) : 
//M_WRT_CsltRating_NTP 
//M_WRT_CsltInsp_NTP 
//M_WRT_CsltInsp_ReqFee 
//M_WRT_CsltRating_ReqFee 
//M_WRT_CsltInsp_ComplexReqFee 
//M_WRT_CsltInsp_ComplexNTP 
//  `Use new method CRTG_LetterInfo

// **********  ` Modified by: costasmanousakis-(Designer)-(10/19/11 08:26:50)
// Modified Method(s) : 
//P_ReviewLogged
//  `Changed window type to plain window
//GetBIEinfo
//  `use method GRP_GetGroupMembInfo

// **********  ` Modified by: costasmanousakis-(Designer)-(10/20/11 08:10:39)
// Created Method(s) : 
//ut_ChannelOpenError
//  ` Catch errors from the Set Channel(10; ) command

// Modified Method(s) : 
//ut_ExportImportAuxTables
//  `When opening an import file ON ERR CALL ut_ChannelOpenError

// Created Method(s) : 
//f_boolean2Num
//  ` Return a number (1:true or 0:false , or $2:true/$3:false)

//ARCHIVE_SDFOCalc
//  ` Calculate the SD status of the current [BridgeMHDNBISArchive] record - can 

// **********  ` Modified by: costasmanousakis-(Designer)-(10/21/11 10:10:07)
// Modified Method(s) : 
//ARCHIVE_FOSDFields
//  `use method ARCHIVE_SDFOCalc

// **********  ` Modified by: costasmanousakis-(Designer)-(10/24/11 09:35:56)
// Modified Method(s) : 
//Various methods
//  `Replaced calls to Current user with the ◊CurrentUser_Name variable

// Created Method(s) : 
//ut_setPrefSMTPServer 
//  ` Set the SMTP server in global variable ◊pref_SMTP

// Modified Method(s) : 
//Mail_SendInspRevuNotif
//  `Use global var ◊PERS_MyEmail_txt and method ut_setPrefSMTPServer
//ut_ControlSendMail
//CM_MailInvoiceNotice
//WKHR_MailReviewNotice
//CM_MailInvoiceNotice_2
//mail_testSend
//Mail_BridgeStatusRpt
//  `Use method ut_setPrefSMTPServer

// Created Method(s) : 
//ARCHIVE_fOutOfFreq 
//ARCHIVE_fUpForInsp
//  `Copied from corresponding fOutOfFreq and fUpforInsp ;
//  `covnerted to the [BridgeMHDNBISArchive] table
//ARCHIVE_OutOfFreq
//  `copied from M_InspSchedule
//  `covnerted to the [BridgeMHDNBISArchive] table

// **********  ` Modified by: costasmanousakis-(Designer)-(10/25/11 11:13:29)
// Created Method(s) : 
//INSP_ReviewerAllowed_b
//  ` Determine whether the current user is allowed to do a review

// Modified Method(s) : 
//G_ListTable
//  `Use System parameters UserInputForms and UserOutputForms to set the input and output forms.

// **********  ` Modified by: costasmanousakis-(Designer)-(10/26/11 14:53:41)
// Modified Method(s) : 
//G_SecureInspection
//  `use ◊CurrentUser_Name instead of Current user

// **********  ` Modified by: costasmanousakis-(Designer)-(10/27/11 09:36:22)
// Modified Method(s) : 
//INSP_VerifySIAChanges
//  `Added missing CLOSE WINDOW at the end

// **********  ` Modified by: costasmanousakis-(Designer)-(10/28/11 16:00:06)
// Modified Method(s) : 
//QR_NextInspInfo
//  `Added process var SIA_NEXTINSPTYPECODE_TXT;
//  `Changed the order in which the above and UW inspections are checked.

// Created Method(s) : 
//QR_InspSchedInfo
//  ` Calls QR_NextInspInfo and then uses SIA_NEXTINSPTYPECODE_TXT to find the last
//  ` matching inspection record. Then in the quick report fields from the inspection record can be used. 

// **********  ` Modified by: costasmanousakis-(Designer)-(10/31/11 13:03:45)
// Modified Method(s) : 
//SIA_UpdSelList
//  `Adde code to update parameter FHWASELECT_INFO and log the changes to the Parameter.