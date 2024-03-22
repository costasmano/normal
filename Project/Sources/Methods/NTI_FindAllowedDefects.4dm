//%attributes = {"invisible":true}
//Method: NTI_FindAllowedDefects
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 12:07:50
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	C_LONGINT:C283(NTI_FindAllowedDefects; $1)
	C_POINTER:C301(NTI_FindAllowedDefects; $2)
	
	// Modified by: Costas Manousakis-(Designer)-(3/22/19 11:06:46)
	Mods_2019_03
	//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.;
	//  `changed references of PON_DEFECT_LANG_TREE to NTI_DEFECT_ELEM_TREE 
End if 
//

//assume defect / element tree is loaded 

C_LONGINT:C283($1)
C_POINTER:C301($2)

C_LONGINT:C283($ElemNo_L; $ElemValue_L; $DefectNo_L)
$ElemNo_L:=$1

C_TEXT:C284($DefectValue_txt; $testValue_txt)

C_POINTER:C301($DefectArray_ptr)

$DefectArray_ptr:=$2
//clear it first
//must be longint

ARRAY LONGINT:C221($DefectArray_ptr->; 0)

C_TEXT:C284($Defect_Elemt_txt)
ARRAY TEXT:C222($ElemRefs_atxt; 0)
ARRAY TEXT:C222($DefectRefs_atxt; 0)
C_TEXT:C284($ElemRef_txt; $DefRef_txt)
C_TEXT:C284(NTI_DEFECT_ELEM_TREE)
If (NTI_DEFECT_ELEM_TREE="")
	NTI_DEFECT_ELEM_TREE:=ut_DOM_LoadXML("TIN"; "Element_DefectTree.xml")
End if 
$ElemRef_txt:=DOM Find XML element:C864(NTI_DEFECT_ELEM_TREE; "NTI_ELEMDEFECTS/Element"; $ElemRefs_atxt)

C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($ElemRefs_atxt))
	DOM GET XML ELEMENT VALUE:C731($ElemRefs_atxt{$loop_L}; $ElemValue_L)
	If ($ElemValue_L=$ElemNo_L)
		
		$DefRef_txt:=DOM Find XML element:C864($ElemRefs_atxt{$loop_L}; "Element/Defect"; $DefectRefs_atxt)
		
		C_LONGINT:C283($loop2_L)
		For ($loop2_L; 1; Size of array:C274($DefectRefs_atxt))
			DOM GET XML ELEMENT VALUE:C731($DefectRefs_atxt{$loop2_L}; $DefectNo_L)
			APPEND TO ARRAY:C911($DefectArray_ptr->; $DefectNo_L)
		End for 
		
		$loop_L:=Size of array:C274($ElemRefs_atxt)+1
	End if 
End for 
//End NTI_FindAllowedDefects