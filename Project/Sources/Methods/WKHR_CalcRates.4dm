//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/05/05, 22:57:20
	// ----------------------------------------------------
	// Method: WKHR_CalcRates
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(1/2/09 16:42:33)
	Mods_2009_CM_5404  // ("WKHRSMODS")
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_POINTER:C301($indirCost_ptr; $netFee_ptr; $totFee_ptr; $Rate_ptr)
C_LONGINT:C283($i)
For ($i; 1; WKHR_CategoryCount_i)
	$indirCost_ptr:=Get pointer:C304("IndirCostRate_"+String:C10($i))
	$netFee_ptr:=Get pointer:C304("NetFeeRate_"+String:C10($i))
	$totFee_ptr:=Get pointer:C304("TotalFeeRate_"+String:C10($i))
	$indirCost_ptr->:=(([Work_Estimate:103]IndirectCostPct:12/100)*(RateFldPtr_a{$i}->))
	$netFee_ptr->:=(([Work_Estimate:103]NetFeePct:13/100)*($indirCost_ptr->+RateFldPtr_a{$i}->))
	$totFee_ptr->:=(RateFldPtr_a{$i}->)+($indirCost_ptr->)+($netFee_ptr->)
	PayRates{$i}:=$totFee_ptr->
End for 
For ($i; 1; WKHR_CategoryCount_i)
	$indirCost_ptr:=Get pointer:C304("ConstrIndirCostRate_"+String:C10($i))
	$netFee_ptr:=Get pointer:C304("ConstrNetFeeRate_"+String:C10($i))
	$totFee_ptr:=Get pointer:C304("ConstrTotalFeeRate_"+String:C10($i))
	If ([Work_Estimate:103]Version_L:47>0)
		$indirCost_ptr->:=(([Work_Estimate:103]IndirectCostPct:12/100)*(ConstrRateFldPtr_a{$i}->))
		$netFee_ptr->:=(([Work_Estimate:103]NetFeePct:13/100)*($indirCost_ptr->+ConstrRateFldPtr_a{$i}->))
		$totFee_ptr->:=(ConstrRateFldPtr_a{$i}->)+($indirCost_ptr->)+($netFee_ptr->)
	Else 
		$indirCost_ptr->:=(([Work_Estimate:103]IndirectCostPct:12/100)*(RateFldPtr_a{$i}->))
		$netFee_ptr->:=(([Work_Estimate:103]NetFeePct:13/100)*($indirCost_ptr->+RateFldPtr_a{$i}->))
		$totFee_ptr->:=(RateFldPtr_a{$i}->)+($indirCost_ptr->)+($netFee_ptr->)
	End if 
	ConstrPayRates{$i}:=$totFee_ptr->
End for 