//%attributes = {"invisible":true}
//Method: PON_FindAllowedDefects
//Description
// Find allowed defects for an element
// Parameters
// $1 : $ElemNo_L
// $2 : $DefectList_Ptr  : pointer to a longint array
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 17:25:10
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
	// Modified by: Costas Manousakis-(Designer)-(3/22/19 11:11:49)
	Mods_2019_03
	//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
	
	C_LONGINT:C283(PON_FindAllowedDefects; $1)
	C_POINTER:C301(PON_FindAllowedDefects; $2)
	
End if 

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
C_TEXT:C284(PON_DEFECT_ELEM_TREE)
If (PON_DEFECT_ELEM_TREE="")
	PON_DEFECT_ELEM_TREE:=ut_DOM_LoadXML("NBE"; "Element_DefectTree.xml")
End if 
$ElemRef_txt:=DOM Find XML element:C864(PON_DEFECT_ELEM_TREE; "Root/Element"; $ElemRefs_atxt)

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
//End PON_FindAllowedDefects