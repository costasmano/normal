//%attributes = {"invisible":true}
//Method: Mods_2014_02
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/12/14, 13:53:48
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
End if 
//

// Modified Method(s) : 
//Clone_ArrayToSelection
//  ` recreated on 02/04/2014

//**********`Modified by: Costas Manousakis-(Designer)-(2/21/14)
// Modified Method(s) : 
//ut_MoveElements
//  `Added the automatic setting of the RemoteType_al 
//maximo_UpdateMaximo
//  `made  SQL connection name a variable and prompt to pick which connection to send to


//**********`Modified by: Costas Manousakis-(Designer)-(2/25/14)
// Created Method(s) : 
//ut_ParseVersionString
//  ` Parse a text sring containing a version into a text array passed as a pointer
// Parameters
// $1 ; $String_txt
// $2 : $PartsArray_ptr

//ut_CompareParts_L
//  ` parts are either numeric or alpha - if numeric compare value, if alpha compare string
//  ` no error if not the same.  it is set by the second param.
// Parameters
// $0 : $comp_L (0:equal ; 1 : gt ; -1: lt)
// $1 : $t1_txt
// $2 : $t2_txt

//ut_VersionCheck
//  ` Compare current db version ($CheckVersion_txt) with an input value ($targetVers_txt)
//  ` Versions are in form NN.NN.NN.A
//  `  ` where NN any number
//  `  ` A any letter
// Parameters
// $0 : $check_L (-1 : less than ; 0 : equal ; 1 : greater)
// $1 : $targetVers_txt
// $2 : $CheckVersion_txt (Optional)

//ut_UpdateSysParameter
//Description
//Update or Create a system parameter. (create is only available for design group users)
// Parameters
// $1 : $ParamName_txt
// $2 : $Additional_txt - additional text to be shown with the prompt
// $3 : $EditValue_txt optional : if it starts with "V" the value field will be updated ; else the description field (default)

//ut_ComboMenuC
// manage a combo menu
// Parameters
// $1 : $ComboMenu_ptr
// $2 : $Data_ptr

// Modified Forms : 
//[Bridge MHD NBIS];"Bridge Input"
//  `Added button and page 12 for Rating Requests

// Modified Method(s) : 
//SIA_ControlDoubleClick
//  `Added page 12 - Rating requests

//**********`Modified by: Costas Manousakis-(Designer)-(2/26/14)
// Added Table(s) : 
//[RatingRequests]
//[AddtlRatingRequests]

// Created Method(s) : 
//  RtgReq_AdtlLB_OM
//  ` Object method for the Additional request list box
// Parameters
// $1 : $FormEvent_L

// RtgReq_ComboMenu_OM
//Description
//  ` method for Combomenus in rating request input forms
// Parameters

// RtgReq_DisplayList
//  ` display the list of all rating requests
// Parameters

// RtgReq_GetBridgeInfo
//  ` retrieve a field from a BIN return it as string 80
// Parameters

//  RtgReq_Utility
//  ` Utiltiy method  for RatingRequests
//  ` Parameters
//  ` $1 : $Task_txt ("SETUPSYSPARAMS" | "STARTOUTPUTLIST" | "DEFAULTSORT" | "LOADCBARRAYS" | 
//  `  ` "LOADCONTRACTS" | "LOADASSIGNMENTS"

//  RtgReq_LB_OM
//  ` method for the rating requests list box in the output form
// Parameters
// $1 : $FormEvent_L

//  RtgReq_Output_FM
//  ` Method for the output form of rating requests
// Parameters
// $1 : $FormEvent_L

// RtgReq_SortByPriority
//  `Sorting function to sort a rating request list by priority
// Parameters

//RtgReq_AdtlInp_FM
//  ` Form method for Adtl rating request input form

//RtgReq_Edit_b
//  ` determine whether rating req is editable

//RtgReq_Input_FM
//  ` Method for input form for Rating Requests

//Method: Compiler_RatingRequests

// Method: LB_Tasks
//  ` Do various tasks on a listbox
// Parameters
// $1 : $Task_txt ("SETWINDOWTITLE" | "SHOWALL" | "SHOWSELECTION" | "OMITSELECTION" | "CLEARHEADERS" | "QUERY" | "QUERYSELECTION"
// "ORDER" | "DESELECTALL")

//Method: LB_MenuTasks
//  ` Execute method LB_Tasks from a menu item with a parameter

// Created Form(s) : 
//[RatingRequests];"Output"
//[AddtlRatingRequests];"Output"
//[AddtlRatingRequests];"Input"
//[RatingRequests];"Input"

// Modified Form : 
//[Bridge MHD NBIS];"Bridge Input"
//  `Added Ratting Request button and page 12 forr rating requests

// Created Menu(s) : 
//RtgReqMenu

// Modified Method(s) : 
//SIA_ControlDoubleClick
//  `Added page 12 - Rating requests
//SIA_BridgeInpNavCTRL
//  `Added page 12 - Rating requests


//**********`Modified by: Costas Manousakis-(Designer)-(2/27/14)
// Created Method(s) : 
//FRZ_PrintPageUtil_A
//  ` Fill the print variables for page 1 of the Freeze thaw inspection - the new version effective ◊InspFormRevDate_7

// Created Form(s) : 
//[Inspections];"FrzThawPg1A"
//[Inspections];"FreezeThawA"
//[ElementsSafety];"FreezeThawInp_1A"
//  `New Freeze Thaw

// Modified Method(s) : 
//INIT_UI_GV
//  `New Freeze thaw date effective 1/1/2014 ◊InspFormRevDate_7

//Print_Freeze_pg1
//  `New Freeze thaw
//INSP_FRZ_PrintCmts 
//  `New Freeze thaw

// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"

//COMPILER_Inspections
//  `Freeze thaw vars

// Modified Method(s) : 
//SIA_BridgeInput_FM
//  `Added call to SET MENU BAR("BLANKMENU") to avoid  actions from Quick report where the selection is chaanged

// Modified Table(s) : 
//[RAILBridgeInfo]`
//Added fields
//[RAILBridgeInfo]Rating_315K
//[RAILBridgeInfo]Rating_315K_Max
//[RAILBridgeInfo]Rating_315K_fatigue_R


//**********`Modified by: Costas Manousakis-(Designer)-(2/28/14)
//****
// If the Bridgelist menu bar (2) was active, in the BridgeInput form or further in, some of the reports 
// would reset the selection and current record
//****
// Modified Method(s) : 
//SIA_MountModule
//  `Removed   `ControlMenuBar (2) at the end. Left at BlankMenu
//SIA_BridgeInput_FM
//  `Added call to SET MENU BAR("BLANKMENU") to avoid  actions from Quick report where the selection is chaanged
//SCPOA_ScourInpButton_OM
//  `removed controlmenubar(2) at the end.  The  Quiclk Report command re-set the selection


//End Mods_2014_02