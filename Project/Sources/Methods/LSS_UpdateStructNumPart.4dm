//%attributes = {"invisible":true}
//Method: LSS_UpdateStructNumPart
//Description
// Update a part of the  LSS structure number
// Parameters
// $0 : $Result
// $1 : $StartStructNumber_txt
// $2 : $PartValue_txt
// $3 : $PartNum_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/11/16, 16:59:16
	// ----------------------------------------------------
	//Created : 
	Mods_2016_01_bug
	
	C_TEXT:C284(LSS_UpdateStructNumPart; $0)
	C_TEXT:C284(LSS_UpdateStructNumPart; $1)
	C_TEXT:C284(LSS_UpdateStructNumPart; $2)
	C_LONGINT:C283(LSS_UpdateStructNumPart; $3)
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

ARRAY TEXT:C222($StructureParts_atxt; 0)
C_TEXT:C284($OurStructure_txt)
$OurStructure_txt:=$1
ut_NewTextToArray($OurStructure_txt; ->$StructureParts_atxt; "-")
$StructureParts_atxt{$3}:=$2

C_LONGINT:C283($Loop_L)
$0:=""
For ($Loop_L; 1; Size of array:C274($StructureParts_atxt))
	
	If ($Loop_L<Size of array:C274($StructureParts_atxt))
		$0:=$0+$StructureParts_atxt{$Loop_L}+"-"
	Else 
		$0:=$0+$StructureParts_atxt{$Loop_L}
	End if 
End for 

//End LSS_UpdateStructNumPart