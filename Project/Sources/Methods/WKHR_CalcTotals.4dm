//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/07/05, 15:09:42
	// ----------------------------------------------------
	// Method: Method: WKHR_CalcTotals
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(2/9/09 20:20:46)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 12:10:11  ` ("WKHRMODS")
End if 
C_POINTER:C301(arrPtr_4; $AssSum_ptr; $CatHRSum_ptr; $CatTotCost_ptr)
C_LONGINT:C283($i; $j)  //Command Replaced was o_C_INTEGER
//calculate Sum of hours for assignment
For ($j; 1; (WKHR_CategoryCount_i+1))
	$AssSum_ptr:=Get pointer:C304("Assgn_Tot_"+String:C10($j))
	$AssSum_ptr->:=0
	For ($i; 1; <>WKH_NumPgs)
		arrPtr_4:=Get pointer:C304("Arr_"+<>a_WKH_Index_Name{$i}+"_Totals")
		$AssSum_ptr->:=$AssSum_ptr->+arrPtr_4->{$j}
		$CatHRSum_ptr:=Get pointer:C304("Item_"+<>a_WKH_Index_Name{$i}+"_Tot_"+String:C10($j))
		$CatHRSum_ptr->:=arrPtr_4->{$j}
	End for 
End for 

WKHR_CalcFunctions("PERCENTAGES")

//Calculate Total Assignment Cost and page costs
Assgn_Tot_Cost:=0
For ($i; 1; <>WKH_NumPgs)
	arrPtr_4:=Get pointer:C304("Arr_"+<>a_WKH_Index_Name{$i}+"_Totals")
	$CatTotCost_ptr:=Get pointer:C304("Item_"+<>a_WKH_Index_Name{$i}+"_totCost")
	$CatTotCost_ptr->:=0
	For ($j; 1; WKHR_CategoryCount_i)
		If (<>a_WKH_Index_Name{$i}#"900")
			$CatTotCost_ptr->:=$CatTotCost_ptr->+(PayRates{$j}*(arrPtr_4->{WKHR_CatIndx_aL{$j}}))
		Else 
			$CatTotCost_ptr->:=$CatTotCost_ptr->+(ConstrPayRates{$j}*(arrPtr_4->{WKHR_CatIndx_aL{$j}}))
		End if 
	End for 
	Assgn_Tot_Cost:=Assgn_Tot_Cost+$CatTotCost_ptr->
End for 

WKHR_CalcFunctions("ASSIGNTOTALS")