//%attributes = {"invisible":true}
//Method: ARCHIVE_MatchFields
//Description
//  ` Match fields between a source tabel and the archive table; fill arrays with required pointers
// Parameters
// $1 : $SourceTable_ptr
// $2 : $ArchTable_ptr
// $3 : $SourceFldsarray_ptr
// $4 : $ArchFldsarray_ptr
// $5 : $ReasonFld_ptr
// $6 : $DateFld_ptr

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/07/14, 12:31:39
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04
End if 
//
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)

C_POINTER:C301($SourceTable_ptr; $ArchTable_ptr; $SourceFldsarray_ptr; $ArchFldsarray_ptr; $ReasonFldptr_ptr; $DateFldptr_ptr)

$SourceTable_ptr:=$1
$ArchTable_ptr:=$2
$SourceFldsarray_ptr:=$3
$ArchFldsarray_ptr:=$4
$ReasonFldptr_ptr:=$5
$DateFldptr_ptr:=$6

C_LONGINT:C283($numSourceFlds_L; $numTargFlds_L)
$numSourceFlds_L:=Get last field number:C255($SourceTable_ptr)
$numTargFlds_L:=Get last field number:C255($ArchTable_ptr)

ARRAY POINTER:C280($SourceFldsarray_ptr->; $numSourceFlds_L)
ARRAY POINTER:C280($ArchFldsarray_ptr->; $numSourceFlds_L)
ARRAY TEXT:C222($SourceFlds_atxt; $numSourceFlds_L)
ARRAY TEXT:C222($targetFlds_atxt; $numTargFlds_L)

C_LONGINT:C283($loop_L; $Index_L; $count_L)
For ($loop_L; 1; Size of array:C274($targetFlds_atxt))
	$targetFlds_atxt{$loop_L}:=Field name:C257(Table:C252($ArchTable_ptr); $loop_L)
End for 
C_POINTER:C301($ReasonFld_ptr; $DateFld_ptr)
$Index_L:=Find in array:C230($targetFlds_atxt; "ArchiveReason_s")
$ReasonFldptr_ptr->:=Field:C253(Table:C252($ArchTable_ptr); $Index_L)
$Index_L:=Find in array:C230($targetFlds_atxt; "ArchiveDate_d")
$DateFldptr_ptr->:=Field:C253(Table:C252($ArchTable_ptr); $Index_L)

For ($loop_L; 1; Size of array:C274($SourceFldsarray_ptr->))
	$SourceFldsarray_ptr->{$loop_L}:=Field:C253(Table:C252($SourceTable_ptr); $loop_L)
	$SourceFlds_atxt{$loop_L}:=Field name:C257(Table:C252($SourceTable_ptr); $loop_L)
	$Index_L:=Find in array:C230($targetFlds_atxt; $SourceFlds_atxt{$loop_L})
	If ($Index_L>0)
		$ArchFldsarray_ptr->{$loop_L}:=Field:C253(Table:C252($ArchTable_ptr); $Index_L)
	End if 
End for 

//clean up fields
C_LONGINT:C283($fieldsCount_L; $tbl_L; $fld_L)
C_TEXT:C284($varName_txt)

For ($loop_L; Size of array:C274($SourceFldsarray_ptr->); 1; -1)
	RESOLVE POINTER:C394($ArchFldsarray_ptr->{$loop_L}; $varName_txt; $tbl_L; $fld_L)
	If ($tbl_L#Table:C252($ArchTable_ptr))
		DELETE FROM ARRAY:C228($SourceFldsarray_ptr->; $loop_L; 1)
		DELETE FROM ARRAY:C228($ArchFldsarray_ptr->; $loop_L; 1)
	End if 
	
End for 

//End ARCHIVE_MatchFields