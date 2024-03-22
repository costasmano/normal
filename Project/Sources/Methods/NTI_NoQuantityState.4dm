//%attributes = {"invisible":true}
//Method: NTI_NoQuantityState
//Description
//
// Parameters
// $0 : $NoQFlag_L
// $1 : $Elem_Key_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/17/18, 17:25:34
	// ----------------------------------------------------
	//Created : 
	Mods_2018_01
	
	C_LONGINT:C283(NTI_NoQuantityState; $0)
	C_LONGINT:C283(NTI_NoQuantityState; $1)
	// Modified by: Costas Manousakis-(Designer)-(3/22/19 11:11:49)
	Mods_2019_03
	//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
	
End if 
//

C_LONGINT:C283($ElemKey_L)
$ElemKey_L:=$1
C_LONGINT:C283($NoQFlag_L)
$NoQFlag_L:=0
C_BOOLEAN:C305($NoneState1_b)
C_TEXT:C284(NTI_DEFECT_LANG_TREE; $defecttree_txt; $stateTree_txt; $attrLang_txt)
If (NTI_DEFECT_LANG_TREE="")
	NTI_DEFECT_LANG_TREE:=ut_DOM_LoadXML("TIN"; "Defect_Language.xml")
End if 
$defecttree_txt:=PON_FindDefectByValue(NTI_DEFECT_LANG_TREE; "NTIDEFECTLANG/Defect"; $ElemKey_L)
C_LONGINT:C283($CS_L)
For ($CS_L; 1; 4)
	$stateTree_txt:=PON_FindDefectByValue($defecttree_txt; "Defect/State"; $CS_L)
	DOM GET XML ATTRIBUTE BY NAME:C728($stateTree_txt; "Language"; $attrLang_txt)
	$NoneState1_b:=(($attrLang_txt="none@") | ($attrLang_txt="not applicable") | ($attrLang_txt=""))
	If ($NoneState1_b)
		$NoQFlag_L:=$NoQFlag_L ?+ $CS_L
	Else 
		$NoQFlag_L:=$NoQFlag_L ?- $CS_L
	End if 
End for 

$0:=$NoQFlag_L
//End NTI_NoQuantityState