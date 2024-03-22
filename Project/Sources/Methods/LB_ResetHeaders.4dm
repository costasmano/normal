//%attributes = {"invisible":true}
//Method: LB_ResetHeaders
//Description
// Reset the headers for a listbox to clear sort indicators
// Parameters
// $1 : $LB_name : name of listbox object
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-04T00:00:00, 19:20:23
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
	
	C_TEXT:C284(LB_ResetHeaders; $1)
End if 
//
C_TEXT:C284($1; $LB_name)
$LB_name:=$1
ARRAY TEXT:C222($ColNames_atxt; 0)
ARRAY TEXT:C222($HeaderNames_atxt; 0)
ARRAY POINTER:C280($ColVars_aptr; 0)
ARRAY POINTER:C280($headerVars_aptr; 0)
ARRAY BOOLEAN:C223($ColVis_ab; 0)
ARRAY POINTER:C280($Styles_aptr; 0)
LISTBOX GET ARRAYS:C832(*; $LB_name; $ColNames_atxt; $HeaderNames_atxt; $ColVars_aptr; $headerVars_aptr; $ColVis_ab; $Styles_aptr)

C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($headerVars_aptr))
	$headerVars_aptr{$loop_L}->:=0
End for 

//End LB_ResetHeaders