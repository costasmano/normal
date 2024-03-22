//%attributes = {"invisible":true}
//Method: Mods_2013_10
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/02/13, 11:20:25
	// ----------------------------------------------------
	//Created : 
	Mods_2013_10
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(10/2/13)
// Modified Method(s) : 
//TNL_InspData2Tunnel 
//  `Changed text message in alerts
//G_RoutinetoBMS 
//  `Don't check spec mem frequencies for Tunnel inspections (type= T@)
//  `

//**********`Modified by: Costas Manousakis-(Designer)-(10/4/13)
// Modified Method(s) : 
//Compiler_SQL 
//  `added all SQL_@ methods

//**********`Modified by: Charles Miller-(Designer)-(10/8/13)
// Created Method(s) : 
//maximo_SetUpMaximoUpdate 
//maximo_SetUpdateFlag 
//maximo_UpdateMaximo
//Compiler_maximo
//  ` Set up for maximo updates

// Modified Method(s) : 
//On Startup
//On Server Startup
//  ` Set up for maximo updates

//**********`Modified by: Costas Manousakis-(Designer)-(10/16/13)
// Modified Forms : 
//[Inspections];"FCPrPg1_v2"
//  ` Adjusted size / location of label line objects for better printing
// Modified Method(s) : 
//FieldsToArray 
//  `Replaced Insert in Array with Append to Array

//INSP_RailRtnPg1_FM
//  `Use different text boxes for window and mac platforms


//**********`Modified by: Costas Manousakis-(Designer)-(10/17/13)
// Modified Method(s) : 
//ControlMenuBar 
//  `Added code for the Preservation Assignments item in the Special menu
//LB_SetColumnWidths 
//  `Fix bug when $TotalWidth_l>($scrWdth_l-150)

// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"
//  `place the input form name in a variable- use dialog to load inspection if table is in read only mode

// Created Form(s) : 
//[Invoice_Maintenance];"PreservationInput"
//[Contract_Project_Maintenance];"PreservDecision"
//[Contract_Project_Maintenance];"PreservationInput"
//[Contract_Project_Maintenance];"Preserv_Summary_print"
//[Contract_Assignment_Maintenance];"PRVAddAssignment"
//[Contract_Assignment_Maintenance];"testlist"
//[Contract_Assignment_Maintenance];"PreservationList"
//[Contract_Assignment_Maintenance];"PreservationInput"
//[Contract_Assignment_Maintenance];"PreservationAdd"
//[Contract_Assignment_Maintenance];"Preserv_Summary_print"
//[Addendum_Maintenance];"PreservationInput"
//[Preservation_Reviews];"Output"
//[Preservation_Reviews];"PreservReviewInput"
//[Preservation_Reviews];"Input"
//[Preservation_Meetings];"PreservationInput"
//[Preservation_Meetings];"Input"

// Modified Method(s) : 
//ControlMenuBar 
//  `Added code for the Preservation Assignments item in the Special menu
//LB_SetColumnWidths 
//  `Fix bug when $TotalWidth_l>($scrWdth_l-150)

//**********`Modified by: Costas Manousakis-(Designer)-(10/21/13)
// Modified Method(s) : 
//G_PrintOptions 
//  `added setting of printable margins to 12;12;12;12 to match the best printable area
// ` so that blank pages are not printed.
//M_PrintRecords
//  `Added G_PrintOptions
//M_PrintRecords_CsltRating 
//  `Added call to  G_PrintOptions

// Modified Method(s) : 
//SIA_BridgeInput_FM 
//  `Include BLD records for Tunnels

// Modified Form Methods : 
//[Dialogs];"InspectConfig"
//  `Include BLD bridge cat to tunnel type inspections

//**********`Modified by: Costas Manousakis-(Designer)-(10/22/13)
// Modified Object Methods : 
//[Standard Photos]Standard Photos.vbPrintImages
//  `Added Tunnel inspection types in the recalc of the inspection pages

// Modified Form Methods : 
//[Bridge MHD NBIS];"SI & A Input" 
//  `at the end of the load event, if the table is in RO mode lock the whole input form anyway

//Form Method: [Contract_Assignment_Maintenance]PreservationList
//  `for PreservationEdit group

//**********`Modified by: Costas Manousakis-(Designer)-(10/23/13)
// Modified Method(s) : 
//SIA_MountModule
//  `if the Bridge  table is in Read only state - set it to RW to avoid error messages
//SIA_NewOpenModule
//  `Added Alerts if not one record is found in the  LB_Query table

//**********`Modified by: Costas Manousakis-(Designer)-(10/24/13)
// Created Method(s) : 
//INSP_IsInspRoutine_b
//  ` Return whether the inspection is one of the routine types
//  ` Parameters
//  ` $0 : $inspRoutine_b (true if the inspection type is one of the routine types
//  ` $1 : $InspType_txt (optional )

// Modified Method(s) : 
//G_SIA2Inspection
//INSP_InspDate_OM
//G_Insp_SetTitle
//LB_ProcessElemSftyQuery1 
//INSP_ElmSft_Input_FM 
//SIA_OnDisplayDetail 
//INSP_ElmSft_Inc_FM 
//INSP_FCPrPg1_FM 
//INSP_GetUWValues_Btn 
//INSP_InspDate_OM 
//PRV_BridgeLB_OM 
//G_SIA2Inspection 
//INSP_SaveRecords 
//Duplicate_Inspection 
//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one

// Modified Form Methods : 
//Form Method: [Inspections]InspectionReview
//Form Method: [Inspections]Inc. Inspection 
//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one

// Modified Method(s) : 
//SIA_SecureInputForm 
//  `added special action for users to edit LatLon fields only 

// Modified Form Methods : 
//[Bridge MHD NBIS];"SI & A Input" 
//  `Special case for (GRP_UserInGroup ("TEMP_EditLatLon")=1) to allow interns to edit lat long values only

//**********`Modified by: Costas Manousakis-(Designer)-(10/25/13)
// Modified Method(s) : 
//Mail_SendInspRevuNotif
//  `Added ability to include more people in the cc of the notification. Use groups in the pers_groups table
//  `named "DBIEReviewNotifCC" or "AreaReviewNotifCC" by inspection responsibility.
//  `Dive (DV@), Tunnel (T@) or Rail (RR@) inspections are excluded for now
//  `Added to the message displayed the CC list;
//  `Don't set Conslt Address table to RW if it was not RW before


//**********`Modified by: Costas Manousakis-(Designer)-(10/28/13)
// Modified Forms : 
//[Activity Log];"Input"
//  `Changed fonts to all objects to Label10Plain

// Modified Method(s) : 
//ut_ControlDBSycnh
//  `Don't call SQL_RetrieveNextID for NRC records if the Sequence name is blank - Happens with Railinforecords, Tunnelinfo or other bridge related records

// Modified Forms : 
//[Standard Photos];"Standard Photos"
//  `Created button [Standard Photos].Standard Photos.Button
//  `For Designer users - to alow recreating of the entries in the activity log table

// Modified Object Methods : 
//ReLogRecords.RelogDo
//  `Fixed bugs 
//  `Check if entries for the record id are already in the fileidres table - for now don't do any logging for such records
//  `Add messages about what was done
//  `Allow blank sequence for RelationType = 0
//ReLogRecords.TableList_atxt
//  `added initializing of RelationsFlushList_atxt

// Modified Object Methods : 
//[Standard Photos].Standard Photos.vRdPic2Blob 
//  `The Cannot handle file type is when OK=0 -> $vlRes=1 ; added message with the list of supported types from Picture Codec List

//**********`Modified by: Costas Manousakis-(Designer)-(10/29/13)
// Modified Method(s) : 
//PRV_AddAssignment_FM
//  `changed dialog to use vars instead of fields
//COMPILER_Preservation
//  `added vars for dialog to Add assignment

//**********`Modified by: Costas Manousakis-(Designer)-(10/29/13)
// Modified Method(s) : 
//[Dialogs];"InspectConfig"
//  `Use new method (page 2) for all users

//Modified Field
//[Bridge Design]Joint
//  `Increased size to A80 from A20

// Modified Forms : 
//[Dialogs];"SaveLists"
//  `made objects resizable when window grows vertically;
//  `added buttons to add all and remove all
//  `adjusted code in the add and remove selected buttons

// Modified Object Methods : 
//Object Method: [Conslt Address].Conslt Address In.Button1 
//  `Allow also users in "BMS Admin" group to edit the company name

// Modified Method(s) : 
//INSP_ImportInspection 
//  `Added importing of [TunnelInspection] record and additional warning at the end of the import
//  `regarding the personnel. It will have to be verified if the data file is not the same as the export

//INSP_ExportInspection
//  `Expanded export to the Tunnelinspection table - if it exists

//**********`Modified by: Costas Manousakis-(Designer)-(10/31/13)
// Modified Forms : 
//[Inspections];"InspectionReview"
//  `Added sorting by complete, reviewed, approved columns ;
//  `Adjusted size of forms and moved objects to fit the new sort buttons.
//Compiler_Inspections
//  `Added variables for the sort buttons ion the inspreview form

// Modified Object Methods : 
//[Inspections].InspectionReview.SorttmLdr
//  `loop thru the aPtrSortOrder  array to set the other sort variables to 0

// Modified Method(s) : 
//INSP_SortbyBDEPT
//  `loop thru the aPtrSortOrder  array to set the other sort variables to 0

//**********`Modified by: Charles Miller-(Designer)-(10/31/13)
// Created Trigger(s) : 
//[ElementsSafety]
//[Standard Photos]
//  `Trigger for the  On Saving Existing Record Event

//End Mods_2013_10