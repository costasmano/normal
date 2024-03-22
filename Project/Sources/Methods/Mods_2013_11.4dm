//%attributes = {"invisible":true}
//Method: Mods_2013_11
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/01/13, 07:49:15
	// ----------------------------------------------------
	//Created : 
	Mods_2013_11
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(11/1/13)
// Modified Database Method(s) : 
//On Startup
//  `Move the trace if designer here from the Startup method
//Startup 
//  `Move the trace if designer to the database On Startup method

// Modified Table(s) : 
//[Standard Photos]
//[ElementsSafety]
//  `Enabled On Saving Existing Record Event and adjusted trigers

// Modified Method(s) : 
//M_SearchPontisElmts 
//  `Added  option to open a new window with the result set of cond units
// Modified Forms : 
//[Dialogs];"SearchPontisElmts
//  `added option check box to open a new window with the CUs

//**********`Modified by: Costas Manousakis-(Designer)-(11/4/13)
// Modified Form  : 
//[zSpecialReports];"Input"
//  `made size of fields bigger

// Modified Object Methods : 
//Object Method: [Dialogs];"Search Bridge".bFind 
//  `Added a f_TrimStr to remove extra spaces  when parsing the pasteboard

//**********`Modified by: Costas Manousakis-(Designer)-(11/5/13)
// Created Form(s) : 
//"WriteTest"

// Created Method(s) : 
//ut_Test4DWriteArea
//  `Run dialog "WriteArea" to test 4D Write text properties

// Modified Method(s) : 
//COMPILER_Utilities 
//  `added  variables for the 4D Write area test dialog

//**********`Modified by: CJ Miller-(Designer)-(11/5/13)
//ut_LoadRecord
//  `don't show message if running on server


//**********`Modified by: Costas Manousakis-(Designer)-(11/6/13)
// Modified Method(s) : 
//SIA_BridgeInput_FM 
//  `Fixed bug in hiding the ScourCritical button when there is a record in the table

//```
//```   **** End of Release 6.3.0 11/07/13
//```

//**********`Modified by: Costas Manousakis-(Designer)-(11/8/13)

// Modified Method(s) : 
//INSP_SavePhoto
//  `added missing ACCEPT statement  called only from the  save button. use optional parameter $1 to do the ACCEPT.
//  `When called from nav buttons, ACCEPT is automatic

//Compiler_Inspections 
//  `added def for INSP_SavePhoto

//TNL_SIAInpForm_FM
//  `Added code to catch changes in the  [Bridge MHD NBIS] table

// Modified Forms : 
//[TunnelInfo];"TunnelInput"
//  `removed object methods from Bridge table fields. now changes are caught from method TNL_SIAInpForm_FM

// Modified Method(s) : 
//ut_GoogleBIN
//  `Replace the word "TO" in item 6 and 7 with a "-" : causes google to think we asking for dierctioons

// Modified Object Methods : 
//Object Method: [Standard Photos].Standard Photos.vbPrintImages 
//  `moved the SAVE RECORD after call to INSP_SavePhoto

//**********`Modified by: Costas Manousakis-(Designer)-(11/13/13)

// Modified Method(s) : 
//INSP_PreviewBtn_OM 
//  `Added call to INSP_Check4DWriteChgs

//TNL_SIAInpForm_FM
//  `if Item 92vb and 93c are 'blank' hide that stuff

//ADD_COMBINED_INSPECT
//  `screen inspections created here if they are for tunnel records

//maximo_UpdateMaximo 
//  `Removed "-" between BDEPT and BIN

//**********`Modified by: Costas Manousakis-(Designer)-(11/14/13)
// Modified Method(s) : 
//ut_TestDialog
//  `was renamed from ut_Test4DWriteArea 
//  `made to run multiple forms

// Created Method(s) : 
//ut_degToDegMinSec
//  ` convert a decimal degree to degrees min decimal seconds
//  ` Parameters
//  ` $1 : $deg_r
//  ` $2 : $Deg_ptr
//  ` $3: $Min_ptr
//  ` $4: $Sec_ptr

//ut_DegMinSecToDeg
//  `convert degrees min seconds to decimal degrees
//  ` Parameters
//  ` $0 : $decDeg_r
//  ` $1 : $Degr_r
//  ` $2 : $Min_r
//  ` $3 : $sec_r

//**********`Modified by: Costas Manousakis-(Designer)-(11/18/13)
// Modified Forms : 
//[Inspections];"Closed Bridge"
//  `fixed format of contract amount to account for large numbers

// Modified Forms , form method and Re-Log button object method: 
//"ReLogRecords"
//  `added forward variable.

// Modified Method(s) : 
//COMPILER_Utilities 
//  `added vars  for the RELOG dialog

//maximo_UpdateMaximo
//  `added element no , cat,  cat desc to the  export of elementssafety ; added call to INIT_FIELDS_DES


//**********`Modified by: Costas Manousakis-(Designer)-(11/19/13)
// Created Method(s) : 
//ut_FilepathToRFC
//  ` Convert a file path to RFC format for use as a  url
//  ` will need to add the "file://" in front if passed to a web area
//  ` Parameters
//  ` $0 : $FileRFC_txt
//  ` $1 : $filePath_txt

// Modified Method(s) : 
//maximo_UpdateMaximo
//  `replaced BEGIN / End SQL updates with SQL Execute commands : the Update was not recognizing the table names


//**********`Modified by: Costas Manousakis-(Designer)-(11/20/13)
// Modified Menu(s) : 
//BridgeListMenu
//  `fixed spelling of the word Eligible

// Modified Object Methods : 
//[Inspections].TunnelInspection.aI62bCollisionDamage
//[Inspections].TunnelInspection.aI62aCollisionDamage
//  `fixed stack number for the changes on table [TunnelInspection]


//**********`Modified by: Costas Manousakis-(Designer)-(11/21/13)
// Renamed Form(s) : 
//[ServerProcesses];"Output" to [ServerProcesses];"Output-old"
// Created Form(s) : 
//[ServerProcesses];"Output" 
//  `ListBox based form


//```
//```   **** End of Release 6.3.0.a 11/22/13
//```



//End Mods_2013_11