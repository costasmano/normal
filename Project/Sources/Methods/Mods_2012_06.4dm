//%attributes = {"invisible":true}
//Method: Mods_2012_06
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/08/12, 09:06:47
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(6/8/12)
// Modified Method(s) : 
//SCPOA_PrintFormsA_FM
//  `Added missing call in PRINT3-A for SCPOA_NWSStationPrint_txt;
//  `Added call to fit SCPOA_CLCri_WLvl_txt in FVC1
// Modified Forms : 
//[ScourPOA];"FieldVerificationCardpg1"
//  `Increased vert size of SCPOA_OthScCritElev_txt

// Created Method(s) : 
//ut_MarkAsRunning
//  ` Mark a record in [ServerProcesses] as running
// Modified Method(s) : 
//ControlClientProcess
//  `Use new method ut_MarkAsRunning executed on server to mark the record as running
//BMSExternal_Transfer
//  `Use EXECUTE ON SERVER to call ut_SetNextRunTimeStamp to avoid locking of record on client.

// Modified Forms : 
//[Dialogs];"InspectConfig"
//  `Changed title of  "UWFloodBtn" to "UW Divers Activity"

// Modified Method(s) : 
//SIA_ControlDoubleClick
//  `Had to hard code the Sort Order; $SortOrder_txt was not an acceptable argument type 

// Created Method(s) : 
//ArcSin
//  ` Get the arc sin in radians of an input value
//ut_TwoPointDist 
//  ` Get the distance between two points specified as Lat Long in decimal degrees.

//**********`Modified by: Costas Manousakis-(Designer)-(6/15/12)
//****** BUG FIX *******
// Modified Form Methods : 
//[Personnel];"Inspectors In"
//  `Added boolean  PERS_NEWRECORD_B  - on the On Validate event the reocrd  is alreadey saved ( not new)

//****** END BUG FIX *******

// Created Project Form(s) : 
//"ReLogRecords"
//  ` Dialog to create activity log entries for records in tables.
// Created Method(s) : 
//ut_RelogRecords
//  ` Add activity log records to transfer creation and changes - uses form "ReLogRecords"

// Modified Method(s) : 
//SIA_ControlDoubleClick
//  `Had to hard code the Sort Order; $SortOrder_txt was not an acceptable argument type 

//**********`Modified by: Costas Manousakis-(Designer)-(6/19/12)
// Modified Method(s) : 
//ControlClientProcess
//  `Added code to record a log the actions during the execution of this method
//  `Make sure we do not launch anything if the quit flag is on; and don't go in the Delay.

//BMSExternal_Transfer
//  `Added code to record a log the actions during the execution of this method

// Modified Method(s) : 
//G_SortTable_new 
//  `remove ending _x(xxx) from fields where xxxx indicates the data type (ex _r, _s, _txt)

// Modified Method(s) : 
//SQL_ClearArrays 
//SQL_FillBuiltStatements
//  ` Addition of sp_VW_PRJ_TASKEVENTS
// Created Method(s) : 
//ut_PRJRetrieveProjectEvents
//  ` Retrieve the project events and store the latest PNF, PIF and PRC events
// Modified Method(s) : 
//ut_PRJCtrlRetrieveProjectData
//  ` Addition of ut_PRJRetrieveProjectEvents

// Modified Table(s) : 
//[PRJ_ProjectFile]
//added fields
//[PRJ_ProjectFile]PF_PNFDate_d
//[PRJ_ProjectFile]PF_PNFEvent_s
//[PRJ_ProjectFile]PF_PIFDate_d
//[PRJ_ProjectFile]PF_PIFEvent_s
//[PRJ_ProjectFile]PF_PRCApprDate_d
//[PRJ_ProjectFile]PF_PRCEvent_s
//[PRJ_ProjectFile]PF_PRCSubmDate_d

//[Preservation_Reviews]
//  `renamed from old [bridge mhd nbis TOWnline] table
//  `old fields renamed and retyped ; new fields added

//[Preservation_Meetings]
//  `renamed from old [Inspections Reserved] table

// Modified Object Methods : 
//Object Method: [Bridge MHD NBIS].Bridge Input.bDuplicate 
//  `Before getting the cell position of the listbox, check if there is anything in the hilite set

//Object Method: [Bridge MHD NBIS].Bridge Input.bOpenInsp
//  `Before getting the cell position of the listbox, check if there is anything in the hilite set - add it to the set at the end

//Object Method: [Bridge MHD NBIS].Bridge Input.ChgInspTypeBtn
//  `Before getting the cell position of the listbox, check if there is anything in the hilite set

// Modified Method(s) : 
//INSP_PrintQAForm_OM
//  `Before getting the cell position of the listbox, check if there is anything in the hilite set
//  `button available to Area Engineers,
//PRINT_QAFORM
//  `Method only available for RTN  inspections - not CUL or RTA
//  `Fix call to GetAreaBIEinfo

//INSP_PrintInspBtn_OM 
//  `Made button visible to all
//  `Before getting the cell position of the listbox, check if there is anything in the hilite set

// Modified Forms : 
//[Bridge MHD NBIS].Bridge Input
//  `added Object Method: [Bridge MHD NBIS].Bridge Input.PrintQAButton- uses method INSP_PrintQAForm_OM

//**********`Modified by: Costas Manousakis-(Designer)-(6/22/12)
// Modified Method(s) : 
//Get_BDEPT
//  `Use SQL blocks to get the arrays - removed copy named selections .

//**********`Modified by: Costas Manousakis-(Designer)-(6/25/12)
// Created Method(s) : 
//ut_MissingBINStoArray
//  ` Find Missing BINS and load them into an array

// Modified Method(s) : 
//INSP_PRINTPontis
//  `added call to G_PrintOptions before each print selection

//*********
//********* End of relesea 6.0.6
//*********

//End Mods_2012_06