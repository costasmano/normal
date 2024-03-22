//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/20/05, 16:33:26
	// ----------------------------------------------------
	// Method: WKHR_ResetPageValues
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(2/9/09 20:14:21)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 12:02:44  ` ("WKHRMODS")
End if 
C_POINTER:C301(arrPtr_3; arrPtr_4; $CatTotCost_ptr)
C_LONGINT:C283($i; $j; $col; $NumItems)

arrPtr_3:=Get pointer:C304("Arr_"+CategoryPrefix+"_Values")
arrPtr_4:=Get pointer:C304("Arr_"+CategoryPrefix+"_Totals")
For ($i; 1; (WKHR_CategoryCount_i+1))
	arrPtr_4->{$i}:=0
End for 
$NumItems:=Size of array:C274(arrPtr_3->{1})
For ($j; 1; (WKHR_CategoryCount_i+1))
	For ($i; 1; $NumItems)
		arrPtr_3->{$j}{$i}:=0
	End for 
End for 
//Calculate cost for this category
$CatTotCost_ptr:=Get pointer:C304("Item_"+CategoryPrefix+"_totCost")
$CatTotCost_ptr->:=0
For ($col; 1; WKHR_CategoryCount_i)
	If (CategoryPrefix#"900")
		$CatTotCost_ptr->:=$CatTotCost_ptr->+(PayRates{$col}*(arrPtr_4->{$col}))
	Else 
		$CatTotCost_ptr->:=$CatTotCost_ptr->+(ConstrPayRates{$col}*(arrPtr_4->{$col}))
	End if 
End for 