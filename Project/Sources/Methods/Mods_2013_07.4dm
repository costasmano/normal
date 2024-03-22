//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 07/08/13, 16:34:45
//----------------------------------------------------
//Method: Mods_2013_07
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_07  //r001 ` 
	//Modified by: Charles Miller (7/8/13 16:34:46)
	
End if 
//Add variable zz1 to so that for existing records cursor would not start in contract number field as one was blanked  out
//[Contracts];"Contracts In"

//**********`Modified by: Costas Manousakis-(Designer)-(7/29/13)
// Modified Forms : 
//[Inspections];"CustomInput"
//  `Added button and modified object methods to allow editing of inspection type

// Modified Method(s) : 
//G_Insp_ApplyRev2_PR
//  `added other agencies to the exception list

// Modified Forms : 
//[Inspections];"Closed Insp Pg1"
//[Inspections];"Culvert Pr Pg 1"
//[Inspections];"CulvertPrPg1_v2"
//[Inspections];"Damage Pg1"
//[Inspections];"DamagePg1_v2"
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"FCPrPg1_v2"
//[Inspections];"PedBridge_p1"
//[Inspections];"Railfc_rr_p1"
//[Inspections];"RailRoutine Arch Pr Pg 1"
//[Inspections];"RailRoutine Culvert"
//[Inspections];"RailRoutinePrPg1"
//[Inspections];"Routine Arch Pr Pg 1"
//[Inspections];"Routine Pr Pg 1"
//  `Modified print forms for MBTA to display the title MBTA Area engineer only.

//[Inspections];"InspectionReview"
//  `Removed the MBTA QC, QA labels.  use only Review apprv labels

//**********`Modified by: Costas Manousakis-(Designer)-(7/31/13)
// Modified Method(s) : 
//ut_SynchFromProdForPreservation
//  `added output of errors.
//  `re set the error after each table
//  `do not Save record right after creating a new one before doing the update of fields

//ut_SynchFromProd 
//  `Renamed method to ut_SynchFromProd from ut_SynchFromProdForPreservation

// Created Method(s) : 
//Server_SynchFromProd 
//  `  Run ut_SynchFromProd in a server process


//End Mods_2013_07