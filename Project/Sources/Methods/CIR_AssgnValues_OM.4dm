//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/10/08, 11:24:34
	// ----------------------------------------------------
	// Method: CIR_AssgnValues_OM
	// Description
	// Calculate the values in the current contract assignment record based on
	// the field changed.
	// 
	// Parameters
	// $1 : Field pointer
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
End if 
C_POINTER:C301($1; $Fld_ptr)
$Fld_ptr:=$1
C_TEXT:C284($Est_act_txt; $Fieldname_txt)
$Fieldname_txt:=Field name:C257($Fld_ptr)
C_LONGINT:C283($Separatorpos_L)
$Separatorpos_L:=Position:C15("_"; $Fieldname_txt)
$Est_act_txt:=""
If ($Separatorpos_L>0)
	$Est_act_txt:=Substring:C12($Fieldname_txt; 1; ($Separatorpos_L-1))
	$Fieldname_txt:=Substring:C12($Fieldname_txt; ($Separatorpos_L+1))
End if 

C_POINTER:C301($Sal_ptr; $Overhead_ptr; $Fee_ptr; $IndirCost_ptr; $NetFee_ptr; $TLF_ptr; $DirExp_ptr; $Total_ptr)

$Overhead_ptr:=->[Contract Assignments:83]OverHeadRate:23
$NetFee_ptr:=->[Contract Assignments:83]NetFeeRate:22
C_BOOLEAN:C305($ParamsOK_b)
$ParamsOK_b:=True:C214
Case of 
	: ($Est_act_txt="EST")
		$Sal_ptr:=->[Contract Assignments:83]Est_Salary:10
		$IndirCost_ptr:=->[Contract Assignments:83]Est_IndirectCost:11
		$Fee_ptr:=->[Contract Assignments:83]Est_NetFee:12
		$DirExp_ptr:=->[Contract Assignments:83]Est_DirectExpense:14
		$TLF_ptr:=->[Contract Assignments:83]Est_TotalLimitFee:13
		$Total_ptr:=->[Contract Assignments:83]Est_Total:15
	: ($Est_act_txt="ACTUAL")
		$Sal_ptr:=->[Contract Assignments:83]Actual_Salary:4
		$IndirCost_ptr:=->[Contract Assignments:83]Actual_IndirectCost:5
		$Fee_ptr:=->[Contract Assignments:83]Actual_NetFee:6
		$DirExp_ptr:=->[Contract Assignments:83]Actual_DirectExpense:8
		$TLF_ptr:=->[Contract Assignments:83]Actual_TotalLimitFee:7
		$Total_ptr:=->[Contract Assignments:83]Actual_Total:9
	Else 
		ALERT:C41("Unknown Cost option "+$Est_act_txt+"! Expected ESTIMATED or ACTUAL!")
		$ParamsOK_b:=False:C215
End case 
If ($ParamsOK_b)
	C_REAL:C285($temp)
	
	Case of 
		: ($Fieldname_txt="Salary")
			$temp:=Round:C94($Sal_ptr->*($Overhead_ptr->/100); 2)
			If (Dec:C9($temp)=0.99)
				$IndirCost_ptr->:=Round:C94($temp; 0)
			Else 
				$IndirCost_ptr->:=$temp
			End if 
			
			$temp:=Round:C94($Sal_ptr->*($Overhead_ptr->/100+1)*($NetFee_ptr->/100); 2)
			If (Dec:C9($temp)=0.99)
				$Fee_ptr->:=Round:C94($temp; 0)
			Else 
				$Fee_ptr->:=$temp
			End if 
			
			$TLF_ptr->:=$Sal_ptr->+$IndirCost_ptr->+$Fee_ptr->
			
		: ($Fieldname_txt="IndirectCost")
			$temp:=Round:C94($IndirCost_ptr->/($Overhead_ptr->/100); 2)
			If (Dec:C9($temp)=0.99)
				$Sal_ptr->:=Round:C94($temp; 0)
			Else 
				$Sal_ptr->:=$temp
			End if 
			
			$temp:=Round:C94($Sal_ptr->*($Overhead_ptr->/100+1)*($NetFee_ptr->/100); 2)
			If (Dec:C9($temp)=0.99)
				$Fee_ptr->:=Round:C94($temp; 0)
			Else 
				$Fee_ptr->:=$temp
			End if 
			
			$TLF_ptr->:=$Sal_ptr->+$IndirCost_ptr->+$Fee_ptr->
			
		: ($Fieldname_txt="NetFee")
			$temp:=Round:C94($Fee_ptr->/(($Overhead_ptr->/100+1)*($NetFee_ptr->/100)); 2)
			If (Dec:C9($temp)=0.99)
				$Sal_ptr->:=Round:C94($temp; 0)
			Else 
				$Sal_ptr->:=$temp
			End if 
			
			$temp:=Round:C94($Sal_ptr->*($Overhead_ptr->/100); 2)
			If (Dec:C9($temp)=0.99)
				$IndirCost_ptr->:=Round:C94($temp; 0)
			Else 
				$IndirCost_ptr->:=$temp
			End if 
			
			$TLF_ptr->:=$Sal_ptr->+$IndirCost_ptr->+$Fee_ptr->
			
		: ($Fieldname_txt="TotalLimitFee")
			$temp:=Round:C94($TLF_ptr->/(($Overhead_ptr->/100+1)*($NetFee_ptr->/100+1)); 2)
			If (Dec:C9($temp)=0.99)
				$Sal_ptr->:=Round:C94($temp; 0)
			Else 
				$Sal_ptr->:=$temp
			End if 
			
			$temp:=Round:C94($Sal_ptr->*($Overhead_ptr->/100); 2)
			If (Dec:C9($temp)=0.99)
				$IndirCost_ptr->:=Round:C94($temp; 0)
			Else 
				$IndirCost_ptr->:=$temp
			End if 
			
			$Fee_ptr->:=$TLF_ptr->-$Sal_ptr->-$IndirCost_ptr->
			
		: ($Fieldname_txt="DirectExpense")
			
		Else 
			ALERT:C41("Unknown Field name "+$Fieldname_txt+"! Please notify the Designer of the DB!")
			$ParamsOK_b:=False:C215
	End case 
	If ($ParamsOK_b)
		$Total_ptr->:=$TLF_ptr->+$DirExp_ptr->
	End if 
	
End if 