//%attributes = {"invisible":true}
//Method: INSP_PrintRTNPage2
//Description
// Print page 2 of the RTN bridge reports
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/06/18, 17:20:04
	// ----------------------------------------------------
	//Created : 
	Mods_2018_06_bug
End if 
//
Case of 
	: ([Inspections:27]Insp Date:78<=<>InspFormRevDate_4)
		Print form:C5([Inspections:27]; "Routine Pr Pg 2")
	Else 
		Print form:C5([Inspections:27]; "RoutinePrPg2_v2")
End case 

//End INSP_PrintRTNPage2