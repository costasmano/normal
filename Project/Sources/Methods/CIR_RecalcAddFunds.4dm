//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/21/06, 12:28:09
	// ----------------------------------------------------
	// Method: CIR_RecalcAddFunds
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(4/3/2006 12:25:17)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(9/19/2006 16:37:32)
	Mods_2006_CM06
End if 
C_REAL:C285($additionalFund; $TLFadditional; $DEadditional; $TLFpending; $DEPending)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
$additionalFund:=0
$TLFadditional:=0
$DEadditional:=0
$TLFpending:=0
$DEPending:=0

QUERY:C277([Contract AddFund:82]; [Contract AddFund:82]ContractNo:1=[Contracts:79]ContractNo:1)
For ($i; 1; Records in selection:C76([Contract AddFund:82]))
	GOTO SELECTED RECORD:C245([Contract AddFund:82]; $i)
	If (True:C214)
		If ([Contract AddFund:82]DateApproval:5#!00-00-00!)
			// If ([Contract AddFund]DateApproval#!00/00/00!)
			$additionalFund:=$additionalFund+[Contract AddFund:82]Total:8
			$TLFadditional:=$TLFadditional+[Contract AddFund:82]TotalLimitFee:6
			$DEadditional:=$DEadditional+[Contract AddFund:82]DirectExpense:7
			
		End if 
	Else 
		$TLFpending:=$TLFpending+[Contract AddFund:82]TotalLimitFee:6
		$DEPending:=$DEPending+[Contract AddFund:82]DirectExpense:7
	End if 
End for 

//Total Encumbered  
[Contracts:79]TotalEncumbered:16:=[Contracts:79]InitContractTotal:12+$additionalFund
[Contracts:79]ActualRemainingFund:20:=[Contracts:79]TotalEncumbered:16-[Contracts:79]ActualSpent:18
[Contracts:79]ApproxRemainingFund:19:=[Contracts:79]TotalEncumbered:16-[Contracts:79]ApproxSpent:17

//Total Limiting Fee
vTLFPending_add:=$TLFpending
vDEpending_add:=$DEPending
vTLFPending:=vTLFpending_Transf+vTLFPending_add
vDEpending:=vDEpending_transf+vDEpending_add

vTLFAdditional_add:=$TLFadditional
vDEAdditional_add:=$DEadditional

//Total Limiting Fee
vTLFupdated:=[Contracts:79]InitContractTotalLimitFee:14+vTLFAdditional_add+vTLFAdditional_transf
vTLFapproxRemaining:=vTLFupdated-vTLFapproxSpent
vTLFactualRemaining:=vTLFupdated-vTLFactualSpent

vDEupdated:=[Contracts:79]InitContractTotDirctExpense:15+vDEAdditional_add+vDEAdditional_transf
vDEapproxRemaining:=vDEupdated-vDEapproxSpent
vDEactualRemaining:=vDEupdated-vDEactualSpent

SAVE RECORD:C53([Contracts:79])