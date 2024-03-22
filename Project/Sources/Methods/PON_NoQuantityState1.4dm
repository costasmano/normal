//%attributes = {"invisible":true}
// Method: PON_NoQuantityState1
// Description
// return true if in the language indicates that there is no quantity in state 1
// 
// Parameters
// $0 : $NoneState1_b
// $1 : $ElemKey_L
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 17:35:47
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
	// Modified by: Costas Manousakis-(Designer)-(3/22/19 11:11:49)
	Mods_2019_03
	//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
End if 
C_LONGINT:C283($1)
C_BOOLEAN:C305($0)
C_LONGINT:C283($ElemKey_L)
$ElemKey_L:=$1
C_BOOLEAN:C305($NoneState1_b)
$NoneState1_b:=False:C215

C_TEXT:C284(PON_DEFECT_LANG_TREE; $defecttree_txt; $stateTree_txt; $attrLang_txt)
If (PON_DEFECT_LANG_TREE="")
	PON_DEFECT_LANG_TREE:=ut_DOM_LoadXML("NBE"; "Defect_Language.xml")
End if 
$defecttree_txt:=PON_FindDefectByValue(PON_DEFECT_LANG_TREE; "Root/Defect"; [PON_ELEM_INSP:179]ELEM_KEY:3)
$stateTree_txt:=PON_FindDefectByValue($defecttree_txt; "Defect/State"; 1)
DOM GET XML ATTRIBUTE BY NAME:C728($stateTree_txt; "Language"; $attrLang_txt)
$NoneState1_b:=(($attrLang_txt="none") | ($attrLang_txt="not applicable"))

$0:=$NoneState1_b

//End PON_NoQuantityState1