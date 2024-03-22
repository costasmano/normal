//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/30/11, 20:03:38
	// ----------------------------------------------------
	// Method: SCPOA_Array2CkBoxArr
	// Description
	// 
	// 
	// Parameters
	// $1 : $arrayindex_L
	// $2 : $ChkBxPtrArr_ptr
	// ----------------------------------------------------
	
	Mods_2011_05
End if 
C_LONGINT:C283($1; $ArrIndx_L)
$ArrIndx_L:=$1
C_POINTER:C301($2; $ChkBxPtrArr_ptr)
$ChkBxPtrArr_ptr:=$2
C_LONGINT:C283($NumChkBoxes_L; $i)
$NumChkBoxes_L:=Size of array:C274($ChkBxPtrArr_ptr->)
C_POINTER:C301($CkBxVar_ptr)
Case of 
	: (($ArrIndx_L=0) | ($ArrIndx_L=1) | ($ArrIndx_L>($NumChkBoxes_L+1)))
		For ($i; 1; $NumChkBoxes_L)
			$CkBxVar_ptr:=$ChkBxPtrArr_ptr->{$i}
			$CkBxVar_ptr->:=0
		End for 
	Else 
		For ($i; 1; $NumChkBoxes_L)
			$CkBxVar_ptr:=$ChkBxPtrArr_ptr->{$i}
			If ($i=($ArrIndx_L-1))
				$CkBxVar_ptr->:=1
			Else 
				$CkBxVar_ptr->:=0
			End if 
			
		End for 
		
End case 