//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/16/06, 15:38:16
	// ----------------------------------------------------
	// Method: CM_RecalcAddFunds
	// Description
	// Recalc values due to Additional Funds
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(5/30/2006 10:28:11)
	Mods_2006_CM04
End if 
C_REAL:C285($additionalFund; $TLFadditional; $DEadditional; $TLFpending; $DEPending)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
$additionalFund:=0
$TLFadditional:=0
$DEadditional:=0
$TLFpending:=0
$DEPending:=0

QUERY:C277([AddFund_Maintenance:99]; [AddFund_Maintenance:99]ContractNo:1=[Contract_Maintenance:97]ContractNo:1)
For ($i; 1; Records in selection:C76([AddFund_Maintenance:99]))
	If ([AddFund_Maintenance:99]DateApproval:5#!00-00-00!)
		$additionalFund:=$additionalFund+[AddFund_Maintenance:99]Total:8
		$TLFadditional:=$TLFadditional+[AddFund_Maintenance:99]TotalLimitFee:6
		$DEadditional:=$DEadditional+[AddFund_Maintenance:99]DirectExpense:7
	Else 
		$TLFpending:=$TLFpending+[AddFund_Maintenance:99]TotalLimitFee:6
		$DEPending:=$DEPending+[AddFund_Maintenance:99]DirectExpense:7
	End if 
	NEXT RECORD:C51([AddFund_Maintenance:99])
End for 

//Total Encumbered  
[Contract_Maintenance:97]TotalEncumbered:16:=[Contract_Maintenance:97]InitContractTotal:12+$additionalFund
[Contract_Maintenance:97]ActualRemainingFund:20:=[Contract_Maintenance:97]TotalEncumbered:16-[Contract_Maintenance:97]ActualSpent:18
[Contract_Maintenance:97]ApproxRemainingFund:19:=[Contract_Maintenance:97]TotalEncumbered:16-[Contract_Maintenance:97]ApproxSpent:17

//Total Limiting Fee
vTLFPending_add:=$TLFpending
vDEpending_add:=$DEPending
vTLFPending:=vTLFpending_Transf+vTLFPending_add
vDEpending:=vDEpending_transf+vDEpending_add

vTLFAdditional_add:=$TLFadditional
vDEAdditional_add:=$DEadditional

//Total Limiting Fee
vTLFupdated:=[Contract_Maintenance:97]InitContractTotalLimitFee:14+vTLFAdditional_add+vTLFAdditional_transf
vTLFapproxRemaining:=vTLFupdated-vTLFapproxSpent
vTLFactualRemaining:=vTLFupdated-vTLFactualSpent

vDEupdated:=[Contract_Maintenance:97]InitContractTotDirctExpense:15+vDEAdditional_add+vDEAdditional_transf
vDEapproxRemaining:=vDEupdated-vDEapproxSpent
vDEactualRemaining:=vDEupdated-vDEactualSpent

If (([Contract_Maintenance:97]ContractNo:1#"") | Not:C34(Is new record:C668([Contract_Maintenance:97])))
	SAVE RECORD:C53([Contract_Maintenance:97])
End if 