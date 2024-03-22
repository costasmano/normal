//%attributes = {"invisible":true}
//Method: SIA_GetItem5FromFeature
//Description
// Determine parts of Item 5 based on the feature. returns 5B, 5C, 5D, 5E.
// 5C - defaults to 1
// Parameters
// $1 : $Feature_txt
// $2 : $Item5b_ptr
// $3 : $Item5c_ptr
// $4 : $Item5d_ptr
// $5 : $Item5e_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/22/14, 15:45:51
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//
C_TEXT:C284($1)
C_POINTER:C301($2; $3; $4; $5)

C_TEXT:C284($Feature_txt)
$Feature_txt:=$1
C_POINTER:C301($Item5B_ptr; $Item5C_ptr; $Item5D_ptr; $Item5E_ptr)

$Item5B_ptr:=$2
$Item5C_ptr:=$3
$Item5D_ptr:=$4
$Item5E_ptr:=$5

C_TEXT:C284($item61_s; $item5b_s; $item5c_s; $item5e_s; $rtDir_s)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($item5d_s)  // Command Replaced was o_C_STRING length was 5
$item61_s:=Substring:C12($Feature_txt; 1; 2)

$item5b_s:="0"
$item5c_s:="1"  //assume mainline
$item5d_s:=5*"0"
$item5e_s:="0"

Case of 
	: ($item61_s="I ")
		$item5b_s:="1"
	: ($item61_s="US")
		$item5b_s:="2"
	: ($item61_s="ST")
		$item5b_s:="3"
	Else 
		$item5b_s:="5"
End case 

C_BOOLEAN:C305($numbRout_B)
$numbRout_B:=($item5b_s="1") | ($item5b_s="2") | ($item5b_s="3")

If ((Position:C15("RAMP"; Substring:C12($Feature_txt; 7))>0) & $numbRout_B)
	$item5c_s:="7"  // ramp
End if 
If ((Position:C15("EXTEN"; Substring:C12($Feature_txt; 7))>0) & $numbRout_B)
	$item5c_s:="7"  // Extention
End if 
If ((Position:C15("BYPAS"; Substring:C12($Feature_txt; 7))>0) & $numbRout_B)
	$item5c_s:="3"  // Bypass
End if 

If (($item5b_s="1") | ($item5b_s="2") | ($item5b_s="3"))
	$item5d_s:=String:C10(Num:C11(Substring:C12($Feature_txt; 3; 3)); "00000")
	C_LONGINT:C283($boundStart_L)
	$boundStart_L:=7
	If (Substring:C12($Feature_txt; 8; 1)="/")  //if there is a A as part of the route num ( US 1A/EB)
		//the direction is the next 2 chars EB,NB,etc...
		$boundStart_L:=9
	End if 
	$rtDir_s:=Substring:C12($Feature_txt; $boundStart_L; 2)
	
	Case of 
		: ($rtDir_s="NB")
			$item5e_s:="1"
		: ($rtDir_s="EB")
			$item5e_s:="2"
		: ($rtDir_s="SB")
			$item5e_s:="3"
		: ($rtDir_s="WB")
			$item5e_s:="4"
	End case 
	
End if 

$Item5B_ptr->:=$item5b_s
$Item5C_ptr->:=$item5c_s
$Item5D_ptr->:=$item5d_s
$Item5E_ptr->:=$item5e_s

//End SIA_GetItem5FromFeature