//%attributes = {"invisible":true}
//Method: Mods_2015_05
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/08/15, 12:29:10
	// ----------------------------------------------------
	//Created : 
	Mods_2015_05
End if 

//
//**********`Modified by: Costas Manousakis-(Designer)-(5/4/15)
// Modified Method(s) : 
//maximo_UpdateMaximo
//  `move counter of photos sent/updated after the SQL 


//**********`Modified by: Costas Manousakis-(Designer)-(5/15/15)
// Modified Method(s) : 
//G_SortTable_new
//  `treat fields for tables LSS_@ and DCM_@ same as the PRJ_@

//**********`Modified by: Costas Manousakis-(Designer)-(5/15/15)
// Modified Method(s) : 
//INSP_ElmSft_Input_FM 
//  `for WET elements hide the Special member checkbox per req D.Kent 5/15/2015

//**********`Modified by: Costas Manousakis-(Designer)-(5/19/15)
// Modified Method(s) : 
//INIT_FIELDS_DES
//  `sort the inspection responsibilty arrays by description


//**********`Modified by: Costas Manousakis-(Designer)-(5/20/15)
// Created Method(s) : 
//Method: MAP_BubbleCode_s
//Description
//  ` return a two digit bubble code from a number. code based on 0-9,a-z,A-Z
// Parameters
// $0 : $bubbleCode_s
// $1 : $Index_L

// Modified Method(s) : 
//Compiler_MAP
//  `added  MAP_BubbleCode_s

//**********`Modified by: Costas Manousakis-(Designer)-(5/22/15)
// Created Method(s) : 
//SCPOA_SetControl
//  ` method to be called from menu bar. uses the selected menu item parameter

// Created Menu bar: 
//ScourPOAMenu
//  `menu bar for the ScourPOA review Screen

// Modified Method(s) : 
//SCPOA_ListPOAs
//  `use the new ScourPOAMenu menubar

// Modified Form Methods : 
//[ScourPOA];"Output"
//  `Allow access to Quick report button to Designers and  personnel group SCPOA_ProjManager
//  `Added menu ScourPOAMenu to the form

//**********`Modified by: Costas Manousakis-(Designer)-(5/26/15)
// Modified Method(s) : 
//ut_GoogleBIN
//  `Adjusted the prompt for BING or Gorissen
//  `also use system parameters for the different searches.

//**********`Modified by: Costas Manousakis-(Designer)-(5/27/15)
// Modified Method(s) : 
//SCPOA_Variables 
//  `added  action = LOADFROMBLOB - call tjhat from the LOAD action.  can be used to load Blob data in reports or outputscreens.

// Modified Forms : 
//[ScourPOA];"Output"
//  `added Item 113 from POA and ITem 113 from BIN; Call SCPOA_Variables ("LOADFROMBLOB") in OnDisplayDetail event

// Modified Method(s) : 
//SCPOA_POABtnCtrl
//  `remove M Nabulsi from the edit group 

//**********`Modified by: Costas Manousakis-(Designer)-(5/29/15)
// Modified Method(s) : 
//maximo_UpdateMaximo
//  `when sending manually , allow specification of a thumbnail factor for the photos;`
//  `when factor is > 1 a thumbnail is created and sent.  This is only available when doing a manual transfer.
//  `added a system parameter max_SendPicSep to send the picture blob separately from the other fields
//  `values are TRUE or anything else. if the value is not TRUE or parameter is not found the pict blob is sent with 
//  `the rest of the data.

//G_WRT_MakeDocument
//  `added code to resize the inserted  picture in the body of the document so that it fits in the original picture area.
//LTR_GenerateVertCLPic
//  `testing svg - comment out svg code for compiling- run 4D chart code 
//LTR_GenerateTruckPic
//  `testing svg -  use method LTR_GetTruckPostPic - run 4D chart code only

// Created Method(s) : 
//LTR_GetTruckPostPic
//  `get a truck posting sign picture from SVG
// Parameters
// $0 : $Picture_pic
//  `svg code has been commented out for compiling

//End Mods_2015_05