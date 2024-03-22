//%attributes = {"invisible":true}
//Method: Pon_ElemKeytxt
//Description
// returns the text for the element key used in the NBE list box to show dependencies
// ex 
//   " > 1130" for defect of NBE
//   " >   > 1120" for defect of prot system
// Parameters
// $0 : the string 
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/19/15, 17:13:05
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 20
$0:=String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)
If ([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4>0)
	$0:=" > "+$0
End if 
If ([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19>0)
	$0:=" > "+$0
End if 
//End Pon_ElemKeytxt