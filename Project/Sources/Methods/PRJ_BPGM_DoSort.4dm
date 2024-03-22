//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/05/07, 12:29:06
	// ----------------------------------------------------
	// Method: PRJ_BPGM_DoSort
	// Description
	// 
	// 
	// Parameters
	// $1 : sort number : L (optional)
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(6/13/08 08:26:14)
	Mods_2008_CM_5403
	//Load the sort arrays as needed.
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_LONGINT:C283($1; $SortNum_L)

C_POINTER:C301($SortColumn_ptr; $SortArrow_ptr; $TempPtr_Ptr)
C_LONGINT:C283($tbl_L; $Fld_L; $Loop_l)
C_TEXT:C284($varName_txt)
C_POINTER:C301($Variable_ptr)
If (Count parameters:C259=1)
	$SortNum_L:=$1
Else 
	For ($Loop_l; 1; PRJ_BPGM_NumSort_L)
		$Variable_ptr:=Get pointer:C304("SortColumn"+String:C10($Loop_l)+"_l")
		Case of 
			: ($Variable_ptr->=0)
			: ($Variable_ptr->=1)
				$Variable_ptr->:=2
				$SortNum_L:=$Loop_l
			: ($Variable_ptr->=2)
				$Variable_ptr->:=1
				$SortNum_L:=$Loop_l
		End case 
	End for 
	
End if 

SET CURSOR:C469(4)
SHORT_MESSAGE("Sorting...")
If ($SortNum_L<=Size of array:C274(PRJ_BPGM_Sorts_aptr))
	$SortColumn_ptr:=PRJ_BPGM_Sorts_aptr{$SortNum_L}
	$SortArrow_ptr:=Get pointer:C304("SortColumn"+String:C10($SortNum_L)+"_l")
	RESOLVE POINTER:C394($SortColumn_ptr; $varName_txt; $tbl_L; $Fld_L)
	If ($tbl_L>0)
		//some field,table
		If ($SortArrow_ptr->=0) | ($SortArrow_ptr->=2)
			$SortArrow_ptr->:=1
			ORDER BY:C49([PRJ_ProjectDetails:115]; $SortColumn_ptr->; >)
		Else 
			$SortArrow_ptr->:=2
			ORDER BY:C49([PRJ_ProjectDetails:115]; $SortColumn_ptr->; <)
		End if 
		PRJ_BPGM_AdjustSortArrays
	Else 
		//a variable - presumably array
		ARRAY POINTER:C280($SortArrays_aptr; 0)
		For ($Loop_l; 1; Size of array:C274(PRJ_BPGM_Sorts_aptr))
			$TempPtr_Ptr:=PRJ_BPGM_Sorts_aptr{$Loop_l}
			RESOLVE POINTER:C394($TempPtr_Ptr; $varName_txt; $tbl_L; $Fld_L)
			If ($tbl_L<=0)
				If ($Loop_l#$SortNum_L)
					INSERT IN ARRAY:C227($SortArrays_aptr; 1)
					$SortArrays_aptr{1}:=$TempPtr_Ptr
				End if 
			End if 
		End for 
		INSERT IN ARRAY:C227($SortArrays_aptr; 0)
		$SortArrays_aptr{1}:=$SortColumn_ptr
		INSERT IN ARRAY:C227($SortArrays_aptr; (Size of array:C274($SortArrays_aptr)+1))
		$SortArrays_aptr{Size of array:C274($SortArrays_aptr)}:=->PRJ_BPGM_RecNumbers_aL
		ARRAY LONGINT:C221($SortArraysname_aL; Size of array:C274($SortArrays_aptr))
		$SortArraysname_aL{1}:=1
		
		If ($SortArrow_ptr->=0) | ($SortArrow_ptr->=2)
			$SortArrow_ptr->:=1
			$SortArraysname_aL{1}:=1
		Else 
			$SortArrow_ptr->:=2
			$SortArraysname_aL{1}:=-1
		End if 
		//now fill the needed arrays
		PRJ_BPGM_LoadArrays_2($SortColumn_ptr)
		MULTI SORT ARRAY:C718($SortArrays_aptr; $SortArraysname_aL)
		CREATE SELECTION FROM ARRAY:C640([PRJ_ProjectDetails:115]; PRJ_BPGM_RecNumbers_aL; "SortedPRJDetails")
		USE NAMED SELECTION:C332("SortedPRJDetails")
		CLEAR NAMED SELECTION:C333("SortedPRJDetails")
	End if 
	
	ut_SetSortColumns(PRJ_BPGM_NumSort_L; $SortNum_L)
End if 
CLOSE WINDOW:C154
SET CURSOR:C469(0)
