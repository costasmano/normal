//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/09/06, 09:56:51
	// ----------------------------------------------------
	// Method: F_CompareVars
	// Description
	// Compare two variables
	// 
	// Parameters
	// $0 : Boolean = Vars equal
	// Ptr 1 - Pointer to var 1
	// Ptr 2 - Pointer to var 2
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/10/2006 09:24:29)
	Mods_2006_CM03
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

C_BOOLEAN:C305($0; $VarsEq_b)
C_POINTER:C301($1; $2; $var_ptr1; $var_ptr2)
$var_ptr1:=$1
$var_ptr2:=$2
C_LONGINT:C283($VarType1_L; $VarType2_L; $position_l)
$VarType1_L:=Type:C295($var_ptr1->)
$VarType2_L:=Type:C295($var_ptr2->)
$VarsEq_b:=True:C214
If ($VarType1_L#$VarType2_L)
	$VarsEq_b:=False:C215
Else 
	C_TEXT:C284($text_txt; $SearchType_txt)
	$text_txt:=",0,24,2,1,8,9,4,11,6,3,"  //variable/field types
	$SearchType_txt:=","+String:C10($VarType1_L)+","
	$position_l:=Position:C15($SearchType_txt; $text_txt)
	If ($position_l>0)
		$VarsEq_b:=($var_ptr1->=$var_ptr2->)
	Else 
		$VarsEq_b:=False:C215
	End if 
End if 

$0:=$VarsEq_b