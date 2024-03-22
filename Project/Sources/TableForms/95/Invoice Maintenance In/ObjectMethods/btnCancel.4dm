C_BOOLEAN:C305($vb_Changes)
$vb_Changes:=False:C215
$vb_Changes:=([Invoice_Maintenance:95]DirectExpenses:15#Old:C35([Invoice_Maintenance:95]DirectExpenses:15))
$vb_Changes:=$vb_Changes | ([Invoice_Maintenance:95]TotalAmount:11#Old:C35([Invoice_Maintenance:95]TotalAmount:11))
$vb_Changes:=$vb_Changes | ([Invoice_Maintenance:95]TotalLimFeeConstr:14#Old:C35([Invoice_Maintenance:95]TotalLimFeeConstr:14))
$vb_Changes:=$vb_Changes | ([Invoice_Maintenance:95]TotalLimFeeDes:8#Old:C35([Invoice_Maintenance:95]TotalLimFeeDes:8))
$vb_Changes:=$vb_Changes | ([Invoice_Maintenance:95]Retainage:16#Old:C35([Invoice_Maintenance:95]Retainage:16))
If ($vb_Changes)
	CONFIRM:C162("Expenses for this invoice have been changed!"+<>sCR+"Close Invoice without Saving?"; "Cancel"; "CloseNoSave")
	If (OK#1)
		CANCEL:C270
	End if 
Else 
	CANCEL:C270
End if 