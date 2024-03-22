//%attributes = {"invisible":true}
//Method: INSP_ResetToOnlyImages
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 05/06/21, 15:21:39
	// ----------------------------------------------------
	//Created : 
	Mods_2021_05  //Add code to allow for addition/ replacement/ or viewing of SIA aND QA FORMS
	// Modified by: Costas Manousakis-(Designer)-(7/14/21 10:39:22)
	Mods_2021_07
	//  `use BMS constants for types
	
End if 
//
ARRAY TEXT:C222($PhotoTypes_atxt; 3)
$PhotoTypes_atxt{1}:=BMS Sketch
$PhotoTypes_atxt{2}:=BMS Chart
$PhotoTypes_atxt{3}:=BMS Photo
QUERY SELECTION WITH ARRAY:C1050([Standard Photos:36]PictType:5; $PhotoTypes_atxt)
ARRAY TEXT:C222($PhotoTypes_atxt; 0)

//End INSP_ResetToOnlyImages