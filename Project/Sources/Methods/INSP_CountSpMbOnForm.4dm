//%attributes = {"invisible":true}
//Method: INSP_CountSpMbOnForm
//Description
//  `Count the number of Special members on current form.
//  `will count the number of vMemberX variables on the form.
// Parameters
// $0  : $NumMembers_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/14/14, 10:36:35
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04
End if 
//
C_LONGINT:C283($0)

ARRAY TEXT:C222($objects_atxt; 0)
ARRAY POINTER:C280($vars_aptr; 0)
ARRAY LONGINT:C221($objpages_aL; 0)
FORM GET OBJECTS:C898($objects_atxt; $vars_aptr; $objpages_aL)
C_LONGINT:C283($NumMembers_L)
$NumMembers_L:=0
C_LONGINT:C283($loop_L; $tbl_L; $fld_L)
C_TEXT:C284($varName_txt)
For ($loop_L; 1; Size of array:C274($vars_aptr))
	RESOLVE POINTER:C394($vars_aptr{$loop_L}; $varName_txt; $tbl_L; $fld_L)
	
	If ($varName_txt="vMember@")
		$NumMembers_L:=$NumMembers_L+1
	End if 
	
End for 
$0:=$NumMembers_L
//End INSP_CountSpMbOnForm