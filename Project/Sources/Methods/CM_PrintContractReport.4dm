//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/23/05, 14:18:35
	// ----------------------------------------------------
	// Method: CM_PrintContractReport
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(2/24/2006 12:48:39)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:36:39)
	Mods_2007_CM12_5301
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

If (Not:C34(Is record loaded:C669([Contract_Maintenance:97])))
	LOAD RECORD:C52([Contract_Maintenance:97])
End if 
C_LONGINT:C283($i; $j)
//print header first.
C_REAL:C285($printHt; $printable_ht; $printable_wt)
PRINT SETTINGS:C106
If (OK=1)
	G_PrintOptions(-1; " "; 85)
	RELATE MANY:C262([Contract_Maintenance:97])
	RELATE MANY SELECTION:C340([Invoice_AssignNo_Maintenance:94]InvoiceID:1)
	COPY NAMED SELECTION:C331([Invoice_AssignNo_Maintenance:94]; "CONTRACTINVOICEPARTS")
	COPY NAMED SELECTION:C331([Invoice_Maintenance:95]; "CONTRACTINVOICES")
	COPY NAMED SELECTION:C331([Contract_Assignment_Maintenance:101]; "CONTRACTASSGNS")
	COPY NAMED SELECTION:C331([Contract_Project_Maintenance:100]; "CONTRACTPROJECTS")
	G_MaintenanceCalculateTLFandDE
	
	C_TEXT:C284(vCMRptDateTime_S)  // Command Replaced was o_C_STRING length was 32
	vCMRptDateTime_S:=String:C10(Current date:C33(*); Internal date short:K1:7)+" - "+String:C10(Current time:C178(*); HH MM:K7:2)
	C_LONGINT:C283(vCMRptPage)  //Command Replaced was o_C_INTEGER
	vCMRptPage:=0
	GET PRINTABLE AREA:C703($printable_ht; $printable_wt)
	$printHt:=Print form:C5([Contract_Maintenance:97]; "PrintDetail"; Form header:K43:3)
	$printHt:=$printHt+Print form:C5([Contract_Maintenance:97]; "PrintDetail")  //print the detail
	C_REAL:C285(vFundTransfTLF; vFundTransfDE; vAddFundTLF; vAddFundDE; vAddFundTotal; vTLFRetainageUsed)
	If (Records in selection:C76([FundTransfer_Maintenance:96])>0)
		ORDER BY:C49([FundTransfer_Maintenance:96]; [FundTransfer_Maintenance:96]DateApproval:5)
		For ($i; 1; Records in selection:C76([FundTransfer_Maintenance:96]))
			GOTO SELECTED RECORD:C245([FundTransfer_Maintenance:96]; $i)
			Case of 
				: ([FundTransfer_Maintenance:96]TransferDirection:6="From Limiting Fee to Direct Expense")
					vFundTransfTLF:=-[FundTransfer_Maintenance:96]TransferAmount:7
					vFundTransfDE:=[FundTransfer_Maintenance:96]TransferAmount:7
					
				: ([FundTransfer_Maintenance:96]TransferDirection:6="From Direct Expense to Limiting Fee")
					vFundTransfTLF:=[FundTransfer_Maintenance:96]TransferAmount:7
					vFundTransfDE:=-[FundTransfer_Maintenance:96]TransferAmount:7
			End case 
			$printHt:=$printHt+Print form:C5([Contract_Maintenance:97]; "PrintDetail"; Form break2:K43:16)
		End for 
	End if 
	If (Records in selection:C76([AddFund_Maintenance:99])>0)
		ORDER BY:C49([AddFund_Maintenance:99]; [AddFund_Maintenance:99]DateApproval:5)
		For ($i; 1; Records in selection:C76([AddFund_Maintenance:99]))
			GOTO SELECTED RECORD:C245([AddFund_Maintenance:99]; $i)
			vAddFundTLF:=[AddFund_Maintenance:99]TotalLimitFee:6
			vAddFundDE:=[AddFund_Maintenance:99]DirectExpense:7
			vAddFundTotal:=[AddFund_Maintenance:99]Total:8
			$printHt:=$printHt+Print form:C5([Contract_Maintenance:97]; "PrintDetail"; Form break1:K43:15)
		End for 
	End if 
	vTLFRetainageUsed:=vTLFActualSpent-vTLFActualPaid
	$printHt:=$printHt+Print form:C5([Contract_Maintenance:97]; "PrintDetail"; Form break0:K43:14)
	C_REAL:C285(vAssgnTLFDes; vAssgnTLFConstr; vAssgnTLFtot; vAssgnDE; vAssgnTotal)
	C_REAL:C285(vAssgnAddTLFDes; vAssgnAddTLFConstr; vAssgnAddTLFTot; vAssgnAddDE; vAssgnAddTotal)
	C_REAL:C285(vAssgnSumTLFDes; vAssgnSumTLFConstr; vAssgnSumTLFTot; vAssgnSumDE; vAssgnSumTotal)
	C_REAL:C285(vAssgnBalTLFDes; vAssgnBalTLFConstr; vAssgnBalTLFTot; vAssgnBalDE; vAssgnBalTotal)
	C_REAL:C285(vInvAssgnTLFDES; vInvAssgnTLFConstr; vInvAssgnTLFTot; vInvAssgnDE; vInvAssgnTotal)
	C_REAL:C285(vInvAssgnTLFDESSum; vInvAssgnTLFConstrSum; vInvAssgnTLFTotSum; vInvAssgnDESum; vInvAssgnTotalSum)
	C_LONGINT:C283(vAssgnAddNo; vInvAssgnInvNo)  //Command Replaced was o_C_INTEGER
	C_TEXT:C284(vCMRptAssgnNo_S)  // Command Replaced was o_C_STRING length was 12
	C_LONGINT:C283($vInvoicedTimes_I)  //Command Replaced was o_C_INTEGER
	
	If (Records in selection:C76([Contract_Assignment_Maintenance:101])>0)
		
		$printHt:=$printHt+Print form:C5([Contract_Assignment_Maintenance:101]; "PrintAssignReport"; Form header:K43:3)
		
		ORDER BY:C49([Contract_Assignment_Maintenance:101]; [Contract_Assignment_Maintenance:101]AssignNo:2)
		For ($i; 1; Records in selection:C76([Contract_Assignment_Maintenance:101]))
			GOTO SELECTED RECORD:C245([Contract_Assignment_Maintenance:101]; $i)
			vAssgnSumTLFDes:=0
			vAssgnSumTLFConstr:=0
			vAssgnSumTLFTot:=0
			vAssgnSumDE:=0
			vAssgnSumTotal:=0
			vInvAssgnTLFDESSum:=0
			vInvAssgnTLFConstrSum:=0
			vInvAssgnTLFTotSum:=0
			vInvAssgnDESum:=0
			vInvAssgnTotalSum:=0
			vAssgnBalTLFDes:=0
			vAssgnBalTLFConstr:=0
			vAssgnBalTLFTot:=0
			vAssgnBalDE:=0
			vAssgnBalTotal:=0
			
			vCMRptAssgnNo_S:=String:C10([Contract_Assignment_Maintenance:101]AssignNo:2)
			//print assignment header[Contract_Assignment_Maintenance]
			If ([Contract_Assignment_Maintenance:101]AcutalOrEstimate:20="Negotiated")
				vAssgnTLFDes:=[Contract_Assignment_Maintenance:101]Est_TotalLimitFee:13
				vAssgnTLFConstr:=[Contract_Assignment_Maintenance:101]Est_ConstrTotalLimitFee:30
				vAssgnTLFtot:=vAssgnTLFDes+vAssgnTLFConstr
				vAssgnDE:=[Contract_Assignment_Maintenance:101]Est_DirectExpense:14
				vAssgnTotal:=[Contract_Assignment_Maintenance:101]Est_Total:15
				vAssgnSumTLFDes:=[Contract_Assignment_Maintenance:101]Est_TotalLimitFee:13
				vAssgnSumTLFConstr:=[Contract_Assignment_Maintenance:101]Est_ConstrTotalLimitFee:30
				vAssgnSumTLFTot:=vAssgnTLFtot
				vAssgnSumDE:=[Contract_Assignment_Maintenance:101]Est_DirectExpense:14
				vAssgnSumTotal:=[Contract_Assignment_Maintenance:101]Est_Total:15
				
			Else 
				vAssgnTLFDes:=[Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25
				vAssgnTLFConstr:=[Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34
				vAssgnTLFtot:=vAssgnTLFDes+vAssgnTLFConstr
				vAssgnDE:=[Contract_Assignment_Maintenance:101]Actual_DirectExpense:26
				vAssgnTotal:=[Contract_Assignment_Maintenance:101]Actual_Total:9
			End if 
			If (($printable_ht-$printHt)<73)
				PAGE BREAK:C6(>)
				$printHt:=Print form:C5([Contract_Maintenance:97]; "PrintDetail"; Form header1:K43:4)
				$printHt:=$printHt+Print form:C5([Contract_Assignment_Maintenance:101]; "PrintAssignReport"; Form header:K43:3)
			End if 
			
			$printHt:=$printHt+Print form:C5([Contract_Assignment_Maintenance:101]; "PrintAssignReport"; Form header1:K43:4)
			$printHt:=$printHt+Print form:C5([Contract_Assignment_Maintenance:101]; "PrintAssignReport"; Form detail:K43:1)
			
			If ([Contract_Assignment_Maintenance:101]AcutalOrEstimate:20="Negotiated")
				RELATE MANY:C262([Contract_Assignment_Maintenance:101])
				If (Records in selection:C76([Addendum_Maintenance:102])>0)
					ORDER BY:C49([Addendum_Maintenance:102]; [Addendum_Maintenance:102]AddendumNo:2)
					For ($j; 1; Records in selection:C76([Addendum_Maintenance:102]))
						GOTO SELECTED RECORD:C245([Addendum_Maintenance:102]; $j)
						vAssgnAddNo:=[Addendum_Maintenance:102]AddendumNo:2
						vAssgnAddTLFDes:=[Addendum_Maintenance:102]Est_TotalLimitFee:16
						vAssgnAddTLFConstr:=[Addendum_Maintenance:102]Est_ConstrTotalLimitFee:10
						vAssgnAddTLFTot:=vAssgnAddTLFDes+vAssgnAddTLFConstr
						vAssgnAddDE:=[Addendum_Maintenance:102]Est_DirectExpense:11
						vAssgnAddTotal:=[Addendum_Maintenance:102]Est_Total:15
						vAssgnSumTLFDes:=vAssgnSumTLFDes+vAssgnAddTLFDes
						vAssgnSumTLFConstr:=vAssgnSumTLFConstr+vAssgnAddTLFConstr
						vAssgnSumTLFTot:=vAssgnSumTLFTot+vAssgnAddTLFTot
						vAssgnSumDE:=vAssgnSumDE+vAssgnAddDE
						vAssgnSumTotal:=vAssgnSumTotal+vAssgnAddTotal
						If (($printable_ht-$printHt)<32)
							PAGE BREAK:C6(>)
							$printHt:=Print form:C5([Contract_Maintenance:97]; "PrintDetail"; Form header1:K43:4)
							vCMRptAssgnNo_S:=String:C10([Contract_Assignment_Maintenance:101]AssignNo:2)+"(Cont'd)"
							$printHt:=$printHt+Print form:C5([Contract_Assignment_Maintenance:101]; "PrintAssignReport"; Form header:K43:3)
							$printHt:=$printHt+Print form:C5([Contract_Assignment_Maintenance:101]; "PrintAssignReport"; Form header1:K43:4)
						End if 
						
						$printHt:=$printHt+Print form:C5([Contract_Assignment_Maintenance:101]; "PrintAssignReport"; Form break2:K43:16)
					End for 
					
					$printHt:=$printHt+Print form:C5([Contract_Assignment_Maintenance:101]; "PrintAssignReport"; Form break1:K43:15)
					
				End if 
				//get invoices for this assignment
				USE NAMED SELECTION:C332("CONTRACTINVOICEPARTS")
				QUERY SELECTION:C341([Invoice_AssignNo_Maintenance:94]; [Invoice_AssignNo_Maintenance:94]AssignNo:2=[Contract_Assignment_Maintenance:101]AssignNo:2)
				ORDER BY:C49([Invoice_AssignNo_Maintenance:94]; [Invoice_Maintenance:95]InvoiceNo:2)
				$vInvoicedTimes_I:=Records in selection:C76([Invoice_AssignNo_Maintenance:94])
				If ($vInvoicedTimes_I>0)
					vInvAssgnTLFDESSum:=0
					vInvAssgnTLFConstrSum:=0
					vInvAssgnTLFTotSum:=0
					vInvAssgnDESum:=0
					vInvAssgnTotalSum:=0
					If (($printable_ht-$printHt)<69)
						PAGE BREAK:C6(>)
						$printHt:=Print form:C5([Contract_Maintenance:97]; "PrintDetail"; Form header1:K43:4)
						vCMRptAssgnNo_S:=String:C10([Contract_Assignment_Maintenance:101]AssignNo:2)+"(Cont'd)"
						$printHt:=$printHt+Print form:C5([Contract_Assignment_Maintenance:101]; "PrintAssignReport"; Form header:K43:3)
						$printHt:=$printHt+Print form:C5([Contract_Assignment_Maintenance:101]; "PrintAssignReport"; Form header1:K43:4)
					End if 
					vInvCont:=""
					$printHt:=$printHt+Print form:C5([Invoice_AssignNo_Maintenance:94]; "PrintInvoices"; Form header:K43:3)
					
					For ($j; 1; $vInvoicedTimes_I)
						GOTO SELECTED RECORD:C245([Invoice_AssignNo_Maintenance:94]; $j)
						LOAD RECORD:C52([Invoice_AssignNo_Maintenance:94])
						RELATE ONE:C42([Invoice_AssignNo_Maintenance:94]InvoiceID:1)
						vInvAssgnInvNo:=[Invoice_Maintenance:95]InvoiceNo:2
						vInvAssgnTLFDES:=[Invoice_AssignNo_Maintenance:94]TotalLimFeeDes:3
						vInvAssgnTLFConstr:=[Invoice_AssignNo_Maintenance:94]TotalLimFeeConstr:4
						vInvAssgnTLFTot:=vInvAssgnTLFDES+vInvAssgnTLFConstr
						vInvAssgnDE:=[Invoice_AssignNo_Maintenance:94]DirectExpense:5
						vInvAssgnTotal:=vInvAssgnTLFTot+vInvAssgnDE
						vInvAssgnTLFDESSum:=vInvAssgnTLFDESSum+vInvAssgnTLFDES
						vInvAssgnTLFConstrSum:=vInvAssgnTLFConstrSum+vInvAssgnTLFConstr
						vInvAssgnTLFTotSum:=vInvAssgnTLFTotSum+vInvAssgnTLFTot
						vInvAssgnDESum:=vInvAssgnDESum+vInvAssgnDE
						vInvAssgnTotalSum:=vInvAssgnTotalSum+vInvAssgnTotal
						If (($printable_ht-$printHt)<61)
							PAGE BREAK:C6(>)
							$printHt:=Print form:C5([Contract_Maintenance:97]; "PrintDetail"; Form header1:K43:4)
							vCMRptAssgnNo_S:=String:C10([Contract_Assignment_Maintenance:101]AssignNo:2)+"(Cont'd)"
							vInvCont:="(Cont'd)"
							$printHt:=$printHt+Print form:C5([Contract_Assignment_Maintenance:101]; "PrintAssignReport"; Form header:K43:3)
							$printHt:=$printHt+Print form:C5([Contract_Assignment_Maintenance:101]; "PrintAssignReport"; Form header1:K43:4)
							$printHt:=$printHt+Print form:C5([Invoice_AssignNo_Maintenance:94]; "PrintInvoices"; Form header:K43:3)
						End if 
						$printHt:=$printHt+Print form:C5([Invoice_AssignNo_Maintenance:94]; "PrintInvoices")
					End for 
					$printHt:=$printHt+Print form:C5([Invoice_AssignNo_Maintenance:94]; "PrintInvoices"; Form break0:K43:14)
					
				End if 
				vAssgnBalTLFDes:=vAssgnSumTLFDes-vInvAssgnTLFDESSum
				vAssgnBalTLFConstr:=vAssgnSumTLFConstr-vInvAssgnTLFConstrSum
				vAssgnBalTLFTot:=vAssgnSumTLFTot-vInvAssgnTLFTotSum
				vAssgnBalDE:=vAssgnSumDE-vInvAssgnDESum
				vAssgnBalTotal:=vAssgnSumTotal-vInvAssgnTotalSum
				
				$printHt:=$printHt+Print form:C5([Contract_Assignment_Maintenance:101]; "PrintAssignReport"; Form break0:K43:14)
				
			End if 
			
		End for 
		
	End if 
	
	PAGE BREAK:C6
	USE NAMED SELECTION:C332("CONTRACTINVOICES")
	USE NAMED SELECTION:C332("CONTRACTASSGNS")
	USE NAMED SELECTION:C332("CONTRACTPROJECTS")
	CLEAR NAMED SELECTION:C333("CONTRACTINVOICEPARTS")
	CLEAR NAMED SELECTION:C333("CONTRACTINVOICES")
	CLEAR NAMED SELECTION:C333("CONTRACTASSGNS")
	CLEAR NAMED SELECTION:C333("CONTRACTPROJECTS")
	
End if 