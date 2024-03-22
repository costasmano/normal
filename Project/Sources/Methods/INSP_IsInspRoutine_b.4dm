//%attributes = {"invisible":true}
//Method: INSP_IsInspRoutine_b
//Description
// Return whether the inspection is one of the routine types
// Parameters
// $0 : $inspRoutine_b (true if the inspection type is one of the routine types
// $1 : $InspType_txt (optional )
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/24/13, 11:02:41
	// ----------------------------------------------------
	//Created : 
	Mods_2013_10
End if 
//
C_BOOLEAN:C305($0)
C_TEXT:C284($InspType_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$InspType_txt:=$1
Else 
	$InspType_txt:=[Inspections:27]Insp Type:6
End if 

$0:=(($InspType_txt="RT@") | ($InspType_txt="CUL") | ($InspType_txt="RRR") | ($InspType_txt="RRA") | ($InspType_txt="RRC") | ($InspType_txt="TAL") | ($InspType_txt="PED"))
//End INSP_IsInspRoutine_b