//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(1/11/2006 11:00:16)

// Modified Forms : 
//[Bridge MHD NBIS];"NBIS Stack Info"
//  `Added buttons to Copy to clipboard the Bins, or BDEPT or Item8 from
//  `the highlighted records on the list.

// Modified by: costasmanousakis-(Designer)-(1/11/2006 14:43:45)

// Modified Method(s) : 
//CreateRandomSet
//  `When the AddTo button is checked search on the "UserRegionA" set instead of
//  `All Records.

// Modified by: costasmanousakis-(Designer)-(1/17/2006 11:29:22)
// Modified Forms : 
//[Bridge MHD NBIS];"SI & A Input"
//  `Made all label text Auto appearance.

// Modified Table(s) : 
//[Contracts]
//Added field [Contracts]MaxHourlyRate real.

// Modified Forms : 
//[Contracts];"Contracts In"
//  `Added Field [Contracts]MaxHourlyRate in the input and print forms.
//  `Modified objects to be Auto Appearance

//[Contracts];"Contracts Print"
//[Contracts];"Contracts Print 2"
//  `Added Field [Contracts]MaxHourlyRate in the input and print forms.

//[Contract FundTransfer];"TransferFund Out"
//[Contract AddFund];"AddFund Out"
//[Contract ExtendTime];"ExtTime Out"
//[Contract Assignments];"Assignments Out"
//  `Modified objects to be Auto Appearance

// Modified by: costasmanousakis-(Designer)-(1/18/2006 08:59:30)
// Modified Table(s) : 
//[Contract_Maintenance]
//  `Added field [Contract_Maintenance]MaxHourlyRate Real.

// Modified Forms : 
//[Contract_Maintenance];"Contract Maintenance In"
//[Contract_Maintenance];"PrintDetail"
//  `Added Field [Contract_Maintenance]MaxHourlyRate in the forms; 
//  `Adjusted appearance of some objects to Auto.

// Modified by: costasmanousakis-(Designer)-(1/23/2006 09:07:29)
// Modified Method(s) : 
//TEMP_Fill_CSs 
//TEMP_MetricConv
//  `Commented out whole method since not needed. - Kept only for record purposes.
//  `Done to Make available table [Cond State Insp]

// Created Form(s) : 
//[zSpecialReports];"Input"
//[zSpecialReports];"Output"

// Modified by: costasmanousakis-(Designer)-(1/30/2006 12:42:33)
// Created Method(s) : 
//ut_LoadBlobArrDoc
//ut_RetrieveUIGVarrDoc 
//ut_PutUIGVArraysToDoc 
//ut_SaveBlobDataToDoc 
//INIT_UI_GV_LoadArrays
//  `New mehods to load Arrays used in the UI from documents stored in the MAC/WIN4DX folders.

// Modified by: costasmanousakis-(Designer)-(1/30/2006 13:25:03)
//INIT_UI_GV
//  `Use new method ut_RetrieveUIGVarrDoc

//Startup 
//  `Added code to display millisecond elapsed times

// Created Method(s) : 
//ut_RetrievePersArraysDoc
//  `Load the Pers arrays from a file or from the DB.
//ut_PutPersArraysIntoBlob
//  `Save the personnel arrays in a blob document

// Modified Method(s) : 
//InitPers
//  `Added code so that if param1 ="1" to return the personnel arrays in a Blob.

// Modified Method(s) : 
//Startup
//  `Use the new ut_RetrievePersArraysDoc method.

// Created Method(s) : 
//INIT_BMS_LoadArrays 
//ut_RetrieveBMSArraysDoc 
//ut_PutBMSArraysToDoc
//  `To Load and save to file arrays used in the BMS(Pontis) enviroment.

// Modified Method(s) : 
//INIT_BMS
//  `Use the new ut_RetrieveBMSArraysDoc method.
//INIT_TOWNFIELD
//  `Encase method in IF FALSE to avoid execution
//INIT_TOWN_DATA
//  `Added param 1 to return arrays in a Blob.

// Created Method(s) : 
//ut_RetrieveTOWNDATADoc
//ut_PutTWNDATAtoDoc
//  `Load and save Town data arrays from/to a file.

// Modified Method(s) : 
//Startup 
//  `Use method ut_RetrieveTOWNDATADoc.

// Modified by: costasmanousakis-(Designer)-(1/31/2006 14:32:14)
// Created Method(s) : 
//F_CompareBlobs 
//  `Compare contents of two blobs True if equal ; False if not
//ut_RetrieveTableArrDoc
//  `Retrieve from a file and load the arrays needed to sort fields and tables.
//ut_PutTableArrToDoc
//  `Store to a file the arrays needed to sort fields and tables.

// Modified Method(s) : 
//G_SortTable_new
//  `Added option to return the calculated arrays in a blob for storing in a file.
//Startup 
//  `Use the new method ut_RetrieveTableArrDoc
//ut_PutBMSArraysToDoc 
//ut_PutFieldDescriptionIntoBlob 
//ut_PutPersArraysIntoBlob 
//ut_PutTWNDATAtoDoc 
//ut_PutUIGVArraysToDoc 
//  `Modified to save a file only if there are changes from the stored version. To avoid network traffic.

// Created Method(s) : 
//Server_UpdateArrayLoaders
//  `Method to be run nightly that will call all the ut_PUTxxxtoDoc methods.

// Modified by: costasmanousakis-(Designer)-(2/1/2006 12:08:57)
//GetInspContact 
//  `Changed contact phone for Irene B.

// Modified by: costasmanousakis-(Designer)-(2/2/2006 10:18:33)
// Created Method(s) : 
//ut_GetLibraryPicID
//  `Get a Library Picture ID from a name.
//G_LoadSpecialReports
//  `Execute Custom Reports menu.

// Created Form(s) : 
//[Dialogs];"ReportTemplateSelect"
//  `Displays a menu to select a custom report

// Modified by: costasmanousakis-(Designer)-(2/3/2006 10:13:56)
// Modified Method(s) : 
//ut_RetrieveBlobDocument
//  `Use ProjMethod ut_LoadBlobArrDoc

// Modified by: costasmanousakis-(Designer)-(2/6/2006 10:15:52)
// Created Method(s) : 
//F_CompareArrays
//  `Compare two arrays
//ut_CompareStoredBMSArrays 
//ut_CompareStoredPersData 
//ut_CompareStoredBlobData
//ut_CompareStoredTOWNData
//  `Compared Arrays/vars just calculated with ones stored in data files.

// Modified Method(s) : 
//ut_PutBMSArraysToDoc 
//ut_PutPersArraysIntoBlob
//ut_PutFieldDescriptionIntoBlob 
//ut_PutTWNDATAtoDoc
//  `Use the ut_Compare.... methods instead of the F_CompareBlob - not reliable results.

// Modified by: costasmanousakis-(Designer)-(2/7/2006 11:46:28)
// Modified Method(s) : 
//InitProcessVar
//  `Added variables and code to track loading time;
//  `Replaced call to InitPers with ut_RetrievePersArraysDoc;
//  `Bypassed code that initializes arrays used in form [ElementDict]NewElement
//  ` - form is not used any more.

// Modified Forms : 
// Modified Form Methods : 
//[Bridge MHD NBIS];"ID Input"
//  `Renamed objects and buttons on the form; 
//  `Modified form method to allow entry to the agency bridge no for MTA users only.

// Modified by: costasmanousakis-(Designer)-(2/8/2006 10:13:33)
// Created Method(s) : 
//Temp_LoadMTAAgencyNo
//  `To update Agency Bridge No field from text files.

// Modified Method(s) : 
//M_ChgPassword
//  `Improved handling and restrictions on passwords entered by users.

// Modified by: costasmanousakis-(Designer)-(2/9/2006 10:02:14)
// Created Method(s) : 
//F_CompareVars
//  `Compare any two variables.
// Modified Method(s) : 
//ut_CompareStoredPersData
//  `Use method F_CompareVars when comparing UOE names and ID.
//  `Included ◊UOEUname in the Blob
//InitPers
//  `Included ◊UOEUname in the Blob
//ut_RetrievePersArraysDoc
//  `Included ◊UOEUname in the Blob

// Modified Method(s) : 
//F_CompareArrays
//  `Adjusted coding for efficiency per suggest from CJM

// Modified by: costasmanousakis-(Designer)-(2/10/2006 09:19:36)
// Modified Method(s) : 
//F_CompareVars
//  `Make sure we compare variables only - not arrays/blobs/pointers.

// Modified Method(s) : 
//G_PickFromList
//  `Use the HList variable instead of the array variable.

// Modified Forms : 
//[Contract_Maintenance];"Contract Maintenance In"
//  `Fixed Min/Max value in Max hourly Rate

// Modified by: costasmanousakis-(Designer)-(2/13/2006 09:39:49)
// Modified Object Methods : 
//[Contract_Maintenance];"Contract Maintenance In".cboType
//[Contract_Maintenance];"Contract Maintenance In".cboStatus
//[Contract_Assignment_Maintenance];"Assignment Maintenance In".projectType
//[FundTransfer_Maintenance];"TransferFund In".cboDirection
//  `Changed coding to use method POPUMENUC.

// Modified by: ManousakisC (2/14/2006)
// Modified Method(s) : 
//P_Personnel 
//  `Added variable for Menubar number
//ModSelection 
//  `Enabled use of process var  for menubar number.
//ControlMenuBar
//  `Do the first group of menu item commands only if the menu bar number
//  ` is 1 or 2.

// Modified by: costasmanousakis-(Designer)-(2/14/2006 14:23:31)
// Modified Form Methods : 
//[Contract_Maintenance];"Contract Maintenance In"
//  `Added code to change window size only if current window is smaller than required;
//  `Added code to sort related records on Load.

// Created Method(s) : 
//CM_SetupRelated
//  `To perform sort and selects as needed.

// Modified Object Methods : 
//[Contract_Maintenance];"Contract Maintenance In".***
//  `Tab control and Add buttons to use the CM_SetupRelated method.

// Modified Form : 
//[Contract_Maintenance];"Contract Maintenance In"
//  `Renamed Add buttons so that each is a diff variable.

// Modified Object Methods : 
//[Dialogs];"Inspection".hList2
//  `For the On Load event make sure ElementsSafety records have a non-zero Element Number.

// Modified by: costasmanousakis-(Designer)-(2/14/2006 16:59:01)
// Modified Method(s) : 
//G_ConfigInspBtn_1
//  `Adjusted to handle all Inspection types.

// Modified Object Methods : 
//[Inspections];"Culvert Form".bInspConfig
//[Inspections];"Routine Form".bInspConfig
//  `Use method G_ConfigInspBtn_1

// Modified by: costasmanousakis-(Designer)-(2/15/2006 12:49:36)
// Modified Method(s) : 
//G_CopyPontisToCombined
//  `After copying and before checking for links, load the previous BMS inspection.

// Modified Object Methods : 
//[Contract_Maintenance];"Contract Maintenance Out".bzAddCMContract
//[Contract_Maintenance];"Contract Maintenance Out".bzSearchLay
//  `Use method CM_SortOutputList at the end

// Modified by: costasmanousakis-(Designer)-(2/16/2006 09:19:37)
// Modified Object Methods : 
//[Contract_Maintenance];"Contract Maintenance In".btnDelete
//  `Added code to re-create the current selection after deleting - without
//  `the deleted record. Code moved here from the Out form method due to
//  `differences in behavior when standalone vs client /server.

// Created Method(s) : 
//CM_RecalcFundTransf 
//CM_RecalcAddFunds

// Modified Object Methods : 
//[AddFund_Maintenance];"AddFun In".btnSave , .btnDelete
//  `Use method CM_RecalcAddFunds
//[FundTransfer_Maintenance];"TransferFund In".btnSave , .btnDelete
//  `use method CM_RecalcFundTransf.

// Modified by: costasmanousakis-(Designer)-(2/17/2006 11:11:28)
// Modified Form Methods : 
//[Combined Inspections];"CombinedInc"
//  `Use a Query to load the related [Inspections] Record
//[Bridge MHD NBIS];"CombinedInspections"
//  `Use queries instead of Relate many([Bridge MHD NBIS])

// Modified Method(s) : 
//G_GetUWRatings
//  `Use Query to load the [Inspections] Records related to the current BIN
//  `Use method G_Insp_RelateInsp to get the [ElementsSafety] records 
//  `of each dive insp

// Modified Form Methods : 
//[Bridge MHD NBIS];"Cslt Insps"
//[Bridge MHD NBIS];"Cslt Ratings"
//[Bridge MHD NBIS];"Ratings"
//[Bridge MHD NBIS];"2nd Records"
//  `Use Query to load records.

// Modified Method(s) : 
//fElmtStorage
//fPictStorage
//G_AddImage2Insp
//G_CleanUpInspection
//  `Use method G_Insp_RelateInsp to get the related records
//Duplicate_Inspection
//  `At the end use Queries to load the related [Inspections] and [Bms Inspections] records

// Modified Form/Object Method(s) : 
//Various Inspection print forms 
//  `Replaced Calls to Relate one([elementssafety]) with Relate one([ElementsSafety]ElementNo)

// Modified by: costasmanousakis-(Designer)-(2/21/2006 09:44:09)
//Various methods
//Duplicate_Inspection
//bOpenInsp
//[Combined Inspections];"Input".bOpenBMS
//[Inspections]Pontis Form.vbPGPreview
//[BMS Inspections];"Inspections In".tbEnglish
//[BMS Inspections];"Inspections In".tbMetric
//[Inspections];"Routine Combined Form".vbPGPreview
//bOpenInsp
//[Inspections];"BlankCombinedStarter"
//[Inspections];"Culvert Combined Form".vbPGPreview
//  `Replaced  calls to RELATE ONE([Combined Inspections]) with 
//  `RELATE ONE([Combined Inspections]NBISInspID)
//  `RELATE ONE([Combined Inspections]BMSInspID)

//Duplicate_Inspection
//   `Add updating UW and Rating values.

// Created Method(s) : 
//INSP_GetUWValues_Btn
//  `Include Code used in the getUWValues buttons on inspection forms.

// Modified Object Methods : 
//[Inspections];"Culvert Combined".bGetUWValues
//[Inspections];"Routine Combined".bGetUWValues
//  `Use method INSP_GetUWValues_Btn.

// Created Method(s) : 
//CIR_RecalcAddFunds 
//CIR_RecalcAssgnFunds 
//CIR_RecalcFundTransf 
//  `Do the recalculations for the [Contracts] (Inspection and Rating contracts) 
//  `when adding/modifying/deleting AddFunds, FundTransfers, Assignments.

// Modified Method(s) : 
//G_CalculateTLFandDE 
//  `Declare all needed process vars; Use new CIR_recalc methods to do calculations.

// Modified Object Methods : 
//[Contract AddFund];"AddFund In".btnSave, .btnDelete
//  `use method CIR_RecalcAddFunds
//[Contract FundTransfer];"TransferFund In".btnSave , .btnDelete
//  `use method CIR_RecalcFundTransf
//[Contract Assignments];"Assignments In".btnSave , .btnDelete
//  `use method CIR_RecalcAssgnFunds

// Modified by: costasmanousakis-(Designer)-(2/24/2006 12:45:01)
// Modified Method(s) : 
//G_MaintenanceCalculateTLFandDE
//  `Added declaration of approx, actual variables; 
//  `Moved call to methods CM_RecalcAddFunds and CM_RecalcFundTransf after
//  `calculating Spent values.
//CM_PrintContractReport
//  `Moved call to G_MaintenanceCalculateTLFandDE after the RELATE MANY
//CM_SetupRelated
//  `Call CM_SetupRelated(2) when getting list of projects to make sure we have 
//  `all assignments.
//CM_BuildArrays
//  `Cleaned up some code; Use method CM_SetupRelated

// Modified Object Methods : 
//[Contract_Maintenance];"Contract Maintenance In".AddAssgnBtn
//  `Call CM_BuildArrays at the end

// Modified Forms : 
//[ElementsSafety];"SafetyElmtTemplate"
//  `Made buttons v3Dbuttons

// Modified by: costasmanousakis-(Designer)-(2/24/2006 16:44:48)
// Created Method(s) : 
//POPUP_HL_MENUC
//  `Method to handle Hierarchical List popup menus - similar to POPUP_MENU_C

// Modified Form Methods : 
//[Personnel];"Inspectors In"
//  `Use Hlist for 4D UserID popupmenu instead of ComboBox.

// Modified Forms : 
//[Personnel];"Inspectors In"
//  `Replaced ComboBox with Hlistpopup menu.
//  `Use method POPUP_HL_MENUC for data entry control.

// Modified by: costasmanousakis-(Designer)-(2/27/2006 13:57:03)
// Modified Method(s) : 
//G_RoutinetoBMS 
//G_CulverttoBMS
//  `Load the Bridge MHD NBIS record before making changes.
//G_Insp_ApproveReject
//  `Load the Bridge MHD NBIS record before making changes for Dive inspections and then unload it after.
//  `Above water inspections do it already.

// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"
//  `Make sure [Combined Inspections] record is loaded; 
//  `Remove the call to RELATE ONE([Combined Inspections]NBISInspID) : 
//  `it was changing the selection in the review list.

// Modified Forms : 
//[Bridge MHD NBIS];"SI & A Input"
//  `Made Print and Goto Page buttons v3dButtons.

// Modified by: costasmanousakis-(Designer)-(2/28/2006 15:54:39)
// Modified Forms : 
// Modified Form Methods : 
//[Templates];"Input"
//  `Modified form to accomodate both 4D Write templates and Quick Report templates.

// Modified by: costasmanousakis-(Designer)-(3/1/2006 10:21:49)
// Modified Forms : 
//[Status Report];"I_StatusReport"
//  `Added summary of State and Town totals along with the Grand totals.
// Modified Form Methods : 
//[Status Report];"I_StatusReport"
//  `Call method PrepStatusRep instead ofPrepReportTotal

// Modified Method(s) : 
//G_InitCondRepVars
//  `Added variables for new ST variables shown in the input form.
//PrepStatusRep
//  `Added calculation of new State and town totals.

// Modified by: costasmanousakis-(Designer)-(3/2/2006 16:05:52)
// Modified Forms : 
//[Standard Photos];"Standard Photos"
//  `Made nav buttons v3Dbuttons

// Modified Object Methods : 
//[Inspections];"Culvert Combined"
//[Inspections];"Routine Combined"
//  `Keep adding CUs until user is done

// Modified Object Methods : 
//[Cond Units];"Cond Units In".ZZ5
//  `Cleaned up message text
//[Cond Units];"Cond Units In".vElemNo
//  `Added variable to keep track of whether record is new or not.
//[Cond Units];"Cond Units In".ZZ9
//  `When Canceling a new record ask if it should be deleted...

// Modified Method(s) : 
//SETUP_CSs
//  `Alert about Flag quantity to one only if not a new record, otherwise just do it.


// Modified by: costasmanousakis-(Designer)-(3/7/2006 12:04:29)
// Modified Form Methods : 
//[Dialogs];"ReportTemplateSelect"
//  `Allow to modify the label of the OK button

// Created Method(s) : 
//TMPL_Do_Template_Choise
//  `To run choises from templates table. Moved and modified code from G_LoadReportTemplates.

// Modified Method(s) : 
//G_LoadReportTemplates
//  `Use new method TMPL_Do_Template_Choise

// Created Method(s) : 
//G_LoadBrgListAdminFunctions
//  `Run admin functions on a Bridge list.
//G_LoadAdmFunctions
//  `Run general BMS admin functions.
//M_LoadAdmFunctions
//  `Launch G_LoadAdmFunctions from a menu

//Modified Menu(s)
//Menu #2 / Data
//  `Removed "Set Item 8"
//Menu #1  / Special
//  `Combined several items into Administrative Tasks.

// Modified by: costasmanousakis-(Designer)-(3/8/2006 15:46:06)
// Modified Method(s) : 
//M_WRT_CsltRating_Complete
//M_WRT_CsltInsp_ComplexNTP
//  `Call method G_WRT_MakeDocument with argument 1 =4 (no change to margins)
//  `Modified the corresponding template to have the MHD logo in the header; adjusted
//  `page setup, header margins, tab settings

// Modified by: costasmanousakis-(Designer)-(3/10/2006 15:39:34)
// Created Table(s) : 
//[Parameters]
//  `Hold various parameters used in database calculations
// Created Form(s) : 
//[Parameters];"Input"
//[Parameters];"Output"

//[ScourPriorityRank]
//  `Store scour priority ranking information for bridge records
// Created Form(s) : 
//[ScourPriorityRank];"Input"
//[ScourPriorityRank];"Output"

// Created Method(s) : 
//BRG_BridgeSkewCos 
//BRG_ReplLength 
//BRG_ReplWidth
//  `Functions used in calculating bridge scour priorities

//SC_AnnualFailProb 
//SC_CalcReconstrCost 
//SC_CalcScourCategories 
//SC_CalcTravelCost 
//SC_ConstrCostFactor 
//SC_ContinuityF 
//SC_DetourLen 
//SC_EndExpFile 
//SC_Fatalities 
//SC_InterState_Arterial 
//SC_LoadParameters 
//SC_RemainLife_Net 
//SC_ReplacementDuration 
//SC_SetScourCategory 
//SC_StartExpHdr 
//SC_TotalFailCost 
//SC_WriteScourStartInfo 
//SC_WriteSingleDataCol 
//SC_YearAdd_60 
//SC_YearAdd_61
//   `Methods used in calculating, storing and exporting Scour priority values for Bridges

// Modified by: costasmanousakis-(Designer)-(3/13/2006 09:46:09)
//M_SetItem75 
//  `Added code to retrieve the Replacement cost from the Parameters table

// Modified by: root-(Designer)-(3/14/2006 15:26:03)
// Modified Table(s) : 
//[Bridge MHD NBIS]
//  `Changed field [Bridge MHD NBIS]RRBridgeNo to a real value.

// Modified Forms : 
//[Bridge MHD NBIS];"BDEPT Input"
//[Bridge MHD NBIS];"ID Input"
//[Bridge MHD NBIS];"MHD Specific Items"
//  `Changed entry filter and display of field [Bridge MHD NBIS]RRBridgeNo

// Modified by: costasmanousakis-(Designer)-(3/20/2006 10:48:24)
// Modified Method(s) : 
//M_WRT_CsltInsp_ReqFee
//  `Use G_WRT_MakeDocument (4)
//M_WRT_CsltRating_ReqFee
//  `Use G_WRT_MakeDocument (4)

// Modified by: ManousakisC (3/21/2006)
// Modified Method(s) : 
//ExportNBI 
//  `Added checking of Item36ABCD for length.

// Modified by: costasmanousakis-(Designer)-(3/22/2006 11:24:27)
//M_WRT_CsltRating_NTP
//  `Use G_WRT_MakeDocument (4)

// Modified Forms :
// Modified Form Methods : 
//[Combined Inspections];"CombinedInc"
//  `Changed Items 58,59,60 to variables. Adjusted form method to display these
//  `depending on the inspection type.

// Modified by: costasmanousakis-(Designer)-(3/28/2006 09:13:35)
// Modified Method(s) : 
//P_ReviewInspcts
//  `Allow G Krikoris and F Rastegari to do final approval of all Inspections. - Added approvelvl=2 for F.R.

// Modified Method(s) : 
//SC_SetScourCategory
//  `All Item113="U" bridges go to category D

// Modified by: costasmanousakis-(Designer)-(4/3/2006 12:23:31)
// Modified Form Methods : 
//[Contracts];"Contracts In"
//Moved G_ContractsCheckNegative after G_CalculateTLFandDE

// Modified Method(s) : 
//G_CalculateTLFandDE 
//  `Initialize all variables to zero
//CIR_RecalcAddFunds 
//CIR_RecalcFundTransf
//  `Added missing goto selected record([tablename];$i) in the FOR loop

// Created Method(s) : 
//CIR_SetInspectionType_OM
//  `To set the inspection type in [Cons Inspection] records.
// Modified Object Methods : 
//[Cons Inspection];"Cslt Insp In".chkRoutine
//[Cons Inspection];"Cslt Insp In".chkSM
//[Cons Inspection];"Cslt Insp In".chkElec
//[Cons Inspection];"Cslt Insp In".chkMec
//[Cons Inspection];"Cslt Insp In".chkFC
//  `Use new method CIR_SetInspectionType_OM

// Modified Forms : 
//[Cons Inspection];"Cslt Insp In"
//  `Added CheckBox for Testing Inspection assignment type.

// Created Method(s) : 
//CIR_InitInspTypeChkboxes
//  `Initialize check boxes in cons inspection input form.

//CIR_SetReceiveLabels
//  `Initialize Receive labels in cons inspection input form.

// Modified Form Methods : 
//[Cons Inspection];"Cslt Insp In"
//  `Use the new CIR_InitInspTypeChkboxes method;
//  `Fixed enabling/disabling buttons to work better; added changing color to not enterable.

// Modified Method(s) : 
//CIR_SetInspectionType_OM
//  `Account for new "Testing" type; Call CIR_SetReceiveLabels at the end.

// Modified by: costasmanousakis-(Designer)-(4/4/2006 09:10:04)
// Modified Method(s) : 
//INIT_UI_GV
//  `Added variable ◊MessageFileCycle_L to control message file cycling.
//ut_StartMessage
//  `Use the new global var ◊MessageFileCycle_L
//NewTellServer
//  `Added code to set the MessageFileCycle global var for user interaction and restore it at the end.