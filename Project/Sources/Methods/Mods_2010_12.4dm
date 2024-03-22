//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(12/1/10 10:07:33)
// Modified Method(s) : 
//PERS_GetMyInfo
//  `Added ◊PERS_MyJobCode_i; ◊PERS_MyDivision_txt; 
// ` optional parameter 1 -mainly for to aid in debugging executed in the debugger window
//M_ListDistrMaint
//  `Added search for contracts belonging only to my district


// **********  ` Modified by: costasmanousakis-(Designer)-(12/2/10 14:49:01)
// Modified Method(s) : 
//ControlMenuBar
//  `Added enabling of new mennu item (set ITEM 75) in the data menu for menu bar 2

// **********  ` Modified by: costasmanousakis-(Designer)-(12/3/10 15:08:44)
// Modified Method(s) : 
//ut_StructureNumberChangeReport
//  `Do the Item8 check only for records currently in the NBI category (FHWARecord=True);
//  `No need to include bridges that have been taken off the NBI.

// **********  ` Modified by: costasmanousakis-(Designer)-(12/7/10 11:44:37)
// Modified Method(s) : 
//ut_PRJRetrieveDCAmounts 
//SQL_FillBuiltStatements
//  `instead of using [PRJ_DesignContracts]DC_DesignContractNumber_l and [PRJ_DesignContracts]DC_SQLContractID_l directly in the SQL_Fill.... methods
//  `define process vars PRJ_RTRV_ContractNo_txt and PRJ_RTRV_ContractID_L.

// Created Method(s) : 
//DCM_C_Input_FM
//  ` Method for Input Form [DCM_Contracts];"DistrMaintInput"

// **********  ` Modified by: costasmanousakis-(Designer)-(12/10/10 11:24:35)
// Modified Forms : 
//[Conslt Rating];"Cslt Rating In"
//[Cons Inspection];"Cslt Insp In"
//  `Added checkbox CRTG_AutoCalc_L and adjusted the code in the Actual Costs
//  `Salary, Indirect Cost and Net Fee objects to not do calculations based on the overhead rates
//  `if the checkbox is checked;
//  `Also adjusted location, size and display format of the objects on negotiated and actual pages

// **********  ` Modified by: costasmanousakis-(Designer)-(12/13/10 11:24:35)
// Modified Method(s) : 
//GetDistrictAddress
//  `Added optional parameter $1 for the district

//GetDBIEinfo 
//  `Call GetDistrictAddress with the optional parameter

//DCM_AssignControl
//  `Coding Enhancement - also avoid resetting [DCM_Contracts]ApproxSpent if there is no change
//DCM_ContrBidItems
//  `Fixes additions for Bid Item Calculations ; additional Bid Items
//DCM_ControlCUs
//  `Fix listbox selection start
//DCM_ControlWOBlobs
//  `Fixes for Bid Item Recalculation
//DCM_ContrProjControl
//DCM_P_Input_FM
//DCM_WO_PrjLB_Control
//DCM_PROJITEMS_CTRL
//DCM_WO_Input_FM
//DCM_C_Input_FM
//  `BugFixes
// Created Method(s) : 
//DCM_CompTable_ADDDELROW
//DCM_COMPTBLADDDATE
//DCM_CompRates
//DCM_OPENList
//DCM_EditContrQ_OM
//DCM_ContractQ_OM
//DCM_DelBidItem
//


// **********  ` Modified by: costasmanousakis-(Designer)-(12/16/10
// Created Method(s) : 
//ut_PRJGetCPAmounts
//  ` Load the construction contract cost ammounts
//ut_PRJRetrieveCPAmounts
//  ` Retrieve the construction contract cost ammounts

// Modified Method(s) : 
//ut_PRJCtrlRetrieveProjectData
//  `Added call to ut_PRJRetrieveCPAmounts to update the Construction contract Cost data (Encumbered, spent, remaining)

// Crearted by: Lori Peterson-(Lori)-(12/16/10 11:20:57)
// Created Method(s) : 
//QR_MarksReport


// **********  ` Modified by: costasmanousakis-(Designer)-(12/17/10 09:54:27)
// **** Enhancement  ****
// Modified Menu : 
//Menu 1
//  `Enabled access to the Export NBI Data to all users. Mainly so DBIEs can export and run a check themselves, or 
//  `have someone do it for them

// Created Method(s) : 
//f_BridgeOverWater
//  ` Determine whether a bridge is over water based on item 42B

//SIA_DataCheck 
//  ` Execute Data checks on NBI data; Return a text with errors

// Modified Method(s) : 
//ExportNBI
//  `Added call to SIA_DataCheck; Launch the error file if any errors were found.

// **********  ` Modified by: costasmanousakis-(Designer)-(12/20/10
// Modified Method(s) : 
//ut_RelogBridgeMHDNBIS_record
//  `Get the list of users to be included in the [Owners of Data] records from the 4D Users and Groups;
//  `Add the Owner Records after the execution of LogNewRecord  and FlushGrpChgs.


// **********  ` Modified by: costasmanousakis-(Designer)-(12/23/10 
// Modified Method(s) : 
//G_PickFromList
//G_LoadSpecialReports
//TMPL_Do_Template_Choise
//  `Save the selected item no in a process variable
//ut_GenerateInspVarCompiler
//  `Added Lines for  variables :Previous Insp Rating for Inspection Evaluation form
//COMPILER_InspElmtVars
//  `Updated 


// **********  ` Modified by: costasmanousakis-(Designer)-12/30/10
// Created Method(s) : 
//ARCH_SearchInspComplete
//  ` Search the unsent entries in Activity log for InspComplete=Y
//  ` and email to DBIE the list that has not been downloaded to the District server.

// **********  ` Modified by: Kenny Yang-(Designer)-12/30/10
// Created Form(s) : 
//[Inspections];"Evaluation Form Page1")
//[Inspections];"Evaluation Form Page2")
//[Inspections];"Evaluation Form Page3")
//[Inspections];"Evaluation Form Page4")
//[Inspections];"Evaluation Form Page5")
// Created Method(s) : 
//INSP_FillPreElementInfo 
//PRINT_QAFORM
//INSP_PrintQAForm_OM
//  `Methods used in printing the QA Form


// **********  ` Modified by: Charles Miller-(Designer)-(12/30/10 )
// Modified Method(s) : 
//ut_LoadBlobArrDoc 
//ut_SaveBlobDataToDoc
//  `Change placement of initialize files to Extras folder from either Win4DX or Mac4DX

// Created Method(s) : 
//ut_ExtractLexiconDictionary

// ut_UpdateLocalDictionary
//  ` This method will update local dictionary

//ut_CreateGenericDictionaryDoc
//  ` This method will load parameter for MHD shared dictionary.
//  `It will create a blob with array of each word
//  `It will write document to extras folder on the server
