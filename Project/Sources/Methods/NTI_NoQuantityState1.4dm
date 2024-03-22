//%attributes = {"invisible":true}
//Method: NTI_NoQuantityState1 
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/22/16, 12:22:25
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_LONGINT:C283(NTI_NoQuantityState1; $1)
	C_BOOLEAN:C305(NTI_NoQuantityState1; $0)
	// Modified by: Costas Manousakis-(Designer)-(3/22/19 11:11:49)
	Mods_2019_03
	//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
	
End if 
//
C_LONGINT:C283($1)
C_BOOLEAN:C305($0)
C_LONGINT:C283($ElemKey_L)
$ElemKey_L:=$1
C_BOOLEAN:C305($NoneState1_b)
$NoneState1_b:=False:C215

C_TEXT:C284(NTI_DEFECT_LANG_TREE; $defecttree_txt; $stateTree_txt; $attrLang_txt)
If (NTI_DEFECT_LANG_TREE="")
	NTI_DEFECT_LANG_TREE:=ut_DOM_LoadXML("TIN"; "Defect_Language.xml")
End if 
$defecttree_txt:=PON_FindDefectByValue(NTI_DEFECT_LANG_TREE; "NTIDEFECTLANG/Defect"; $ElemKey_L)
$stateTree_txt:=PON_FindDefectByValue($defecttree_txt; "Defect/State"; 1)
DOM GET XML ATTRIBUTE BY NAME:C728($stateTree_txt; "Language"; $attrLang_txt)
$NoneState1_b:=(($attrLang_txt="none") | ($attrLang_txt="not applicable"))

$0:=$NoneState1_b

//End NTI_NoQuantityState1