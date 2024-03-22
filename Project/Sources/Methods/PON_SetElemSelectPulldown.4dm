//%attributes = {"invisible":true}
// Method: PON_SetElemSelectPulldown
// Description
// Set the element Selection pulldown.
// 
// Parameters
// $1 : $elemkey_L
// $2 : $parentKey_L
// $3 : $ElemNoPulldown_ptr
// $4 : $ElemDescPullDown_ptr
// $5 : $ProtSys_b
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 17:29:13
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//

C_LONGINT:C283($1; $2)
C_POINTER:C301($3; $4)
C_BOOLEAN:C305($5)

C_LONGINT:C283($elemkey_L; $parentKey_L)
C_POINTER:C301($ElemNoPulldown_ptr; $ElemDescPullDown_ptr)
C_BOOLEAN:C305($ProtSys_b)
$elemkey_L:=$1
$parentKey_L:=$2
$ElemNoPulldown_ptr:=$3
$ElemDescPullDown_ptr:=$4
$ProtSys_b:=$5

Case of 
	: ($parentKey_L=0)
		//no parent - primary element - use primary element lists
		COPY ARRAY:C226(PON_MASTERELEM_Desc_atxt; $ElemDescPullDown_ptr->)
		COPY ARRAY:C226(PON_MASTERELEM_KEY_aL; $ElemNoPulldown_ptr->)
	: ($ProtSys_b)
		//protective system
		COPY ARRAY:C226(PON_PROTSYSELEM_Desc_atxt; $ElemDescPullDown_ptr->)
		COPY ARRAY:C226(PON_PROTSYSELEM_KEY_aL; $ElemNoPulldown_ptr->)
	: (Not:C34($ProtSys_b))
		//defect - need to get defects based on parent
		PON_FindAllowedDefects($parentKey_L; $ElemNoPulldown_ptr)
		ARRAY TEXT:C222($ElemDescPullDown_ptr->; 0)
		C_LONGINT:C283($loop_L; $indx_L)
		For ($loop_L; 1; Size of array:C274($ElemNoPulldown_ptr->))
			$indx_L:=Find in array:C230(PON_SFLAGSELEM_KEY_aL; $ElemNoPulldown_ptr->{$loop_L})
			If ($indx_L>0)
				APPEND TO ARRAY:C911($ElemDescPullDown_ptr->; PON_SFLAGSELEM_Desc_atxt{$indx_L})
			Else 
				APPEND TO ARRAY:C911($ElemDescPullDown_ptr->; "???")
			End if 
		End for 
		
		
End case 
//End PON_SetElemSelectPulldown