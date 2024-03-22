//%attributes = {"invisible":true}
// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 01/17/12, 08:03:57
// ----------------------------------------------------
//Method: LB_ClearHeaders
//Description
// Clear the header vars (sort buttons) of the list box.

// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_01
End if 
//
C_LONGINT:C283($numcols)
ARRAY TEXT:C222($arrColNames_atxt; 0)
ARRAY TEXT:C222($ColHdrNames_atxt; 0)
ARRAY POINTER:C280($ColVars; 0)
ARRAY POINTER:C280($HeaderVars; 0)
ARRAY BOOLEAN:C223($colVis; 0)
ARRAY POINTER:C280($ColStyles; 0)
LISTBOX GET ARRAYS:C832(*; "SelectListBox"; $arrColNames_atxt; $ColHdrNames_atxt; $ColVars; $HeaderVars; $colVis; $ColStyles)

C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($HeaderVars))
	$HeaderVars{$loop_L}->:=0
End for 

//End LB_ClearHeaders