//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/28/08, 09:19:25
	// ----------------------------------------------------
	// Method: CM_CalcAssgnValues
	// Description
	// Generic method to calculate the Assignment values
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9)
C_TEXT:C284($10)

C_POINTER:C301($Sal_ptr; $Overhead_ptr; $Fee_ptr; $IndirCost_ptr; $NetFee_ptr; $TLFThis_ptr; $TLFOther_ptr; $TLFDes_ptr; $TLFCons_ptr; $DirExp_ptr; $Total_ptr)
$Sal_ptr:=$1
$Overhead_ptr:=$2
$Fee_ptr:=$3
$IndirCost_ptr:=$4
$NetFee_ptr:=$5
$TLFThis_ptr:=$6
$TLFOther_ptr:=$7
$DirExp_ptr:=$8
$Total_ptr:=$9

C_REAL:C285($temp)

Case of 
	: ($10="TOTAL")
		$temp:=Round:C94($TLFThis_ptr->/(($Overhead_ptr->/100+1)*($Fee_ptr->/100+1)); 2)
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
		
		$NetFee_ptr->:=$TLFThis_ptr->-$Sal_ptr->-$IndirCost_ptr->
		$Total_ptr->:=$TLFThis_ptr->+$TLFOther_ptr->+$DirExp_ptr->
		
	: ($10="SALARY")
		$temp:=Round:C94($Sal_ptr->*($Overhead_ptr->/100); 2)
		If (Dec:C9($temp)=0.99)
			$IndirCost_ptr->:=Round:C94($temp; 0)
		Else 
			$IndirCost_ptr->:=$temp
		End if 
		
		$temp:=Round:C94($Sal_ptr->*($Overhead_ptr->/100+1)*($Fee_ptr->/100); 2)
		If (Dec:C9($temp)=0.99)
			$NetFee_ptr->:=Round:C94($temp; 0)
		Else 
			$NetFee_ptr->:=$temp
		End if 
		
		$TLFThis_ptr->:=$Sal_ptr->+$IndirCost_ptr->+$NetFee_ptr->
		$Total_ptr->:=$TLFOther_ptr->+$TLFThis_ptr->+$DirExp_ptr->
		
	: ($10="INDIRECT")
		$temp:=Round:C94($IndirCost_ptr->/($Overhead_ptr->/100); 2)
		If (Dec:C9($temp)=0.99)
			$Sal_ptr->:=Round:C94($temp; 0)
		Else 
			$Sal_ptr->:=$temp
		End if 
		$temp:=Round:C94($Sal_ptr->*($Overhead_ptr->/100+1)*($Fee_ptr->/100); 2)
		If (Dec:C9($temp)=0.99)
			$NetFee_ptr->:=Round:C94($temp; 0)
		Else 
			$NetFee_ptr->:=$temp
		End if 
		$TLFThis_ptr->:=$Sal_ptr->+$IndirCost_ptr->+$NetFee_ptr->
		$Total_ptr->:=$TLFThis_ptr->+$TLFOther_ptr->+$DirExp_ptr->
		
	: ($10="NETFEE")
		$temp:=Round:C94($NetFee_ptr->/(($Overhead_ptr->/100+1)*($Fee_ptr->/100)); 2)
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
		
		$TLFThis_ptr->:=$Sal_ptr->+$IndirCost_ptr->+$NetFee_ptr->
		$Total_ptr->:=$TLFThis_ptr->+$TLFOther_ptr->+$DirExp_ptr->
		
End case 