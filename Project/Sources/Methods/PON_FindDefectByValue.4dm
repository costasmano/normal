//%attributes = {"invisible":true}
// Method: PON_FindDefectByValue
// Description
// 
// 
// Parameters
// $0 : $DefectRef_txt
// $1 : $DOMTree_txt
// $2 : $ElementPath_txt
// $3 : $Value_L
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 17:33:39
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_TEXT:C284($DOMTree_txt; $ElementPath_txt; $defectRef_txt)
$DOMTree_txt:=$1
$ElementPath_txt:=$2
$Value_L:=$3
C_LONGINT:C283($defectVal_L; $Value_L)
ARRAY TEXT:C222($DefectRefs_atxt; 0)
$defectRef_txt:=DOM Find XML element:C864($DOMTree_txt; $ElementPath_txt; $DefectRefs_atxt)
$0:=""
C_LONGINT:C283($loop_L; $defectVal_L)
For ($loop_L; 1; Size of array:C274($DefectRefs_atxt))
	DOM GET XML ELEMENT VALUE:C731($DefectRefs_atxt{$loop_L}; $defectVal_L)
	If ($Value_L=$defectVal_L)
		$0:=$DefectRefs_atxt{$loop_L}
		$loop_L:=Size of array:C274($DefectRefs_atxt)+1
	End if 
End for 
//End PON_FindDefectByValue