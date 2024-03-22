//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(1/5/11 09:45:18)
// Modified Method(s) : 
//M_DISTRICT6
//  `Adjusted selection of bridges

// **********  ` Modified by: costasmanousakis-(Designer)-(1/11/11 15:45:27)
//``` **** Enhancement ****
// Modified Table(s) : 
//[Bridge MHD NBIS]
//  ` Added field [Bridge MHD NBIS]FundingSource A80

//[BridgeMHDNBISArchive]
//  ` Added field [BridgeMHDNBISArchive]FundingSource A80

// Modified Forms : 
//[Bridge MHD NBIS];"Other Info"
//  `Added filed [Bridge MHD NBIS]FundingSource

// Created Method(s) : 
//M_MHS 
//  ` Show MHS funded bridges

// Modified Menu(s) : 
//BridgeListMenu / Records
//  ` Added item MHS Funded Bridges

//``` **** END OF  Enhancement ****


// Created Method(s) : 
//MENU_GetMenuByName 
//MENU_GetMenuItemByName 
//MENU_MenuItemUtil
//`Methods to work using names of menus and menu items instead of numbers. Fix for v11 transition
// Modified Method(s) : 
//MENU_EnableEnterItem
//` Fix for v11 transition
//ControlMenuBar
//` Fix for v11 transition

// **********  ` Modified by: CJ Miller-(Designer)-(1/14/11
// Modified Method(s) : 
//ut_PRJRetrieveDCAmounts
//  `Add code to allow for retrieve of [PRJ_DesignContracts] amounts and
//   `[PRJ_ConstructionProject] seperately

// **********  ` Modified by: costasmanousakis-(Designer)-(1/14/11 14:47:57)
//``` **** Scour POA Enhancement ****
// Modified Method(s) : 
//SCPOA_Variables
//  `Added variables  SCPOA_BrgOpenPendDive_L for the Bridge reopenning plan
// Modified Forms  : 
//[ScourPOA];"Input"
//[ScourPOA];"Print4"
//  `Added variable  SCPOA_BrgOpenPendDive_L for the Bridge reopenning plan
//  `Changed the description of checkboxes in 7.b
//[ScourPOA];"SummaryPrint"
//  `Changes additions to Bridge ADT info
//``` **** End oi Scour POA Enhancement ****

//``` **** Minor bug fix ****
// Modified Form Methods : 
//[Conslt Rating] Cslt Rating In 
//  `added missing ENABLE BUTTON(*;"CRTG_PageTab@") when read-only
//``` **** End Minor bug fix ****

// **********  ` Modified by: costasmanousakis-(Designer)-(1/19/11 11:37:43)
//``` **** Rail Bridge Additioins ****
// Created Method(s) : 
//ut_InitializeRailData
//  `Initialize data required for Rail and Transit
//ut_loadRRElements
//  ` Import RR elements for RRO bridge Inspections
//INSP_AddElmtCat2HL
//  ` Adds elements from a category to an Hierarchical list
//SRC_EL_Util
//  ` load arrays used in Search by element deficiency
// Method: INSP_RailRtnPrPg2_FM
//  ` Form method for the second page of the Rail Routine form
// Method: SIA_RRVariableUtil
//  ` Utility for Rail SIA variables
// Method: SIA_RRInput_FM
//  ` method for the Rail SIA input form

// Modified Method(s) : 
// Method: SIA_BridgeInpNavCTRL
// Method: SIA_BridgeInput_FM
// Method: INIT_FIELDS_ARRAYS
// Method: INSP_ElmSft_Input_FM
// Method: INSP_PrintSIA
// Method: ut_CompareStoredBlobData
// Method: SRC_ResetForm
//  `Also exclude Freeze thaw elements
//PM: ut_RetrieveBlobDocument 
//` RR -- also moved call to INIT_FIELDS_ARRAYS at the start since it was removed from INIT_FIELDS_DES
//G_DefInspElmts
//` RR - also increased size of arrElements to 200
//GetInspType
//procedure: CreateDefElemHlist
//  `Use method INSP_AddElmtCat2HL
//procedure: MakeInspection
//procedure: CreateElemDictHlist
//  `Use method INSP_AddElmtCat2HL - now effectively the same as CreateDefElemHlist
// PRINT_ROUTINE_F
//GP: M_PrintRecords
//INIT_FIELDS_DES 
//` RR - also removed call to INIT_FIELDS_ARRAYS
// PRINT_SIA
//INSP_PrintInspBtn_OM
//COMPILER_InspElmtVars


// Created Form(s) : 
//[RAILBridgeInfo];"RailInput"
//[Inspections];"RailRoutinePrPg2
//[Inspections];"RailRoutinePrPg1"
//[Inspections];"RailRoutineInput"
//[Bridge MHD NBIS];"RailTransitSIA"

// Modified Forms/methods : 
//[Inspections];"BlankCombinedStarter"
//[Dialogs];"Search Def Element"
//`RR ;exclude FRZ elements
//[Dialogs];"InspectConfig"
//[Bridge MHD NBIS];"SI & A Input" 
//` RR Changes To allow RRBridgeEdit users access to the SIA for @RO bridges; also use $currUser_txt

// Modified Forms : 
//[Bridge MHD NBIS];"Bridge Input"
//Added button bRailRoad

// Modified Object Methods : 
//[Inspections];"AboveWater Template"bPrint
//[Dialogs];"Search Def Element".cboInspType
//[Dialogs];"Inspection".vDefElemts


//``` **** END OF Rail Bridge Additioins ****

//``` ****   ``Inspection form variables mods 
// Created Method(s) : 
//INSP_VerifyElmtSftyFormVar
// `find what element variables are on forms for inspections. 
// Method: INSP_CollectFormVars
//  ` Collect the variables used in the various inspection forms.
// Method: INSP_FillElementInfo
//  `added call to INSP_VerifyElmtSftyFormVar


//``` ****   ``Inspection Enhancement  ****
//Fix alignment, ht and extra text of objects on Inspection print forms
// Modified Forms : 
//[Inspections];"RoutinePrPg2_v2"
//[Inspections];"Routine Pr Pg 2"
//[Inspections];"Routine Pr Pg 1"
//[Inspections];"Routine Arch Pr Pg 1"
//[Inspections];"FCPrPg1_v2"
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"Culvert Pr Pg 2"
//[Inspections];"DamagePg1_v2"
//[Inspections];"Damage Pg1"
//[Inspections];"Culvert Pr Pg 1"
//[Inspections];"CulvertPrPg1_v2"

// **********  ` Modified by: costasmanousakis-(Designer)-(1/24/11 13:44:54)
//``` ****   ```Internal Mods
// Modified Method(s) : 
//M_SearchSel 
//M_SearchEditor
//  ` Added setting Auto Relations to True True before the search

//````*******    *******`````````
//````*******   END OF v5.9.0 Jan-26-2011 RELEASE CHANGES *******`````````
//````*******    *******`````````

// **********  ` Modified by: costasmanousakis-(Designer)-(1/31/11 09:35:28)
// Modified Method(s) : 
//X_CreateOwnRecs
//  `Added optional 2nd text param to choose which type of  [owner] records are created;
//  ` and some error checks on the parameters.
// ut_RelogBridgeMHDNBIS_record
//  ` Use method X_AddOwnerRec
