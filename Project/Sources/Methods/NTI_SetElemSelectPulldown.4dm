//%attributes = {"invisible":true}
//Method: NTI_SetElemSelectPulldown
//Description
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
	//Date and time: 04/22/16, 12:05:58
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_LONGINT:C283(NTI_SetElemSelectPulldown; $1; $2)
	C_POINTER:C301(NTI_SetElemSelectPulldown; $3; $4)
	C_BOOLEAN:C305(NTI_SetElemSelectPulldown; $5)
	
	// Modified by: Costas Manousakis-(Designer)-(3/21/18 12:17:44)
	Mods_2018_03
	//  `added protective system.
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
If (Count parameters:C259>4)
	$ProtSys_b:=$5
Else 
	$ProtSys_b:=False:C215
End if 

Case of 
	: ($parentKey_L=0)
		//no parent - primary element - use primary element lists
		If ([NTI_ELEM_DEFS:182]ELEM_TIN_ONLY:19="Y")
			COPY ARRAY:C226(NTI_MASTER_TIN_Desc_atxt; PON_ELEMSELECT_atxt)
			COPY ARRAY:C226(NTI_MASTER_TIN_KEY_aL; PON_ELEMSELECT_aL)
		Else 
			COPY ARRAY:C226(NTI_MASTERELEM_Desc_atxt; PON_ELEMSELECT_atxt)
			COPY ARRAY:C226(NTI_MASTERELEM_KEY_aL; PON_ELEMSELECT_aL)
		End if 
	: ($ProtSys_b)  //  `protective system - allowing all prot systems
		
		COPY ARRAY:C226(NTI_PROTSYSELEM_Desc_atxt; $ElemDescPullDown_ptr->)
		COPY ARRAY:C226(NTI_PROTSYSELEM_KEY_aL; $ElemNoPulldown_ptr->)
		
	: (Not:C34($ProtSys_b))
		//defect - need to get defects based on parent
		NTI_FindAllowedDefects($parentKey_L; $ElemNoPulldown_ptr)
		ARRAY TEXT:C222($ElemDescPullDown_ptr->; 0)
		C_LONGINT:C283($loop_L; $indx_L)
		For ($loop_L; 1; Size of array:C274($ElemNoPulldown_ptr->))
			$indx_L:=Find in array:C230(NTI_SFLAGSELEM_KEY_aL; $ElemNoPulldown_ptr->{$loop_L})
			If ($indx_L>0)
				APPEND TO ARRAY:C911($ElemDescPullDown_ptr->; NTI_SFLAGSELEM_Desc_atxt{$indx_L})
			Else 
				APPEND TO ARRAY:C911($ElemDescPullDown_ptr->; "???")
			End if 
		End for 
		
End case 
//End NTI_SetElemSelectPulldown