//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(4/2/09 11:19:42)
// Modified Method(s) : 
//WKHR_DeleteRow
//WKHR_InsertRow
//WKHR_ClearOutCategory
//  `Fix for the new Version of Work hours.
//WKHR_Temp_LoadDescr 
//  `Removed the addition of two blank lines at the end of each major list section

// Modified Forms : 
//[Work_Estimate];"Input"
//  `Fixed min form horiz margin, and re-arranged hidden buttons on page 2

// **********  ` Modified by: costasmanousakis-(Designer)-(4/2/09 16:52:36)
// Modified Object Methods : 
//[Bridge MHD NBIS];"CombinedInspections".bOpenInsp
//[Bridge MHD NBIS];"CombinedInspections".bDuplicate
//[Bridge MHD NBIS];"CombinedInspections".ChgInspTypeBtn
//  `Adjusted code to assume that the first record in the list is selected, 
//  `unless there are no records.

// **********  ` Modified by: costasmanousakis-(Designer)-(4/8/09 09:18:23)
// Modified Method(s) : 
//INV_LockUnLockCurrRec
//  `Added a cancel transaction when Locked

// Created Method(s) : 
//RtgMethod_OM
//  ` Method used for the object method of the Popup menus
// ` fot the Rating method in [RatingReports] input form.

// Modified Object Methods : 
//[RatingReports];"RatReportsIn".aIRatMethD_
//[RatingReports];"RatReportsIn".aORatMethD_
//  `use the new RtgMethod_OM method

// Modified Form Methods : and
// Modified Form Methods : 
//[RatingReports];"RatReportsIn"
//  `Removed the On Load event from the aIRatMethD_ and aORatMethD_ Popupmenus;
//  `added the respective call to RtgMethod_OM to the On load event of the form

// Modified Forms : 
//[Bridge MHD NBIS];"Ratings"
//[Bridge MHD NBIS];"Cslt Insps"
//[Bridge MHD NBIS];"Cslt Ratings"
//  `For the included form disabled the 'Add new record on double click on blank line'

// **********  ` Modified by: costasmanousakis-(Designer)-(4/9/09 19:17:07)
// Modified Method(s) : 
//PRINT_FREEZE_F 
//  `Set the vPrintPhotos, vPrintSketches,vPrintCharts flags to 1 to print them (if any)

//Print_Freeze_pg1 
//  `When running the method with PrintFlag=False (ie checking page numbers), direct the print output to
//  `a temp file and then delete the file. Avoids blank pages.

// Modified Forms : 
//[Inspections];"FreezeThaw"
//  `Set the Elements Included list to Don't Add on Double click on blank line

// Modified Method(s) : 
//G_InitInspVars
//  `Added Vars INSP_ThermoRed_L, INSP_ThermoBlack_L; Set them to Red on White, or Black on White
//  `They modify the Color of the font used in the Thermometers, not the color of the bar itself
// Modified Method(s) : 
//G_SetThermometer
//  `Use Vars INSP_ThermoRed_L, INSP_ThermoBlack_L
// Modified Object Methods : 
//[Inspections];"Culvert Combined". All Thermometer object methods 
//[Inspections];"Routine Combined". All Thermometer object methods
//  `Use Vars INSP_ThermoRed_L, INSP_ThermoBlack_L

// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"
//  `Call method G_InitInspVars so that it is called before the input forms get loaded.
//[Inspections];"Closed Bridge"
//[Inspections];"Critical Member"
//[Inspections];"Culvert Combined"
//[Inspections];"Damage Form"
//[Inspections];"Routine Combined"
//  `Removed the call to G_InitInspVars
//[Inspections];"FreezeThaw"
//  `Set the Elements Included list to Don't Add on Double click on blank line
//  `Removed the call to G_InitInspVars
// Modified Method(s) : 
//INSP_UWInputForm_FM
//  `Removed the call to G_InitInspVars
//[Inspections];"Underwater Special Member"
//  `Removed call to INSP_Check4DWriteChgs

// Modified Forms : 
//[Dialogs];"TwoListMove"
//  `Adjusted size of button to make them better visible

// **********  ` Modified by: costasmanousakis-(Designer)-(4/10/09 11:01:52)
// Modified Method(s) : 
//ut_LoadRecordInteractive 
//  `Added delimiters [] around table name. user, processes
//  `Also check for deleted record!

//INSP_UpdateInspList
//  `Use the new effect of GOTO SELECTED RECORD to clear the selection of inspections.

// Modified Object Methods : 
//[Bridge MHD NBIS];"CombinedInspections".bOpenInsp
//  `Adjusted code to use Selected record number before and after to keep the record highlighted.
//  `and method ut_LoadRecordInteractive to load the record.
//[Bridge MHD NBIS];"CombinedInspections".bDuplicate
//[Bridge MHD NBIS];"CombinedInspections".ChgInspTypeBtn
//  `Adjusted code to use Selected record number before and after to keep the record highlighted.

// **********  ` Modified by: costasmanousakis-(Designer)-(4/13/09 10:29:06)
// Modified Form Methods : 
//[Dialogs];"InspectConfig"
//  `Allow consultant inspectors to created Freeze Thaw inspections

// **********  ` Modified by: costasmanousakis-(Designer)-(4/14/09 11:27:42)
// Modified Method(s) : 
//M_WRT_IOMcover_inhouse
//  `Added the "Acting" in the In-house transmittal for Greg K.
//ut_updateCMAssgnABP
//  `Modified to searching for "%ABP%" instead of "Accel%Bridge%"

//
// **********  ` Modified by: chuck miller-(Designer)-(4/14/09 11:27:42)

//r004  `04/17/09, 10:33:26 `These changes all made in 2003 version as well
// `r001  `04/17/09, 10:33:59 `Fix bug where consultant changes not being made. Record was in read only state
//PRJ_DetailOutsideCall
//Move consultant name down to where it belonged on input form
//[PRJ_ProjectDetails];"PRJ_ProjectDetail.i"
//v449 `r001  `04/17/09, 10:36:07 `Only bring up window if there is a project file recor
//PRJ_ControlChapter85Input 

// **********  ` Modified by: costasmanousakis-(Designer)-(4/21/09 19:15:17)
// Modified Form Methods : 
//[Bridge MHD NBIS];"Bridge Input"
//[Inspections];"BlankCombinedStarter"
//[Inspections];"BlankStarter"
//  `Place WildCard around "MHD BMS External" to account for the new .4Dx extensions in 2004
//  `Removed the .comp at the District X BMS.comp string.
// Modified Method(s) : 
//Startup 
//  `Place WildCard around "MHD BMS External" to account for the new .4Dx extensions in 2004
// Modified Database Method(s) : 
//On Startup
//  `Place WildCard around "MHD BMS External" to account for the new .4Dx extensions in 2004

// Modified object Methods : 
//[Dialogs];"About".sdbStructureName
//  `Use Application file when "runtime volume license"

// Modified Method(s) : 
//XDownLoadServer
//X_CheckRemoteLog
//  `Removed the .comp at the District X BMS.comp string.
//InitPrefs
//  `Added ".4D@" to the Structure file comparison for the new 2004 type extensions.
//  `When checking for the Prefs in Client mode extract only the filename of the structure file w/out
//  ` the extension.
//ut_LoadBridgeDesRecs 
//  `Added ".4D@" to the Structure file comparison for the new 2004 type extensions.
//WKHR_PropFund2Assgn
//  `Added @ after "External" for the .4DC extension used in 4D 2004 version

//Startup_PL 
//ut_LoadBlobArrDoc
//ut_Delete4DXDocument
//G_InstallFont 
//  `Use the new Get 4D folder(4D Client Database Folder) in v 2004 to get the set the 4DX folder in Client mode

//r002  `04/24/09, 15:52:19`Add methods to store and retieve users and groups on server startup and shutdown
//ut_ReturnFolderOfDataFile 
//ut_SaveUsersAndGroups 
//ut_LoadUsersAndGroups 


// **********  ` Modified by: costasmanousakis-(Designer)-(4/29/09 )
// Modified Method(s) : 
//G_Insp_ElmtArray_setup
//  `Keep track of the current record number to avoid loosing the spot when exiting the input form
//  ` or when clicking on the included list.
//Print_Freeze_pg1
//  `Fixed the SET PRINT OPTION(Destination option ;2;$tempFile_txt) - used to have option 3
//  `which worked on a MAC, but gave errors when trying to delete the temp file on a PC.

// Modified Forms(s) : 
//  `The included form objects named @_enter for ElementsSafety table in all Inspection input forms were modified to be
//  `single selection- otherwise when scrolling and then double-clicking the incorrect element safety would open.

//  `Use the new Get 4D folder(4D Client Database Folder) in v 2004 to get the set   `the 4DX folder in Client mode

//r002  `04/24/09, 15:52:19`Add methods to store and retieve users and groups on se  `rver startup and shutdown
//ut_ReturnFolderOfDataFile 
//ut_SaveUsersAndGroups 
//ut_LoadUsersAndGroups 


//r003  `04/29/09, 10:41:13 `PRJ Design Contract Changes
//New table
//[PRJ_DCPFJoin]
//[PRJ_DCPFJoin]DCPF_Contract_FileNo_s
//[PRJ_DCPFJoin]DC_DesignProjectID_l
//[PRJ_DCPFJoin]PF_FileID_l
//modified tables
//[PRJ_ProjectDetails]PRJ_ConsultantOverideID_l  `new field moved form project file  ` table
//[PRJ_ProjectDetails]PRJ_DefaultDesignContractID_l `used to identify default desig  `n contract

//ut_PRJ_FillDCPFJoinTable
//ut_PRJRetrieveDesignContracts
//ut_PRJCreateDCPFJoinRecord
//ut_PRJUpgradeConsultantOverride 
//ut_PRJUpgradeForDesignContract
//ut_PRJUpgradeProjectDetail
//ut_prjUpgradeForDesignContract
//Move overide consultant from project file to project details

