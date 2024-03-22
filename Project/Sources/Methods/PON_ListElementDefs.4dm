//%attributes = {"invisible":true}
//Method: PON_ListElementDefs
//Description
// List the Element defs from table [PON_ELEM_DEFS]
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Sep 28, 2022, 17:16:48
	Mods_2022_09
	// ----------------------------------------------------
	
End if 
//
READ ONLY:C145(*)
Compiler_LB
Compiler_PON
vsForward:=<>Forward
READ WRITE:C146([PON_ELEM_DEFS:178])
ALL RECORDS:C47([PON_ELEM_DEFS:178])
C_LONGINT:C283($Width_L; $Height_L; $Win_l)

FORM GET PROPERTIES:C674([PON_ELEM_DEFS:178]; "Output_LB"; $Width_L; $Height_L)
$Height_L:=MinNum(800; (Screen height:C188-100))
$Win_l:=ut_OpenNewWindow($Width_l+20; $Height_l; 0; Plain form window:K39:10; ""; "ut_CloseCancel")

DIALOG:C40([PON_ELEM_DEFS:178]; "Output_LB")

UNLOAD RECORD:C212([PON_ELEM_DEFS:178])
READ ONLY:C145(*)

//End PON_ListElementDefs   