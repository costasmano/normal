//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/14/06, 17:45:15
	// ----------------------------------------------------
	// Method: INSP_InitDwnlFldPtrArr
	// Description
	// 
	// 
	// Parameters
	// $1 : Table Num
	// $2 : Skip Fields
	// ----------------------------------------------------
	Mods_2007_CM03
End if 
C_LONGINT:C283($1; $TableNum_L)
C_POINTER:C301(${2})
$TableNum_L:=$1

C_LONGINT:C283($viFldType)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($NumTblFlds_L; $i)
C_TEXT:C284($FieldName)
ARRAY POINTER:C280($ExcludeArray; (Count parameters:C259-1))

If (Count parameters:C259>1)
	For ($i; 2; Count parameters:C259)
		$ExcludeArray{$i-1}:=${$i}
	End for 
Else 
	
End if 
$NumTblFlds_L:=Get last field number:C255($TableNum_L)

ARRAY POINTER:C280(INSP_Ptr_TableFields; $NumTblFlds_L)
For ($i; 1; $NumTblFlds_L)
	INSP_Ptr_TableFields{$i}:=Field:C253($TableNum_L; $i)
End for 
For ($i; $NumTblFlds_L; 1; -1)
	GET FIELD PROPERTIES:C258(INSP_Ptr_TableFields{$i}; $viFldType)
	Case of 
		: (Find in array:C230($ExcludeArray; INSP_Ptr_TableFields{$i})>0)
			DELETE FROM ARRAY:C228(INSP_Ptr_TableFields; $i)
			
		: ($viFldType=Is subtable:K8:11)  //AND subtables
			DELETE FROM ARRAY:C228(INSP_Ptr_TableFields; $i)
			
	End case 
	
End for 