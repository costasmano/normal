//%attributes = {"invisible":true}
// Method: PON_NBE_LB_RowColor
// Description
// 
// 
// Parameters
// $0 :$color_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/19/15, 17:36:10
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//

C_LONGINT:C283($0)
C_LONGINT:C283($color_L)
QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_KEY:3)
Case of 
	: ([PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4="Y")
		$color_L:=0x00FFFFFF
	: ([PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3="Y")
		$color_L:=0xFFFF
		
	Else 
		$color_L:=0x00FFFF99
End case 

$0:=$color_L
//End PON_NBE_LB_RowColor