//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/11/05, 15:02:08
	// ----------------------------------------------------
	// Method: CM_UpdateInvoiceTotals
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(9/1/2006 15:51:52)
	Mods_2006_CM06
	// Modified by: costasmanousakis-(Designer)-(6/25/08 10:13:41)
	Mods_2008_CM_5404
	// Modified by: costasmanousakis-(Designer)-(7/31/08 15:52:55)
	Mods_2008_CM_5404
	//  `Added declaration of $i,$j,$k
	//  `Added code to check if the retainage has been paid on a previous invoice
	//  `(find a minus retainage in the invoices) then don't subtract retainage from this invoice
	// Modified by: costasmanousakis-(Designer)-(8/1/08 14:56:48)
	Mods_2008_CM_5404
	//  `fixed logic error in yesterday changes
	// Modified by: costasmanousakis-(Designer)-(3/19/09 09:30:17)
	Mods_2009_CM_5404
	//Added cost recovery
End if 
C_REAL:C285(vInvoiceTotalPaid)
ARRAY REAL:C219($CM_InvAssgnTLF_C_aR; 0)
ARRAY REAL:C219($CM_InvAssgnTLF_D_aR; 0)
ARRAY REAL:C219($CM_InvAssgnDE_aR; 0)
ARRAY LONGINT:C221($CM_InvAssgnID_aL; 0)
ARRAY INTEGER:C220($CM_InvAssgnANo_aI; 0)
C_LONGINT:C283($i; $j; $k)
If ([Invoice_Maintenance:95]Retainage:16>=0)
	SELECTION TO ARRAY:C260([Invoice_AssignNo_Maintenance:94]AssignNo:2; CM_Inv_AssgnList)
	SELECTION TO ARRAY:C260([Invoice_AssignNo_Maintenance:94]TotalLimFeeConstr:4; $CM_InvAssgnTLF_C_aR; [Invoice_AssignNo_Maintenance:94]TotalLimFeeDes:3; $CM_InvAssgnTLF_D_aR)
	SELECTION TO ARRAY:C260([Invoice_AssignNo_Maintenance:94]DirectExpense:5; $CM_InvAssgnDE_aR; [Invoice_AssignNo_Maintenance:94]AssignNo:2; $CM_InvAssgnANo_aI)
	SELECTION TO ARRAY:C260([Invoice_AssignNo_Maintenance:94]InvoiceID:1; $CM_InvAssgnID_aL)
	
	[Invoice_Maintenance:95]DirectExpenses:15:=0
	[Invoice_Maintenance:95]TotalLimFeeConstr:14:=0
	[Invoice_Maintenance:95]TotalLimFeeDes:8:=0
	For ($i; 1; Records in selection:C76([Invoice_AssignNo_Maintenance:94]))
		[Invoice_Maintenance:95]DirectExpenses:15:=[Invoice_Maintenance:95]DirectExpenses:15+$CM_InvAssgnDE_aR{$i}
		[Invoice_Maintenance:95]TotalLimFeeConstr:14:=[Invoice_Maintenance:95]TotalLimFeeConstr:14+$CM_InvAssgnTLF_C_aR{$i}
		[Invoice_Maintenance:95]TotalLimFeeDes:8:=[Invoice_Maintenance:95]TotalLimFeeDes:8+$CM_InvAssgnTLF_D_aR{$i}
	End for 
	
	[Invoice_Maintenance:95]TotalAmount:11:=[Invoice_Maintenance:95]DirectExpenses:15+[Invoice_Maintenance:95]TotalLimFeeConstr:14+[Invoice_Maintenance:95]TotalLimFeeDes:8
	C_REAL:C285($VR_ContrRetain; $vR_ContrRetainPct)
	$VR_ContrRetain:=[Contract_Maintenance:97]RetainageAmtInit:30
	$vR_ContrRetainPct:=[Contract_Maintenance:97]RetainagePct:31/100
	C_REAL:C285($vR_PrevRetain)
	$vR_PrevRetain:=0
	//Check if retainage has been paid in an existing invoice (the full retainage paid is a negative value)
	$k:=Find in array:C230(CM_InvRet_aR; (-$VR_ContrRetain))
	C_BOOLEAN:C305($CheckPrevRetainage_b)
	$CheckPrevRetainage_b:=False:C215
	If ($k>0)
		//retainage has been paid in an existing invoice
		If (CM_InvNo_aL{$k}<[Invoice_Maintenance:95]InvoiceNo:2)
			//paid in a "previous" invoice number ; we don't deduct retainage for this invoice
			[Invoice_Maintenance:95]Retainage:16:=0
		Else 
			//paid in a "later" invoice number ; we need to check if we have to deduct retainage for this invoice.
			$CheckPrevRetainage_b:=True:C214  //
		End if 
	Else 
		//retainage has NOT been paid in an existing invoice ; we need to check if we have to deduct retainage for this invoice.
		$CheckPrevRetainage_b:=True:C214
	End if 
	If ($CheckPrevRetainage_b)
		//Look for invoices with number less than the current one and sum all the Previously paid retainage
		For ($i; 1; Size of array:C274(CM_InvNo_aL))
			If (CM_InvNo_aL{$i}<[Invoice_Maintenance:95]InvoiceNo:2)
				$vR_PrevRetain:=CM_InvRet_aR{$i}+$vR_PrevRetain
			End if 
		End for 
		If ($vR_PrevRetain<$VR_ContrRetain)
			[Invoice_Maintenance:95]Retainage:16:=Round:C94((([Invoice_Maintenance:95]TotalLimFeeConstr:14+[Invoice_Maintenance:95]TotalLimFeeDes:8)*$vR_ContrRetainPct); 2)
			If (([Invoice_Maintenance:95]Retainage:16+$vR_PrevRetain)>$VR_ContrRetain)
				[Invoice_Maintenance:95]Retainage:16:=$VR_ContrRetain-$vR_PrevRetain
			End if 
		Else 
			[Invoice_Maintenance:95]Retainage:16:=0
		End if 
		
	End if 
	
Else 
	
End if 
vInvoiceTotalPaid:=[Invoice_Maintenance:95]TotalAmount:11-[Invoice_Maintenance:95]Retainage:16-[Invoice_Maintenance:95]CostRecovery:17
//Update array for invoices
$j:=Find in array:C230(CM_InvNo_aL; [Invoice_Maintenance:95]InvoiceNo:2)
If ($j>0)
	CM_InvTLF_D_aR{$j}:=[Invoice_Maintenance:95]TotalLimFeeDes:8
	CM_InvTLF_C_aR{$j}:=[Invoice_Maintenance:95]TotalLimFeeConstr:14
	CM_InvDE_aR{$j}:=[Invoice_Maintenance:95]DirectExpenses:15
	CM_InvRet_aR{$j}:=[Invoice_Maintenance:95]Retainage:16
	CM_InvID_aL{$j}:=[Invoice_Maintenance:95]InvoiceID:1
Else 
	$j:=Size of array:C274(CM_InvNo_aL)+1
	
	INSERT IN ARRAY:C227(CM_InvTLF_D_aR; $j)
	INSERT IN ARRAY:C227(CM_InvTLF_C_aR; $j)
	INSERT IN ARRAY:C227(CM_InvDE_aR; $j)
	INSERT IN ARRAY:C227(CM_InvRet_aR; $j)
	INSERT IN ARRAY:C227(CM_InvNo_aL; $j)
	INSERT IN ARRAY:C227(CM_InvID_aL; $j)
	
	CM_InvTLF_D_aR{$j}:=[Invoice_Maintenance:95]TotalLimFeeDes:8
	CM_InvTLF_C_aR{$j}:=[Invoice_Maintenance:95]TotalLimFeeConstr:14
	CM_InvDE_aR{$j}:=[Invoice_Maintenance:95]DirectExpenses:15
	CM_InvRet_aR{$j}:=[Invoice_Maintenance:95]Retainage:16
	CM_InvID_aL{$j}:=[Invoice_Maintenance:95]InvoiceID:1
	CM_InvNo_aL{$j}:=[Invoice_Maintenance:95]InvoiceNo:2
	SORT ARRAY:C229(CM_InvNo_aL; CM_InvRet_aR; CM_InvDE_aR; CM_InvTLF_C_aR; CM_InvTLF_D_aR; CM_InvID_aL)
End if 

//Update Inv-Assgn...arrays for this invoice
For ($k; 1; Size of array:C274($CM_InvAssgnANo_aI))
	C_BOOLEAN:C305($InvAssgnFound_B)
	$InvAssgnFound_B:=False:C215
	For ($j; 1; Size of array:C274(CM_InvAssgnINo_aL))
		$InvAssgnFound_B:=(CM_InvAssgnINo_aL{$j}=[Invoice_Maintenance:95]InvoiceNo:2)
		$InvAssgnFound_B:=$InvAssgnFound_B & ($CM_InvAssgnANo_aI{$k}=CM_InvAssgnANo_aI{$j})
		If ($InvAssgnFound_B)
			CM_InvAssgnTLF_C_aR{$j}:=$CM_InvAssgnTLF_C_aR{$k}
			CM_InvAssgnTLF_D_aR{$j}:=$CM_InvAssgnTLF_D_aR{$k}
			CM_InvAssgnDE_aR{$j}:=$CM_InvAssgnDE_aR{$k}
			$j:=Size of array:C274(CM_InvAssgnINo_aL)+1
		End if 
	End for 
	If (Not:C34($InvAssgnFound_B))
		$j:=Size of array:C274(CM_InvAssgnINo_aL)+1
		INSERT IN ARRAY:C227(CM_InvAssgnTLF_C_aR; $j)
		CM_InvAssgnTLF_C_aR{$j}:=$CM_InvAssgnTLF_C_aR{$k}
		INSERT IN ARRAY:C227(CM_InvAssgnTLF_D_aR; $j)
		CM_InvAssgnTLF_D_aR{$j}:=$CM_InvAssgnTLF_D_aR{$k}
		INSERT IN ARRAY:C227(CM_InvAssgnDE_aR; $j)
		CM_InvAssgnDE_aR{$j}:=$CM_InvAssgnDE_aR{$k}
		INSERT IN ARRAY:C227(CM_InvAssgnANo_aI; $j)
		CM_InvAssgnANo_aI{$j}:=$CM_InvAssgnANo_aI{$k}
		INSERT IN ARRAY:C227(CM_InvAssgnID_aL; $j)
		CM_InvAssgnID_aL{$j}:=$CM_InvAssgnID_aL{$k}
		INSERT IN ARRAY:C227(CM_InvAssgnINo_aL; $j)
		CM_InvAssgnINo_aL{$j}:=[Invoice_Maintenance:95]InvoiceNo:2
	End if 
End for 
//Now remove unused Inv-Assignment combinations
$j:=Size of array:C274(CM_InvAssgnINo_aL)
For ($k; $j; 1; -1)
	If (CM_InvAssgnINo_aL{$k}=[Invoice_Maintenance:95]InvoiceNo:2)
		If (Find in array:C230($CM_InvAssgnANo_aI; CM_InvAssgnANo_aI{$k})<0)
			DELETE FROM ARRAY:C228(CM_InvAssgnANo_aI; $k)
			DELETE FROM ARRAY:C228(CM_InvAssgnTLF_C_aR; $k)
			DELETE FROM ARRAY:C228(CM_InvAssgnTLF_D_aR; $k)
			DELETE FROM ARRAY:C228(CM_InvAssgnDE_aR; $k)
			DELETE FROM ARRAY:C228(CM_InvAssgnID_aL; $k)
			DELETE FROM ARRAY:C228(CM_InvAssgnINo_aL; $k)
			
		End if 
	End if 
End for 
CM_SortInvAssgnArr