//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/16/05, 13:58:45
	// ----------------------------------------------------
	// Method: CM_GetPrevInvoiceAssgnData
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

CurrAssTotalLimFeeDesP:=0
CurrAssTotalLimFeeConsP:=0
CurrAssDirExpenseP:=0
C_LONGINT:C283($i)
For ($i; 1; Size of array:C274(CM_InvAssgnINo_aL))
	If (CM_InvAssgnINo_aL{$i}<[Invoice_Maintenance:95]InvoiceNo:2)
		If (CM_InvAssgnANo_aI{$i}=[Invoice_AssignNo_Maintenance:94]AssignNo:2)
			CurrAssTotalLimFeeDesP:=CurrAssTotalLimFeeDesP+CM_InvAssgnTLF_D_aR{$i}
			CurrAssTotalLimFeeConsP:=CurrAssTotalLimFeeConsP+CM_InvAssgnTLF_C_aR{$i}
			CurrAssDirExpenseP:=CurrAssDirExpenseP+CM_InvAssgnDE_aR{$i}
			
		End if 
	End if 
End for 
