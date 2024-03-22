//%attributes = {"invisible":true}
//Method: NTI_INIT
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/25/16, 11:42:35
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(2/14/18 12:13:06)
	Mods_2018_02
	//  `
	// Modified by: Costas Manousakis-(Designer)-(4/27/18 17:12:57)
	Mods_2018_04
	//  `added NTI_DROPBINBTSINSPDATE
	// Modified by: Costas Manousakis-(Designer)-(3/22/19 11:11:49)
	Mods_2019_03
	//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
End if 
//

READ ONLY:C145([NTI_ELEM_DEFS:182])
C_LONGINT:C283(PON_RoundQ_L; PON_RoundP_L)
PON_RoundQ_L:=4
PON_RoundP_L:=3
C_LONGINT:C283(PON_Color_Editable_L; PON_Color_NotEditable_L; PON_Color_NBE_line_L; PON_Color_Def_line_L; PON_Color_Prot_Line_L)
PON_Color_Editable_L:=-(Black:K11:16+(256*White:K11:1))
PON_Color_NotEditable_L:=-(Black:K11:16+(256*(15*16+1)))  //light grey - 2nd block on the last row of the 4D color 'chart'
PON_Color_Def_line_L:=0x00FFFFFF
PON_Color_NBE_line_L:=0x00FFFF99
PON_Color_Prot_Line_L:=0xFFFF

C_TEXT:C284(NTI_DEFECT_ELEM_TREE; NTI_DEFECT_LANG_TREE)
If (NTI_DEFECT_ELEM_TREE="")
	NTI_DEFECT_ELEM_TREE:=ut_DOM_LoadXML("TIN"; "Element_DefectTree.xml")
	
End if 
If (NTI_DEFECT_LANG_TREE="")
	NTI_DEFECT_LANG_TREE:=ut_DOM_LoadXML("TIN"; "Defect_Language.xml")
	
End if 
C_TEXT:C284($NTI_DROPBININSPDATE_txt)
$NTI_DROPBININSPDATE_txt:=ut_GetSysParameter("NTI_DROPBININSPDATE")
C_DATE:C307(NTI_DROPBININSPDATE; NTI_DROPBINBTSINSPDATE)
NTI_DROPBININSPDATE:=Date:C102($NTI_DROPBININSPDATE_txt)
$NTI_DROPBININSPDATE_txt:=ut_GetSysParameter("NTI_DROPBINBTSINSPDATE")
NTI_DROPBINBTSINSPDATE:=Date:C102($NTI_DROPBININSPDATE_txt)

//End NTI_INIT