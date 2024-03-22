//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/03/05, 21:53:13
	// ----------------------------------------------------
	// Method: WKHR_MoveToExcluded
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_LONGINT:C283($iSize; $PreviousRow)
$PreviousRow:=Find in array:C230(Arr_CurrCategories_txt; Arr_AllCategories_txt{Arr_AllCategories_txt})
If ($PreviousRow>0)
Else 
	$iSize:=Size of array:C274(Arr_CurrCategories_txt)
	
	INSERT IN ARRAY:C227(Arr_CurrCategories_txt; $iSize+1; 1)
	Arr_CurrCategories_txt{$iSize+1}:=Arr_AllCategories_txt{Arr_AllCategories_txt}
	SORT ARRAY:C229(Arr_CurrCategories_txt)
End if 