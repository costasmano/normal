//%attributes = {"invisible":true}
//Method: NTI_ElemKeyTxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/21/16, 17:05:12
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	C_TEXT:C284(NTI_ElemKeyTxt; $0)  // was length of 20
	C_LONGINT:C283(NTI_ElemKeyTxt; $1)
	C_LONGINT:C283(NTI_ElemKeyTxt; $2)
	C_LONGINT:C283(NTI_ElemKeyTxt; $3)
	// Modified by: Costas Manousakis-(Designer)-(3/27/18 15:31:12)
	Mods_2018_03
	//  `addtions for protective systems
End if 
//
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 20
C_LONGINT:C283($elemKey_L; $parKey_L; $gpJey_L)
If (Count parameters:C259>0)
	$elemKey_L:=$1
	$parKey_L:=$2
	$gpJey_L:=$3
Else 
	$elemKey_L:=[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3
	$parKey_L:=[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7
	$gpJey_L:=[NTI_ELEM_BIN_INSP:183]ELEM_GRANDPARENT_KEY:25
End if 
$0:=String:C10($elemKey_L)
Case of 
	: ($parKey_L>0) & ($gpJey_L<=0)
		$0:=" > "+$0
	: ($parKey_L>0) & ($gpJey_L>0)
		$0:=" >> "+$0
End case 
//End NTI_ElemKeyTxt
