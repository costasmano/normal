//%attributes = {"invisible":true}
//Method: Mods_2014_12
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/17/14, 13:27:44
	// ----------------------------------------------------
	//Created : 
	Mods_2014_12
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(12/17/14)
// Modified Table(s) : 
//[Inspections]
//  `Added fields [Inspections]InspCompleteDate [Inspections]InspDBIEReviewDate [Inspections]InspAIEReviewDate
//  `to allow tracking of completion and reviews

//**********`Modified by: Costas Manousakis-(Designer)-(12/19/14)
// Modified Table(s) : 
//[Inspections]
//  `Added field [Inspections]InspFldWorkComplDate
//  `in addition to fields added 12/17/14

// Modified Method(s) : 
//PushAllChanges
//  `added check if filed number is valid.

//**********`Modified by: Costas Manousakis-(Designer)-(12/19/14)
// Modified Method(s) : 
//SQL_Errors
//  `Clear the ODBC_SetErrorHandler



//**********`Modified by: Costas Manousakis-(Designer)-(12/27/14)
// Modified Table(s) : 
//[Pontis_Metrics]
//  `changed field [Pontis_Metrics]PM_Tev_l to a real

// Modified Method(s) : 
//SQL_ClearArrays 
//SQL_FillBuiltStatements 
//PM_ControlMetricRetrieve 
//Compiler_SPRetrieve 
//  `changes due to field [Pontis_Metrics]PM_Tev_l changed to  Real from longint


// Created Method(s) : 
//PON_ExportCU2Migrator
//>> Export cond units in xml format for AASHTOWARE migrator
//>> requires CUEXPORTTEMPLATE.xml in NBE folder of Resources

//to export cond  unit data for import to AASHTOWARE migrator
//Compiler_PON
//  `compiler directives
// PON_PREPAREELMTDATA
//  ` load needed records and variables

//  PON_INSPID2INSPKEY
//  ` convert and inspection id _L to a BrM INSPKEY


//End Mods_2014_12