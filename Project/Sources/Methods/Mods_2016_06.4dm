//%attributes = {"invisible":true}
//Method: Mods_2016_06
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/02/16, 12:34:11
	// ----------------------------------------------------
	//Created : 
	Mods_2016_06
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(6/3/16)
// Modified Method(s) : 
//Method: m_DisplayTINs
//  `added call to InitProcessVar

//**********`Modified by: Costas Manousakis-(Designer)-(6/7/16)
// Modified Form Methods : 
//Form Method: [Dialogs];"PrintInspRpt2"
//  `Added case if inspection type is T@ (Tunnel inspection) to change print label to NTE

//**********`Modified by: Costas Manousakis-(Designer)-(6/8/16)
// Modified Method(s) : 
// Method: ut_ControlDBSycnh
// Method: ut_SQLDownloadNewRecords
//  `Added current 4D  user and machine name  to the subject of the sent mail

// Modified Method(s) : 
//INIT_FIELDS_DES
//  `sort by code tables : [FunctionalClass]; [Design Load]; [Posting Code]; [Service Over]; [Service Under]; [Material]; [Design]; [Truck Code]; [Direction]; [Deck Structure]
//  `  `[Deck Structure]; [Wearing Surface]; [Membrane]; [Deck Protection]; [Type of Work]; [Work Done By]; [Item 20 Tolls]; [Item 33 Median]
//  `  ` [Item 38]; [Item 100]; [Item 101]; [Item 111]; [Foundation Type]; [Rating Method]


//**********`Modified by: Costas Manousakis-(Designer)-(6/14/16)
// Created Form(s) : 
//[Standard Photos];"SinglePrintPhotoLand"
//[Standard Photos];"singlePhotoPortrait"

//**********`Modified by: Costas Manousakis-(Designer)-(6/15/16)
// Modified Forms : 
//[Inspections];"TunnelDamageForm"
//[Inspections];"TunnelInspection"
//[Inspections];"TunnelSpecial "
//[Inspections];"TunnelInspection"
//  `changed title of District Tunnel engr to Distr Inspection engineer

//**********`Modified by: Costas Manousakis-(Designer)-(6/17/16)
// Created Method(s) : 
//Pers_Get4DUName
// return the 4D User name of a person in Personnel table or from PersonID passed as param 1

//Method: P_LoadBINSelection
//Description
//  ` Start process with a BIN selection saved as a temp saved set file
// Parameters
// $1 : $BINSetPath_txt : path to a set file of BINs
// $2 : $WindowTitle_txt
// $3 : $Flag_txt : if not passed launch a process to run

//**********`Modified by: Costas Manousakis-(Designer)-(6/20/16)
// Modified Menu : 
//ENTER
//  `Added Tunnel Information Item after the Bridges - item disabled by default - enabled in ControlMenuBar.

// Modified Method(s) : 
//ControlMenuBar
//  `disable transfer menu items when not applicable it menu bars 1 and 2
//  `add cases for "Tunnel Information" item in the "Enter" menu

// Modified Method(s) : 
//MacroUtils 
//  `added option "FormName" to  make  form name in [tbl];"formname" format

//**********`Modified by: Costas Manousakis-(Designer)-(6/22/16)
// Modified Method(s) : 
//PON_NBE_LB_OM 
//  `combined On Selection Change with the On Clicked event to account for scrolling using the up/down arrow keys.
//PON_AddChildElem
//  `disable ADD defect/prot sys buttons after an OK ADD Record


//```
//```   **** End of Release 6.6.0 24-Jun-2016
//```

//End Mods_2016_06