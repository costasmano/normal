//%attributes = {"invisible":true}
//Method: PON_INIT
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/17/15, 17:19:58
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03
End if 
//

C_DATE:C307(<>PON_NBEStartDate_d)
READ ONLY:C145([PON_ELEM_DEFS:178])
READ ONLY:C145([ACTMODLS:91])
READ ONLY:C145([CONDUMDL:93])
If (<>PON_NBEStartDate_d=!00-00-00!)
	<>PON_NBEStartDate_d:=Date:C102(ut_GetSysParameter("PON_NBEStartDate"))
End if 
C_LONGINT:C283(PON_RoundQ_L; PON_RoundP_L)
PON_RoundQ_L:=4
PON_RoundP_L:=3
C_LONGINT:C283(PON_Color_Editable_L; PON_Color_NotEditable_L; PON_Color_NBE_line_L; PON_Color_Def_line_L; PON_Color_Prot_Line_L)
PON_Color_Editable_L:=-(Black:K11:16+(256*White:K11:1))
PON_Color_NotEditable_L:=-(Black:K11:16+(256*(15*16+1)))  //light grey - 2nd block on the last row of the 4D color 'chart'
PON_Color_Def_line_L:=0x00FFFFFF
PON_Color_NBE_line_L:=0x00FFFF99
PON_Color_Prot_Line_L:=0xFFFF

//End PON_INIT