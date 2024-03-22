//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(5/2/11 10:20:02)
// Modified Object Methods : 
//[Inspections];"FreezeThaw".bEditTeam
//  `Freeze thaw Only changes....
//  `Assign a team leader to the inspection

// Modified Method(s) : 
//CINSP_LBControl
//  `Change for v11 Conversion : add declare the LB array

//SIA_BridgeInpNavCTRL
//  `Bug fix for locking after RR input

// **********  ` Modified by: costasmanousakis-(Designer)-(5/3/11 10:32:08)
// Modified Method(s) : 
//G_DeleteInspection
//  `Fix for the bug in Selection to array / LONGINT ARRAY FROM SELECTION when records are deleted in v11

// **********  ` Modified by: costasmanousakis-(Designer)-(5/4/11 11:54:49)
// Modified Object Methods : 
//[Standard Photos];"Standard Photos".vRdPic2Blob
//  `Changed the Open Document to Get Pathname only

// Created Method(s) : 
//ut_UpdateEmployerList
//  ` Uodate and Clean up the Employers list

//InitPers
//  `Removed code run for TOM NEE user.  Replaced by new method ut_UpdateEmployerList

// **********  ` Modified by: costasmanousakis-(Designer)-(5/5/11 11:45:51)
// Modified Method(s) : 
//ut_GoogleBIN
//  `Made adjustments on how to open the URL depending on the application version,
//  `for > 8 (v11 and after ) use OPEN WEB URL (url), for 2004 OPEN WEB URL (url;*)
//  `Also made all 4DVAR variable to process vars. Local vars did not work in v11 compiled.

//ut_OpenHistorySite
//  `Made adjustments on how to open the URL depending on the application version,
//  `for > 8 (v11 and after ) use OPEN WEB URL (url), for 2004 OPEN WEB URL (url;*)

// **********  ` Modified by: costasmanousakis-(Designer)-(5/10/11 11:26:05)
// Modified Method(s) : 
//StartProgress 
//  `Changed size of $3 and $4 to 132
//Get_BDEPT 
//  `Removed the PUSH and POP of records - use COPY NAMED SELECTIONS
// Modified Forms : 
//[TownLineInfo];"Input"
//  `Modified object methods of the town array, the BDEPT field and the Save button to better handle
//  `Pushing and poping records; and loging the changes to the Activity Log

// **********  ` Modified by: costasmanousakis-(Designer)-(5/13/11 15:49:14)
// Modified Method(s) : 
//M_PrintRecords 
//PRINT_SIA 
//  `Made dialog window movable dialog box. (avoid problems in v11)

//CENTER_WINDOW 
//NewWindow 
//ut_OpenNewWindow
//  `If window type is a 2 change it to a 5 movable dialog box

//Temp_Brkey2Owner 
//Temp_Brkey2Type 
//Temp_BrkeyJ2Owner 
//Temp_SetItem8 
//  `Commented out all code from these methods

// Modified Form Methods : 
//[dialogs];"ReportTemplateSelect"
//  `declared and initialize the pull down for RptDestination
//DCM_ControlCUs
//  `Fix ptr in INITLBOXES call for v11 transition and 
//  `changed INSERT ELEMENT(DCM_INSPIDs_aL;-999) to APPEND TO ARRAY(DCM_INSPIDs_aL;-999)

// **********  ` Modified by: costasmanousakis-(Designer)-(5/19/11 08:47:27)
// Modified Object Methods : 
//[Dialogs];"User_Group_List".RemoveFrGroupBtn
//[Dialogs];"User_Group_List".AddToGroupBtn
//  `Use G_PickFromList to avoid errors in v11 where lists cannot be refered to outside the dialog they were displayed

// Modified Method(s) : 
//SCPOA_ListPOAs`
//SCPOA_Print_FromList
//  `Modifications for new release of POA and bug fixes

// Created Method(s) : 
//SCPOA_PrintFormsA_FM
//SCPOA_SetEnterable_Var
//SCPOA_SetEnterable_Name
//SCPOA_Array2CkBoxArr
//SCPOA_SampleOpts
//SCPOA_CheckBox_OM
//SCPOA_2dFreqCkBx_OM
//SCPOA_EvtFreqCkBx_OM
//SCPOA_EvtSamplCkBx_OM
//SCPOA_2CFreqCkBx_OM
//SCPOA_2CSamplCkBx_OM
//SCPOA_InstrType_OM
//SCPOA_OthMonInstrOth_OM 
//SCPOA_PierElvRef_OM 
//SCPOA_AbutElvRef_OM 
//SCPOA_Array2CheckBox 

// Created Form(s) : 
//[ScourPOA];"Print2A"
//[ScourPOA];"Print3A"
//[ScourPOA];"Print4A"
//[ScourPOA];"Print5A"

// Modified Forms and Form method: 
//[ScourPOA];"Output"

// Modified Table(s) : 
//[ScourPOA]
//added fields
//[ScourPOA]PMReviewBy a(80)
//[ScourPOA]PMReviewDate D
//[ScourPOA]PMReviewed L
//changed field :
//[ScourPOA]Approved  to L


// Modified Method(s) : 
//SCPOA_Print_FromList
//  `Another Bug Fix on the confirm dialog
//SCPOA_ListPOAs`
//  `Added pFile ptr and MainTitle

// **********  ` Modified by:   `r002 CJ Miller`05/20/11, 10:51:26    
// Created Method(s) : 
// ut_ReturnUserDocFolder
//  ` This method will return logged in users documents directory


// **********  ` Modified by: costasmanousakis-(Designer)-(5/23/11 11:49:27)
// Modified Method(s) : 
//ControlMenuBar
//  `changes for scourpoa review and disabling some import items under the File menu
//  `Also control the display of the window Palette from the tools menu
//P_FilesPalette
//  `Removed call to ControlMenuBar - not needed for Pallete window form
//INIT_UI_GV
//  `Moved ControlMenuBar at the end so that the Personal info is loaded.

// Modified Method(s) : 
//SCPOA_Print
//SCPOA_MonitorChecks
//SCPOA_PrintPG2_FM 
//SCPOA_PrintPG3_FM
//SCPOA_PrintPG1_FM
//SCPOA_FldMonPgmChecks
//SCPOA_CompleteAction
//SCPOA_DataLogFreq_OM
//SCPOA_MonitSampl_OM
//SCPOA_Variables
//SCPOA_InpFormMethod `  `SCPOA V2 modifications


// Modified Forms : 
//[ScourPOA];"Print1"
//[ScourPOA];"SummaryPrint"
//[ScourPOA];"Input"

// Modified Menu
//MenuBar #1 /  Special 
//  `Added menu item "Review Scour POA"
//  `SCPOA V2 modifications

// **********  ` Modified by: costasmanousakis-(Designer)-(5/25/11 10:12:20)
// Modified Forms : 
//[Bridge MHD NBIS];"2nd Records"
//  `Make Add and Delete buttons invisible; 
//  `Change included form to "Do Nothing" on double click on empty line
//[Personnel];"Inspectors In"
//  `Changed button label to DOT Address and button code to dot.state.ma.us

// Modified Menu(s) : 
//BridgeListMenu (#2) Tools Menu
//  `Suggestion by L.Peterson: Added Window Pallette and Open History Maps items

// Modified Method(s) : 
//ExprtImprtDlog
//  `modified handling of the pFile pointer-use resolve pointer to check it.
//  `Also avoid export if there are no records selected.
//WKHR_InitConfigArrays
//  `fixed the SET LIST ITEM command for AllCategories_HL to keep any existing sublists.
//  `Also will not loop over sublist, since the list is expanded to start with.
//  `In case of a sublist make the parent bold and italic7
//ut_ExportImportAuxTables
//  `Added Templates and zSpecialReports, TableofLists to the list of tables
//SC_StartExpHdr
//  `Allow user to select the folder where to save the report
//  `This gives a complete path in Document, so no need to figure out later where the file is.

// Modified Forms : 
//[Bridge MHD NBIS];"BDEPT Input"
//  `ReLabeled 1st Tab to MassDOT Items

// Modified Form Methods : 
//  `adjusted logic of the ViewOnly variable.

// Modified Method(s) : 
//SC_StartExpHdr
//  `Allow user to select the folder where to save the report.
//  `This gives a complete path in Document, so no need to figure out later where the file is.
//  `If user cancels, default folder will be chosen and shown to user
//SC_CalcScourCategories
//  `Just open the export file. Full path is defined in SC_StartExpHdr method

// Modified Object Methods : 
//vCopyBINsClip
//vCopyBDEPTClip
//vCopyITM8Clip
//  `Append a Char(0) at the end of the blob for the V11 bug

// Created Method(s) : 
//ut_String2AlphaNumOnly
//  ` Will strip nonAlphanum characters except @ sign

// Modified Object Methods : 
//bFind
//  `Added a call to new function ut_String2AlphaNumOnly which strips non-AlphaNum 
//  `chars from the search string (leaves @ char) to avoid problems in the v11 transition
//  `Apparently v11 gets some extra characters from the clipboard. Run the search only if
//  `the search string is non-blank

// Modified Method(s) : 
//ut_ClipBoardSearch
//  `Added a call to new function ut_String2AlphaNumOnly which strips non-AlphaNum PLUS
//  `chars from the search string (Ascii 32-126)   to avoid problems in the v11 transition
//  `Apparently v11 gets some extra characters from the clipboard especially coming from excel.
// ` Run the search only if the search string is non-blank.

// **********  ` Modified by: costasmanousakis-(Designer)-(6/1/11 13:52:51)
// Modified Method(s) : 
//ADDUSER_Utils
//  `changed email extension to dot.state.ma.us
