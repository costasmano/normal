//%attributes = {"invisible":true}
//Method: PON_FindAllowedProtSys
//Description
// Find allowed protective systems for an element
// uses Resource file NBE/Element_ProtSys.xml or Parameter NBE_ElemProtTree (defined in RES_PARAM_XREF parameter)
// Parameters
// $1 : $ElemNo_L
// $2 : $ProtSysList_Ptr  : pointer to a longint array
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/25/19, 10:59:19
	// ----------------------------------------------------
	//Created : 
	Mods_2019_03
	
	C_LONGINT:C283(PON_FindAllowedProtSys; $1)
	C_POINTER:C301(PON_FindAllowedProtSys; $2)
	
End if 
//

C_LONGINT:C283($1)
C_POINTER:C301($2)

C_LONGINT:C283($ElemNo_L; $ElemValue_L; $DefectNo_L)
$ElemNo_L:=$1

C_TEXT:C284($DefectValue_txt; $testValue_txt)

C_POINTER:C301($ProtSysArray_ptr)

$ProtSysArray_ptr:=$2
//clear it first
//must be longint

ARRAY LONGINT:C221($ProtSysArray_ptr->; 0)

C_TEXT:C284($Defect_Elemt_txt)
ARRAY TEXT:C222($ElemRefs_atxt; 0)
ARRAY TEXT:C222($DefectRefs_atxt; 0)
C_TEXT:C284($ElemRef_txt; $DefRef_txt)
C_TEXT:C284(PON_ELEM_PROTSYS_TREE)
If (PON_ELEM_PROTSYS_TREE="")
	PON_ELEM_PROTSYS_TREE:=ut_DOM_LoadXML("NBE"; "Element_ProtSysTree.xml")
End if 
$ElemRef_txt:=DOM Find XML element:C864(PON_ELEM_PROTSYS_TREE; "Root/Element"; $ElemRefs_atxt)

C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($ElemRefs_atxt))
	DOM GET XML ELEMENT VALUE:C731($ElemRefs_atxt{$loop_L}; $ElemValue_L)
	If ($ElemValue_L=$ElemNo_L)
		
		$DefRef_txt:=DOM Find XML element:C864($ElemRefs_atxt{$loop_L}; "Element/ProtSys"; $DefectRefs_atxt)
		
		C_LONGINT:C283($loop2_L)
		For ($loop2_L; 1; Size of array:C274($DefectRefs_atxt))
			DOM GET XML ELEMENT VALUE:C731($DefectRefs_atxt{$loop2_L}; $DefectNo_L)
			APPEND TO ARRAY:C911($ProtSysArray_ptr->; $DefectNo_L)
		End for 
		
		$loop_L:=Size of array:C274($ElemRefs_atxt)+1
	End if 
End for 
//End PON_FindAllowedProtSys