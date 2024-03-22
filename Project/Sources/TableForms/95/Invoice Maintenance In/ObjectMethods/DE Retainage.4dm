If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(6/25/08 10:26:19)
	Mods_2008_CM_5404
	// Modified by: costasmanousakis-(Designer)-(12/18/08 09:03:01)
	Mods_2008_CM_5404  // ("PRESERVRETAIN")
	//  `Fixed Assignment Entries prompt;
	//  `Changed code to calcultate the retainage based on the previous invoices.
	Mods_2011_06  // CJ Miller`06/20/11, 11:33:55      ` Type all local variables for v11
End if 

If (Self:C308->=1)
	C_BOOLEAN:C305($continue_B)
	$continue_B:=True:C214
	If (Records in selection:C76([Invoice_AssignNo_Maintenance:94])>0)
		C_TEXT:C284($msg)
		$msg:="You are designating this invoice as a Retainage payment. But there are "+String:C10(Records in selection:C76([Invoice_AssignNo_Maintenance:94]))
		$msg:=$msg+"per Assignment Entries. If you continue the Per Assignment entries will be delete"+"d!"
		CONFIRM:C162($msg; "Continue"; "Cancel")
		If (OK=0)
			$continue_B:=False:C215
			Self:C308->:=0
		Else 
			DELETE SELECTION:C66([Invoice_AssignNo_Maintenance:94])
		End if 
		
	End if 
	If ($continue_B)
		[Invoice_Maintenance:95]TotalAmount:11:=0
		[Invoice_Maintenance:95]TotalLimFeeConstr:14:=0
		[Invoice_Maintenance:95]TotalLimFeeDes:8:=0
		C_REAL:C285($vR_PrevRetain)
		C_LONGINT:C283($i)
		$vR_PrevRetain:=0
		For ($i; 1; Size of array:C274(CM_InvNo_aL))
			If (CM_InvNo_aL{$i}<[Invoice_Maintenance:95]InvoiceNo:2)
				$vR_PrevRetain:=CM_InvRet_aR{$i}+$vR_PrevRetain
			End if 
		End for 
		[Invoice_Maintenance:95]Retainage:16:=-$vR_PrevRetain
		vInvoiceTotalPaid:=Abs:C99([Invoice_Maintenance:95]Retainage:16)
		OBJECT SET VISIBLE:C603(*; "DE AddRatingBtn"; False:C215)
		OBJECT SET VISIBLE:C603(*; "DE Subform@"; False:C215)
	End if 
	
End if 