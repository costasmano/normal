//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/21/06, 14:15:13
	// ----------------------------------------------------
	// Method: CIR_RecalcAssgnFunds
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_BOOLEAN:C305($1; $SaveContrRec_b)
If (Count parameters:C259=1)
	$SaveContrRec_b:=$1
Else 
	$SaveContrRec_b:=False:C215
End if 

//update approx and actual spent in [Contracts]  
C_REAL:C285($approxSpent; $actualSpent; $TLFapproxSpent; $TLFactualSpent; $DEapproxSpent; $DEactualSpent)
$approxSpent:=0
$actualSpent:=0
$TLFapproxSpent:=0
$TLFactualSpent:=0
$DEapproxSpent:=0
$DEactualSpent:=0
C_LONGINT:C283($j)
QUERY:C277([Contract Assignments:83]; [Contract Assignments:83]ContractNo:1=[Contracts:79]ContractNo:1)
FIRST RECORD:C50([Contract Assignments:83])
For ($j; 1; Records in selection:C76([Contract Assignments:83]))
	If ([Contract Assignments:83]AcutalOrEstimate:20="Actual")
		$actualSpent:=$actualSpent+[Contract Assignments:83]Actual_Total:9
		$TLFactualSpent:=$TLFactualSpent+[Contract Assignments:83]Actual_TotalLimitFee:7
		$DEactualSpent:=$DEactualSpent+[Contract Assignments:83]Actual_DirectExpense:8
		
		$approxSpent:=$approxSpent+[Contract Assignments:83]Actual_Total:9
		$TLFapproxSpent:=$TLFapproxSpent+[Contract Assignments:83]Actual_TotalLimitFee:7
		$DEapproxSpent:=$DEapproxSpent+[Contract Assignments:83]Actual_DirectExpense:8
		
	Else 
		$approxSpent:=$approxSpent+[Contract Assignments:83]Est_Total:15
		$TLFapproxSpent:=$TLFapproxSpent+[Contract Assignments:83]Est_TotalLimitFee:13
		$DEapproxSpent:=$DEapproxSpent+[Contract Assignments:83]Est_DirectExpense:14
	End if 
	//$actualSpent:=$actualSpent+[Contract Assignments]Actual_Total
	NEXT RECORD:C51([Contract Assignments:83])
End for 

//Total Limiting Fee  
vTLFapproxSpent:=$TLFapproxSpent
vTLFapproxRemaining:=vTLFupdated-vTLFapproxSpent
vTLFactualSpent:=$TLFactualSpent
vTLFactualRemaining:=vTLFupdated-vTLFactualSpent

//Direct Expense
vDEapproxSpent:=$DEapproxSpent
vDEapproxRemaining:=vDEupdated-vDEapproxSpent
vDEactualSpent:=$DEactualSpent
vDEactualRemaining:=vDEupdated-vDEactualSpent

If ($SaveContrRec_b)
	//Total Encumbered  
	[Contracts:79]ApproxSpent:17:=$approxSpent
	[Contracts:79]ActualSpent:18:=$actualSpent
	[Contracts:79]ApproxRemainingFund:19:=[Contracts:79]TotalEncumbered:16-[Contracts:79]ApproxSpent:17
	[Contracts:79]ActualRemainingFund:20:=[Contracts:79]TotalEncumbered:16-[Contracts:79]ActualSpent:18
	
	SAVE RECORD:C53([Contracts:79])
End if 