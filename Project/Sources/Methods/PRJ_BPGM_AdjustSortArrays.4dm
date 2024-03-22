//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/11/07, 18:40:00
	// ----------------------------------------------------
	// Method: PRJ_BPGM_AdjustSortArrays
	// Description
	// From the current sort of the selection, adjust the
	// Sort arrays
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($i)
C_POINTER:C301($TempPtr_Ptr)
C_LONGINT:C283($tbl_L; $Fld_L)
ARRAY POINTER:C280($SortArrays_aptr; 0)
C_TEXT:C284($varName_txt)
For ($i; 1; Size of array:C274(PRJ_BPGM_Sorts_aptr))
	$TempPtr_Ptr:=PRJ_BPGM_Sorts_aptr{$i}
	RESOLVE POINTER:C394($TempPtr_Ptr; $varName_txt; $tbl_L; $Fld_L)
	If ($tbl_L<=0)
		INSERT IN ARRAY:C227($SortArrays_aptr; 1)
		$SortArrays_aptr{1}:=$TempPtr_Ptr
	End if 
End for 
ARRAY LONGINT:C221($CurrentRecNumArray_aL; 0)
C_LONGINT:C283($NewPos_L)
SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; $CurrentRecNumArray_aL)
For ($i; 1; Size of array:C274(PRJ_BPGM_RecNumbers_aL))
	$NewPos_L:=Find in array:C230($CurrentRecNumArray_aL; PRJ_BPGM_RecNumbers_aL{$i})
	PRJ_BPGM_RecNumbers_aL{$i}:=$NewPos_L
End for 
INSERT IN ARRAY:C227($SortArrays_aptr; 1)
$SortArrays_aptr{1}:=->PRJ_BPGM_RecNumbers_aL
ARRAY LONGINT:C221($SortArraysname_aL; Size of array:C274($SortArrays_aptr))
$SortArraysname_aL{1}:=1
MULTI SORT ARRAY:C718($SortArrays_aptr; $SortArraysname_aL)
COPY ARRAY:C226($CurrentRecNumArray_aL; PRJ_BPGM_RecNumbers_aL)
