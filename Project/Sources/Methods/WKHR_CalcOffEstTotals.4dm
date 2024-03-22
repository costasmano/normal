//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/19/08, 08:53:49
	// ----------------------------------------------------
	// Method: WKHR_CalcOffEstTotals
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403  //("WKHRS")
	// Modified by: costasmanousakis-(Designer)-(2/9/09 21:32:23)
	Mods_2009_CM_5404  //("WKHRMODS")
End if 
C_POINTER:C301(arrPtr_4; $AssSum_ptr; $CatHRSum_ptr; $CatTotCost_ptr)
C_LONGINT:C283($PosInReview_L)
C_LONGINT:C283($i; $j)  //Command Replaced was o_C_INTEGER
//calculate Sum of hours for assignment
For ($j; 1; (WKHR_CategoryCount_i+1))
	$AssSum_ptr:=Get pointer:C304("Assgn_Tot_"+String:C10($j))
	$AssSum_ptr->:=0
	For ($i; 1; <>WKH_NumPgs)
		arrPtr_4:=Get pointer:C304("Arr_"+<>a_WKH_Index_Name{$i}+"_Totals")
		$CatHRSum_ptr:=Get pointer:C304("Item_"+<>a_WKH_Index_Name{$i}+"_Tot_"+String:C10($j))
		$PosInReview_L:=Find in array:C230(Arr_WKHR_OfficeEstRef; Num:C11(<>a_WKH_Index_Name{$i}))
		If ($PosInReview_L>0)
			$AssSum_ptr->:=$AssSum_ptr->+arr_WKHR_OfficeEstVal{$j}{$PosInReview_L}
			$CatHRSum_ptr->:=arr_WKHR_OfficeEstVal{$j}{$PosInReview_L}
		Else 
			//$AssSum_ptr->:=$AssSum_ptr->
			$CatHRSum_ptr->:=0
		End if 
		
	End for 
End for 

//Calculate percentages 
WKHR_CalcFunctions("PERCENTAGES")

//Calculate Total Assignment Cost and page costs
Assgn_Tot_Cost:=0
For ($i; 1; <>WKH_NumPgs)
	arrPtr_4:=Get pointer:C304("Arr_"+<>a_WKH_Index_Name{$i}+"_Totals")
	$CatTotCost_ptr:=Get pointer:C304("Item_"+<>a_WKH_Index_Name{$i}+"_totCost")
	$CatTotCost_ptr->:=0
	$PosInReview_L:=Find in array:C230(Arr_WKHR_OfficeEstRef; Num:C11(<>a_WKH_Index_Name{$i}))
	If ($PosInReview_L>0)
		For ($j; 1; WKHR_CategoryCount_i)
			If (<>a_WKH_Index_Name{$i}#"900")
				$CatTotCost_ptr->:=$CatTotCost_ptr->+(PayRates{$j}*(arr_WKHR_OfficeEstVal{WKHR_CatIndx_aL{$j}}{$PosInReview_L}))
			Else 
				$CatTotCost_ptr->:=$CatTotCost_ptr->+(ConstrPayRates{$j}*(arr_WKHR_OfficeEstVal{WKHR_CatIndx_aL{$j}}{$PosInReview_L}))
			End if 
		End for 
	Else 
		For ($j; 1; WKHR_CategoryCount_i)
			If (<>a_WKH_Index_Name{$i}#"900")
				$CatTotCost_ptr->:=$CatTotCost_ptr->+(PayRates{$j}*0)
			Else 
				$CatTotCost_ptr->:=$CatTotCost_ptr->+(ConstrPayRates{$j}*0)
			End if 
		End for 
	End if 
	
	Assgn_Tot_Cost:=Assgn_Tot_Cost+$CatTotCost_ptr->
End for 

WKHR_CalcFunctions("ASSIGNTOTALS")