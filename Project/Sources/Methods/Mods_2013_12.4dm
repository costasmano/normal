//%attributes = {"invisible":true}
//Method: Mods_2013_12
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/02/13, 10:55:27
	// ----------------------------------------------------
	//Created : 
	Mods_2013_12
End if 

//**********`Modified by: Costas Manousakis-(Designer)-(12/2/13)
// Modified Object Methods : 
//CloneTables.FieldNames_atxt
//  `index > 0 not 1

// Created Method(s) : 

//Compiler_MAP 

//MAP_GetData
//  ` collect data in arrays from a list of bridge records to be passed on to a html template

//MAP_GetTownCenterLatLong 
//  ` Load the center lat and long of a town - uses only NBI records with ite16a, 17a > 0 and gets the average
// Parameters
// $1 : $townName_txt
// $2 : $Lat_ptr
// $3 : $Lon_ptr

//MAP_OutOfStateBoundary_b 
//  ` return true or false if lat long coords are within a squeare boundary defined by the MA outline
// Parameters
// $0 : $outofBoundary_b
// $1 : $lat_r
// $2 : $long_r

//
//**********`Modified by: Costas Manousakis-(Designer)-(12/3/13)
// Modified Method(s) : 
//G_InspExtraCmtsBtn
//  `added 4th optional param for the change stack number
//Compiler_Inspections
//  `added G_InspExtraCmtsBtn and moved method declarations from Compiler_methods


// Modified Object Methods : 
//[Inspections];"TunnelInspection".vbI62bCollcmts
//[Inspections];"TunnelInspection".vbI62aCollcmts
//  `fix bug of wrong change stack


//**********`Modified by: Costas Manousakis-(Designer)-(12/6/13)
// Modified Method(s) : 
//maximo_UpdateMaximo 

// Created Method(s) : 
//maximo_SetProcessFlag 
//  `Change the current setting of the Process for Maximo flag on the server

// Modified Method(s) : 
//Compiler_maximo 

// Modified Forms : 
//[ElementsSafety]."SafetyElmtTemplate".Button 
//  `Added button [ElementsSafety].SafetyElmtTemplate.Button  to show record id and element num in elemt dictionary

//**********`Modified by: Costas Manousakis-(Designer)-(12/9/13)
// Modified Method(s) : 
//GetParentPrefix 
//  `Added  the case for Tunnel inspections

//G_GetElmtLabel 
//  `For Tunnel categories remove the descr of the category from the title ; left only 62a,b,c, etc.
//  `Also add a "." between the itemtitle and the element title


//**********`Modified by: Costas Manousakis-(Designer)-(12/12/13)

// Modified Method(s) : 
//ut_GoogleBIN
//  `replace  apostrophe (quote) and back apostrophe with space

//```
//```   **** End of Release 6.0.3.b 2013-12-16
//```


//**********`Modified by: Costas Manousakis-(Designer)-(12/16/13)
// Modified Method(s) : 
//UT_SET_Control 
//  `Added the INTERSECTION option

// Created Method(s) : 
//LB_IntersectSet
//  `Create an intersection of two sets
//M_IntersectSet 
//  `Create an intersection of two sets of Bridge table

// Modified Menu Bar(s) : 
//LB_Custom
//BridgeListMenu
//  `Added item for LB_IntersectSet in the Records menu

//```
//```   **** Start of Release 6.0.3.c 2013-12-19
//```


//**********`Modified by: Costas Manousakis-(Designer)-(12/19/13)
// Modified Forms : 
//[Inspections];"TunnelRoutinePg1"
//  `added variables for vrSup_1, vRSup_14 per request D. Kent

//```
//```   **** End of Release 6.0.3.c 2013-12-19
//```


// Add ability to skip add record errors for certain tables
//Modified by: Charles Miller (12/19/13 14:08:34)
//New record in parameters table
//IgnoreDuplicateKeys
//Compiler_TransfLog
//ut_ControlDBSycnh
//ut_SQLTellServerNRC
//ut_SQLCreateNewRecord


//**********`Modified by: Costas Manousakis-(Designer)-(12/23/13)
// Modified Method(s) : 
//SETUTIL_Control
//  `Added INTERSECT task ; a tag at the beginnig of the set file; a return boolean if all is ok;
//  `Adjusted method of saving set file - added 4st extension

//COMPILER_Utilities 
//  `SETUTIL_Control

// Created Method(s) : 
//PRJ_SETUTILITY
//  `Perform set operations for Projectdetail records based on record ID

// Modified Method(s) : 
//PRJ_SubtractSet 
//PRJ_LoadSet 
//PRJ_AddSet 
//PRJ_SaveSet 
//  `use method PRJ_SETUTILITY

// Created Method(s) : 
//PRJ_IntersectSet

//Compiler_PRJ 
//  `moved declarations of methods from Compiler_methods to here ; added PRJ_SETUTILITY

//Compiler_LB 
//  `moved methods from Compiler_methods

//Compiler_Clone 
//  `moved methods from Compiler_methods

//**********`Modified by: Costas Manousakis-(Designer)-(12/24/13)
// Modified Method(s) : 
// PM_ControlMetricRetrieve
//  `added a SAVE RECORD after each CREATE RECORD([Pontis_Metric_Data]) - without it, it kept using the same record.


//**********`Modified by: Costas Manousakis-(Designer)-(12/30/13)
// Modified Method(s) : 
//ut_LoadUserLoginInformation
//  `fixed the update progress bar since the loop is  in reverse order

// Modified Method(s) : 
//CreateRandomSetinConsltAddress 
//CreateRandomSetinConsInspection
//CreateRandomSetinCI_Contract 
//CreateRandomSetinBridgeDesign 
//CreateRandomSet
//CreateRandomSetinTownAddress 
//CreateRandomSetinCR_Contract 
//CreateRandomSetinConsltRating
//  `Instead of blanking the search variables,  leave them with a space as a workaround for the v13  upgrade.

//End Mods_2013_12