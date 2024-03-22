//%attributes = {}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/23/09, 15:17:22
	// ----------------------------------------------------
	// Method: CM_QR_GetAssignPaid
	// Description
	// Get the ammounts paid for an assignment.
	// Fills process variables than can be used in a quick report.
	// 
	// Parameters
	// None, uses the current [Contract_Assignment_Maintenance] record
	// ----------------------------------------------------
	
	Mods_2009_CM_5404
End if 
C_REAL:C285(CM_QR_AssgnDesTLFInvoice_R; CM_QR_AssgnConsTLFInvoice_R; CM_QR_AssgnDEInvoice_R; CM_QR_AssgnTotalInvoice_R)
CM_QR_AssgnDesTLFInvoice_R:=0
CM_QR_AssgnConsTLFInvoice_R:=0
CM_QR_AssgnDEInvoice_R:=0
CM_QR_AssgnTotalInvoice_R:=0
If (Is record loaded:C669([Contract_Assignment_Maintenance:101]))
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	QUERY:C277([Invoice_Maintenance:95]; [Invoice_Maintenance:95]ContractNo:3=[Contract_Assignment_Maintenance:101]ContractNo:1)
	If (Records in selection:C76([Invoice_Maintenance:95])>0)
		RELATE MANY SELECTION:C340([Invoice_AssignNo_Maintenance:94]InvoiceID:1)
		QUERY SELECTION:C341([Invoice_AssignNo_Maintenance:94]; [Invoice_AssignNo_Maintenance:94]AssignNo:2=[Contract_Assignment_Maintenance:101]AssignNo:2)
		ARRAY REAL:C219($InvTLF_ar; 0)
		ARRAY REAL:C219($InvDE_ar; 0)
		ARRAY REAL:C219($InvCTLF_ar; 0)
		SELECTION TO ARRAY:C260([Invoice_AssignNo_Maintenance:94]DirectExpense:5; $InvDE_ar; [Invoice_AssignNo_Maintenance:94]TotalLimFeeConstr:4; $InvCTLF_ar; [Invoice_AssignNo_Maintenance:94]TotalLimFeeDes:3; $InvTLF_ar)
		C_LONGINT:C283($loop)
		For ($loop; 1; Size of array:C274($InvTLF_ar))
			CM_QR_AssgnDesTLFInvoice_R:=CM_QR_AssgnDesTLFInvoice_R+$InvTLF_ar{$loop}
			CM_QR_AssgnConsTLFInvoice_R:=CM_QR_AssgnConsTLFInvoice_R+$InvCTLF_ar{$loop}
			CM_QR_AssgnDEInvoice_R:=CM_QR_AssgnDEInvoice_R+$InvDE_ar{$loop}
		End for 
		CM_QR_AssgnTotalInvoice_R:=CM_QR_AssgnDesTLFInvoice_R+CM_QR_AssgnConsTLFInvoice_R+CM_QR_AssgnDEInvoice_R
		
	End if 
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
End if 