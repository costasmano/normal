//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/16/06, 15:35:26
	// ----------------------------------------------------
	// Method: CM_RecalcFundTransf
	// Description
	// Recalculate Values due to fund transfers
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(4/3/2006 12:19:47)
	Mods_2006_CM03
End if 
QUERY:C277([FundTransfer_Maintenance:96]; [FundTransfer_Maintenance:96]ContractNo:1=[Contract_Maintenance:97]ContractNo:1)
C_REAL:C285($TLFadditional; $DEadditional; $TLFpending; $DEPending)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
$TLFadditional:=0
$DEadditional:=0
$TLFpending:=0
$DEPending:=0
For ($i; 1; Records in selection:C76([FundTransfer_Maintenance:96]))
	GOTO SELECTED RECORD:C245([FundTransfer_Maintenance:96]; $i)
	If ([FundTransfer_Maintenance:96]DateApproval:5#!00-00-00!)
		Case of 
			: ([FundTransfer_Maintenance:96]TransferDirection:6="From Limiting Fee to Direct Expense")
				$TLFadditional:=$TLFadditional-[FundTransfer_Maintenance:96]TransferAmount:7
				$DEadditional:=$DEadditional+[FundTransfer_Maintenance:96]TransferAmount:7
				
			: ([FundTransfer_Maintenance:96]TransferDirection:6="From Direct Expense to Limiting Fee")
				$TLFadditional:=$TLFadditional+[FundTransfer_Maintenance:96]TransferAmount:7
				$DEadditional:=$DEadditional-[FundTransfer_Maintenance:96]TransferAmount:7
			Else 
		End case 
		
	Else 
		Case of 
			: ([FundTransfer_Maintenance:96]TransferDirection:6="From Limiting Fee to Direct Expense")
				$TLFpending:=$TLFpending-[FundTransfer_Maintenance:96]TransferAmount:7
				$DEPending:=$DEPending+[FundTransfer_Maintenance:96]TransferAmount:7
				
			: ([FundTransfer_Maintenance:96]TransferDirection:6="From Direct Expense to Limiting Fee")
				$TLFpending:=$TLFpending+[FundTransfer_Maintenance:96]TransferAmount:7
				$DEPending:=$DEPending-[FundTransfer_Maintenance:96]TransferAmount:7
			Else 
		End case 
		
	End if 
	
End for 
vTLFPending_transf:=$TLFpending
vDEpending_transf:=$DEPending
vTLFPending:=vTLFpending_Transf+vTLFPending_add
vDEpending:=vDEpending_transf+vDEpending_add
vTLFAdditional_transf:=$TLFadditional
vDEAdditional_transf:=$DEadditional

vTLFupdated:=[Contract_Maintenance:97]InitContractTotalLimitFee:14+vTLFAdditional_add+vTLFAdditional_transf
vTLFapproxRemaining:=vTLFupdated-vTLFapproxSpent
vTLFactualRemaining:=vTLFupdated-vTLFactualSpent

vDEupdated:=[Contract_Maintenance:97]InitContractTotDirctExpense:15+vDEAdditional_add+vDEAdditional_transf
vDEapproxRemaining:=vDEupdated-vDEapproxSpent
vDEactualRemaining:=vDEupdated-vDEactualSpent
