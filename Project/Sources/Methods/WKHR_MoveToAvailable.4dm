//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/03/05, 21:47:08
	// ----------------------------------------------------
	// Method: WKHR_MoveToAvailable
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_LONGINT:C283($element_l)
$element_l:=Arr_CurrCategories_txt
If ($element_l<=Size of array:C274(Arr_CurrCategories_txt))
	DELETE FROM ARRAY:C228(Arr_CurrCategories_txt; $element_l; 1)
End if 