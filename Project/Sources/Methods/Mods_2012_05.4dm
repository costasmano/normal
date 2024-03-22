//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/02/12, 16:15:44
	// ----------------------------------------------------
	//Created : 
	Mods_2012_05
End if 
//
// **********` Modified by: Costas Manousakis-(Designer)-(5/2/12 16:19:44)
// Modified Form and  Methods : 
//[Bridge Design]Bridge Design In 
//  `Fixed logic in the on load event when new record: added assigning the BIN (not automatic anymore)
//  `Removed code using the vbNewRec variable.
//  `Removed code from the bCancel button

// **********` Modified by: Costas Manousakis-(Designer)-(5/3/12 )
// Created Method(s) : 
//SIA_NewOpenModule
//  ` Uniform method to handle the 'modules' in the Bridge Input form
// Parameters
// $1 : $LBQueryName_txt
// $2 : $PageNo_L
// $3 : $FormName_txt (optional)

// Modified Object Methods : 
//[Bridge MHD NBIS];"Bridge Input".bInspection
//[Bridge MHD NBIS].Bridge Input.bInventory
//[Bridge MHD NBIS];"Bridge Input".bCsltInsp
//[Bridge MHD NBIS];"Bridge Input".bCsltRating
//[Bridge MHD NBIS];"Bridge Input".bCsltRating
//[Bridge MHD NBIS];"Bridge Input".bSecond
//[Bridge MHD NBIS];"Bridge Input".bDesign
//  `use SIA_NewOpenModule

//[Bridge MHD NBIS].BridgeTemplate.ZZ9
//  `Release all other tables except the Bridge table

//INV_GetBINInventoryPhotos
//  `Unload the current record of [InventoryPhotoInsp] after the sort

//SIA_BridgeInpNavCTRL
//  `Unload the current record of the table listed
//  `added the query for [Bridge Design] in here

//SIA_ControlDoubleClick
//  `Moved SIA_ReleaseBridgeRec at the end to apply to all cases;
//  `Changed sort order of Bridge design to descending (<)
//  `Added vApproveLvl - Cannot approve inspections from this point of entry.
//  `Use INSP_UpdateInspList to re load the list of inspections

//SIA_SetUpListBoxes
//  `Removed the query for [Bridge Design] from this method - now done in SIA_BridgeInpNavCTRL

// **********` Modified by: Costas Manousakis-(Designer)-(5/4/12 )
// Modified Forms : 
//[Bridge MHD NBIS];"Bridge Input"
//  `Checked the Hide focus rectangle on all listboxes;  Hide headers on the invphoto  LB ; 
//  `adjusted invphot LB; cleaned form events on Add Buttons
//  `Deleted the bPontis button

// Modified Method(s) : 
//SIA_FindMissingBDEPTs
//  `Added a while loop to repeat the search when searching for a town;  adjusted  the output

//ut_CreateSQLVariables
//  `Save the text files to a selected folder and name the files

// Created Method(s) : 
//f_PadString
//  ` Pad a string up to a length
// Parameters
// $0 : $Res_txt
// $1 : $Inp_txt
// $2 : $PadLen_L
// $3 : $Append_b (Optional - assumed true = Append; False = Pre

//ut_ShowAppFolders
//  `Show the folders used by the app currently using Get 4D folder and System folder

// Modified Forms : 
//[Inspections]StormDamageInspection
//  `Adjusted form / objects for final release

// **********` Modified by: Costas Manousakis-(Designer)-(5/7/12 )
// Modified Form / methods : 
//[Dialogs];"InspectConfig"
//  `Added "UWFloodBtn"


// **********` Modified by: Costas Manousakis-(Designer)-(5/8/12 )
// Modified Method(s) : 
//Print_Dive_F
//  `Added DVF form , and calls to resize window at the end to clear phantom blank spots
//GetInspType
//  `Added Flood DVF inspection type

// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"
//  `Added Flood DVF inspection type

// Modified Object Methods : 
//[Inspections]"Dive Template".vbPG1Preview
//  `Added DVF form , and calls to resize window at the end to clear phantom blank spots


// Modified Forms : 
//[Bridge MHD NBIS];"Bridge Input"
//  `Adjusted sizes and locations of various listboxes and labels in several pages for better fit in windows platform
//  `adjusted header bars, window size

// **********` Modified by: Costas Manousakis-(Designer)-(5/9/12 )

// Modified Forms : 
//[Conslt Rating];"Cslt Rating In"
//  `Adjusted form margins from 0 horiz to 19

// Modified Method(s) : 
//BMSExternal_Transfer
//  `Added an email at the end. and a semaphore to make sure  two processes dont run on top of each other
// Created Method(s) : 
//BMSExternal_Transfer_1
//BMSExternal_Transfer_2
//BMSExternal_Transfer_3
//  ` copies of BMSExternal_Transfer so multiple entries can be made in the 
//  `Server process table

// Modified Method(s) and form method(s) : 
//SIA_BridgeInput_FM
//[Bridge MHD NBIS];"NBIS Stack Info"
//  `Changed method of adjusting window size. Now the size is adjusted in the on  load form method of the input form.
//  `sized back to the original in the close detail of this form. keep track by setting a variable in the On Open Detail of the 
//  `Output form

//G_InitInspVars 
//  `Added declaration for the format pulldowns for the 4D Write areas

//WRUTIL_Function
//  `Added Function "FORMATPULLDOWN"

//[Inspections];"Critical Member"
//[Inspections];"Dive Form"
//[Inspections];"Dive LowCl"
//[Inspections];"Underwater Special Member"
//[Inspections];"Closed Bridge"
//[Inspections];"Damage Form"
//[Inspections];"Routine Combined"
//[Inspections];"Culvert Combined"
//[Inspections];"RailRoutineInput"
//  `Renamed the format pulldowns and changed the code there to call  WRUTIL_Function

//[ElementsSafety];"Safety Elm Input"
//[ElementsSafety];"Safety Elm Inp Dive"
//[ElementsSafety];"Safety Elm Inp DiveS"
//[ElementsSafety];"SafetyElementInputEx "
//  `Renamed the format pulldowns and changed the code there to call  WRUTIL_Function
//  `added Show Menu for 4D Write area

// **********` Modified by: Costas Manousakis-(Designer)-(5/10/12 13:29:06)
// Modified Forms : 
//[ScourPOA]FieldVerificationCardpg1
//  `Adjustments to object sizes, locations for better fit
//[ScourPOA]Print1-A
//  `Fixed labeling of 1g. object names
//[ScourPOA]Print3-A
//  `Moved var SCPOA_EmergFacYN_txt to clear the label
//[ScourPOA];"Input-A"
//  `Adjusted size of object on field verif page 1 - general

// Modified Method(s) : 
//SIA_BridgeInpNavCTRL
//  `Added vApproveLvl and INSP_KiloPtValues in the call for [Combined Inspections]

//**********`Modified by: Costas Manousakis-(Designer)-(5/14/12)
// Modified Method(s) : 
//INSP_ReviewAction
//  `Removed the 'blanking' of the review history upon final approval.

// Created Method(s) : 
//ut_ControlUserPrefs
//  `Handle user preferences in an xml file stored locally
// Modified Method(s) : 
//ut_setPrefSMTPServer
//  `use ut_ControlUserPrefs to load  the user prefs and supercede the ones in the DB.
//InitPrefs
//  `Call ut_setPrefSMTPServer after loading prefs from db or MHDBMSPrefs file
//M_HandlePrefs
//  `Preferences dialog now includes SMTP server. 
//  `now the print and smtp prefs are not stored in the db - stored in xml file
//  `dialog has three options now,: cancel , apply and save, apply - prefs written only if apply and save is clicked
// Modified Forms : 
//[Dialogs];"Preferences"
//  `Preferences dialog now includes SMTP server. and buttons to just apply settings, apply and save to xml, restore
//  `from the preferences file, or restore the SMTP server from the db


//Integrate the following
//Add code to retrieve vendor ID
//New field [PRJ_Contractor]
//[PRJ_Contractor]CTR_VendorCode_s
//Changed the following methods
//ut_PRJCtrlRetrieveProjectData 
//SQL_ClearArrays 
//SQL_FillBuiltStatements 
//New method
//ut_PRJRetrieveVendorID 

//New record in
//[Parameters]
//sp_RetrieveVendorID
//Description
// /*sp_RetrieveVendorID
//CJ Miller
//New call added to retrieve vendor ids

//*/

//SELECT     dbo.TBLCOMPANYMASTER.Vendor_ID
//FROM       dbo.TBLCOMPANYMASTER WITH(NOLOCK)
//WHERE(dbo.TBLCOMPANYMASTER.Key_ID=[PRJ_Contractor]CTR_ContractorID_l)

// **********  `End of Release   `2012-05-16 : Version 6.0.5

//**********`Modified by: Costas Manousakis-(Designer)-(5/18/12)
// Modified Method(s) : 
//SIA_ControlDoubleClick
//  `Added var $SortOrder_txt; fixed bug in the [RatingReports]

//**********`Modified by: Costas Manousakis-(Designer)-(5/21/12)
// Modified Forms : 
//[Standard Photos];"PrintPhoto"
//  `increased the vert size of the Photo description box

//**********`Modified by: Costas Manousakis-(Designer)-(5/22/12)
// Modified Table(s) : 
//  ` Changed field [Personnel]Employer to A80

// Modified Forms : 
//[Dialogs].BigAlert
//  `Added button to copy the text to the clipboard

// Modified Method(s) : 
//Startup_PL
//  `Add ◊MyDocumentsFolder_txt variable
//ut_UpdatePontis
//ut_PRJCtrlRetrieveProjectData
//ut_PRJImportData
//ut_PRJCntrlRetrieveOfAmounts
//  `Use ◊MyDocumentsFolder_txt

//ut_ShowAppFolders
//  `Added all the system folder 

//**********`Modified by: Costas Manousakis-(Designer)-(5/23/12)
// Modified Forms : 
//[Inspections];"FreezeThaw"
//  `Adjusted size and position of objects on page1
//[ElementsSafety];"FreezeThawInp_1"
//  `Adjusted size and location of objects

// Modified Method(s) : 
//ControlClientProcess
//  `Move  READ ONLY([ServerProcesses]) 
//  `Added sending email at the end

//End Mods_2012_05