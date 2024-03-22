//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/21/06, 12:30:20
	// ----------------------------------------------------
	// Method: CIR_RecalcFundTransf
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(4/3/2006 12:22:30)
	Mods_2006_CM03
End if 

QUERY:C277([Contract FundTransfer:80]; [Contract FundTransfer:80]ContractNo:1=[Contracts:79]ContractNo:1)
C_REAL:C285($TLFadditional; $DEadditional; $TLFpending; $DEPending)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
$TLFadditional:=0
$DEadditional:=0
$TLFpending:=0
$DEPending:=0
For ($i; 1; Records in selection:C76([Contract FundTransfer:80]))
	GOTO SELECTED RECORD:C245([Contract FundTransfer:80]; $i)
	//If ([Contract FundTransfer]DateApproval#!00/00/00!)
	Case of 
		: ([Contract FundTransfer:80]TransferDirection:6="From Limiting Fee to Direct Expense")
			$TLFadditional:=$TLFadditional-[Contract FundTransfer:80]TransferAmount:7
			$DEadditional:=$DEadditional+[Contract FundTransfer:80]TransferAmount:7
			
		: ([Contract FundTransfer:80]TransferDirection:6="From Direct Expense to Limiting Fee")
			$TLFadditional:=$TLFadditional+[Contract FundTransfer:80]TransferAmount:7
			$DEadditional:=$DEadditional-[Contract FundTransfer:80]TransferAmount:7
		Else 
	End case 
	
End for 
vTLFPending_transf:=$TLFpending
vDEpending_transf:=$DEPending
vTLFPending:=vTLFpending_Transf+vTLFPending_add
vDEpending:=vDEpending_transf+vDEpending_add
vTLFAdditional_transf:=$TLFadditional
vDEAdditional_transf:=$DEadditional

vTLFupdated:=[Contracts:79]InitContractTotalLimitFee:14+vTLFAdditional_add+vTLFAdditional_transf
vTLFapproxRemaining:=vTLFupdated-vTLFapproxSpent
vTLFactualRemaining:=vTLFupdated-vTLFactualSpent

vDEupdated:=[Contracts:79]InitContractTotDirctExpense:15+vDEAdditional_add+vDEAdditional_transf
vDEapproxRemaining:=vDEupdated-vDEapproxSpent
vDEactualRemaining:=vDEupdated-vDEactualSpent
