//%attributes = {"invisible":true}
//Method: NTI_BIN_LB_RowColor
//Description
//
// Parameters
// $0 :$color_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/25/16, 12:57:01
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_LONGINT:C283(NTI_BIN_LB_RowColor; $0)
	
End if 
//

C_LONGINT:C283($0)
C_LONGINT:C283($color_L)
QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
Case of 
	: ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
		$color_L:=PON_Color_Def_line_L
		//: ([PON_ELEM_DEFS]ELEM_PROTECT_SYS="Y")
		//$color_L:=0xFFFF
		
	Else 
		$color_L:=PON_Color_NBE_line_L
End case 

$0:=$color_L
//End NTI_NTI_LB_RowColor