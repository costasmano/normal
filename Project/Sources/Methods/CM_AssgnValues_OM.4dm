//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/28/08, 09:21:51
	// ----------------------------------------------------
	// Method: CM_AssgnValues_OM
	// Description
	// Object method for objects in the input forms.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
End if 
C_TEXT:C284($1; $2)
C_POINTER:C301($TLFOther_ptr; $TLFThis_ptr; $Sal_ptr; $Overhead_ptr; $Fee_ptr; $IndirCost_ptr; $NetFee_ptr; $TLFDes_ptr; $TLFCons_ptr; $DirExp_ptr; $Total_ptr)
$Overhead_ptr:=->[Contract_Assignment_Maintenance:101]Overhead:5
$Fee_ptr:=->[Contract_Assignment_Maintenance:101]Fee:6

Case of 
	: ($1="EST_DES")
		$Sal_ptr:=->[Contract_Assignment_Maintenance:101]Est_Salary:10
		$IndirCost_ptr:=->[Contract_Assignment_Maintenance:101]Est_IndirectCost:11
		$NetFee_ptr:=->[Contract_Assignment_Maintenance:101]Est_NetFee:12
		$TLFThis_ptr:=->[Contract_Assignment_Maintenance:101]Est_TotalLimitFee:13
		$TLFOther_ptr:=->[Contract_Assignment_Maintenance:101]Est_ConstrTotalLimitFee:30
		$DirExp_ptr:=->[Contract_Assignment_Maintenance:101]Est_DirectExpense:14
		$Total_ptr:=->[Contract_Assignment_Maintenance:101]Est_Total:15
		
	: ($1="EST_CONSTR")
		$Sal_ptr:=->[Contract_Assignment_Maintenance:101]Est_ConstrSalary:27
		$IndirCost_ptr:=->[Contract_Assignment_Maintenance:101]Est_ConstrIndirectCost:28
		$NetFee_ptr:=->[Contract_Assignment_Maintenance:101]Est_ConstrNetFee:29
		$TLFThis_ptr:=->[Contract_Assignment_Maintenance:101]Est_ConstrTotalLimitFee:30
		$TLFOther_ptr:=->[Contract_Assignment_Maintenance:101]Est_TotalLimitFee:13
		$DirExp_ptr:=->[Contract_Assignment_Maintenance:101]Est_DirectExpense:14
		$Total_ptr:=->[Contract_Assignment_Maintenance:101]Est_Total:15
		
	: ($1="ACTUAL_DES")
		$Sal_ptr:=->[Contract_Assignment_Maintenance:101]Actual_Salary:22
		$IndirCost_ptr:=->[Contract_Assignment_Maintenance:101]Actual_IndirectCost:23
		$NetFee_ptr:=->[Contract_Assignment_Maintenance:101]Actual_NetFee:24
		$TLFThis_ptr:=->[Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25
		$TLFOther_ptr:=->[Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34
		$DirExp_ptr:=->[Contract_Assignment_Maintenance:101]Actual_DirectExpense:26
		$Total_ptr:=->[Contract_Assignment_Maintenance:101]Actual_Total:9
		
	: ($1="ACTUAL_CONSTR")
		$Sal_ptr:=->[Contract_Assignment_Maintenance:101]Actual_ConstrSalary:31
		$IndirCost_ptr:=->[Contract_Assignment_Maintenance:101]Actual_ConstrIndirectCost:32
		$NetFee_ptr:=->[Contract_Assignment_Maintenance:101]Actual_ConstrNetFee:33
		$TLFThis_ptr:=->[Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34
		$TLFOther_ptr:=->[Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25
		$DirExp_ptr:=->[Contract_Assignment_Maintenance:101]Actual_DirectExpense:26
		$Total_ptr:=->[Contract_Assignment_Maintenance:101]Actual_Total:9
		
	: ($1="ADDEND_DES")
		$Sal_ptr:=->[Addendum_Maintenance:102]Est_Salary:14
		$IndirCost_ptr:=->[Addendum_Maintenance:102]Est_IndirectCost:12
		$NetFee_ptr:=->[Addendum_Maintenance:102]Est_NetFee:13
		$TLFThis_ptr:=->[Addendum_Maintenance:102]Est_TotalLimitFee:16
		$TLFOther_ptr:=->[Addendum_Maintenance:102]Est_ConstrTotalLimitFee:10
		$DirExp_ptr:=->[Addendum_Maintenance:102]Est_DirectExpense:11
		$Total_ptr:=->[Addendum_Maintenance:102]Est_Total:15
		
	: ($1="ADDEND_CONSTR")
		$Sal_ptr:=->[Addendum_Maintenance:102]Est_ConstrSalary:9
		$IndirCost_ptr:=->[Addendum_Maintenance:102]Est_ConstrIndirectCost:7
		$NetFee_ptr:=->[Addendum_Maintenance:102]Est_ConstrNetFee:8
		$TLFThis_ptr:=->[Addendum_Maintenance:102]Est_ConstrTotalLimitFee:10
		$TLFOther_ptr:=->[Addendum_Maintenance:102]Est_TotalLimitFee:16
		$DirExp_ptr:=->[Addendum_Maintenance:102]Est_DirectExpense:11
		$Total_ptr:=->[Addendum_Maintenance:102]Est_Total:15
		
End case 

CM_CalcAssgnValues($Sal_ptr; $Overhead_ptr; $Fee_ptr; $IndirCost_ptr; $NetFee_ptr; $TLFThis_ptr; $TLFOther_ptr; $DirExp_ptr; $Total_ptr; $2)

If ($1="EST_@")
	CM_CalculateNegotiatedCosts
End if 