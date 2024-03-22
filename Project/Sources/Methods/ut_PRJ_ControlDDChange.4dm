//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJ_ControlDDChange
// User name (OS): cjmiller
// Date and time: 11/30/06, 16:13:34
// ----------------------------------------------------
// Description
// 
//
// Parameters
//$1 pointer to field
//$2 text of message
//$3 pointer to drop down array
//$4 pointer to id array
//$5 pointer to display variable
//$6 element
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(4/24/12 14:50:39)
	Mods_2012_04
	//  `Fixed bad pointer  $ReviewID_ptr
End if 
C_POINTER:C301($1; $CurrentID_ptr)
$CurrentID_ptr:=$1
C_TEXT:C284($2; $ConfirmMessage_txt)
$ConfirmMessage_txt:=$2
C_POINTER:C301($3; $4; $5; $DisplayDropDown_ptr; $DisplayDropDownID_ptr; $Display_ptr; $ReviewID_ptr)
$DisplayDropDown_ptr:=$3
$DisplayDropDownID_ptr:=$4
$Display_ptr:=$5
C_LONGINT:C283($6; $SelectedElement_l)
$SelectedElement_l:=$6
Case of 
	: ($CurrentID_ptr->=0)
		$CurrentID_ptr->:=$DisplayDropDownID_ptr->{$SelectedElement_l}
		$Display_ptr->:=$DisplayDropDown_ptr->{$SelectedElement_l}
	: ($Display_ptr->=$DisplayDropDown_ptr->{$SelectedElement_l})  //no change
	: ($CurrentID_ptr->#$DisplayDropDownID_ptr->{$SelectedElement_l})
		CONFIRM:C162($ConfirmMessage_txt+Char:C90(13)+$Display_ptr->+" to "+Char:C90(13)+$DisplayDropDown_ptr->{$SelectedElement_l}; "Yes"; "No")
		If (OK=1)
			$Display_ptr->:=$DisplayDropDown_ptr->{$SelectedElement_l}
			//$ReviewID_ptr->:=$DisplayDropDownID_ptr->{$SelectedElement_l}
			$CurrentID_ptr->:=$DisplayDropDownID_ptr->{$SelectedElement_l}
		End if 
		
End case 
//End ut_PRJ_ControlDDChange
