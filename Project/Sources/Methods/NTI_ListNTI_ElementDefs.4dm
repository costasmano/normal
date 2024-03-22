//%attributes = {"invisible":true}
//Method: NTI_ListNTI_ElementDefs
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/19/17, 11:46:53
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
	Mods_2018_01  //Fix Compiler issues locals not defined
	//Modified by: Chuck Miller (1/9/18 13:06:22)
	// Modified by: Costas Manousakis-(Designer)-(2022-09-28 18:39:19)
	Mods_2022_09
	//  `consider screen ht for window height
End if 
//
READ ONLY:C145(*)
Compiler_LB
Compiler_NTI
vsForward:=<>Forward
READ WRITE:C146([NTI_ELEM_DEFS:182])
ALL RECORDS:C47([NTI_ELEM_DEFS:182])
C_LONGINT:C283($Width_L; $Height_L; $Win_l)

FORM GET PROPERTIES:C674([NTI_ELEM_DEFS:182]; "ListBox_output"; $Width_L; $Height_L)
$Height_L:=MinNum(800; (Screen height:C188-100))
$Win_l:=ut_OpenNewWindow($Width_l+20; $Height_l; 0; Plain form window:K39:10; ""; "ut_CloseCancel")

DIALOG:C40([NTI_ELEM_DEFS:182]; "ListBox_output")


UNLOAD RECORD:C212([NTI_ELEM_DEFS:182])
READ ONLY:C145(*)
//End NTI_ListNTI_ElementDefs