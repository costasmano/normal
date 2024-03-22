//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/12/05, 09:33:16
	// ----------------------------------------------------
	// Method: CM_BuildArrays
	// Description
	// 
	//
	// Parameters
	//$1:ReLoadRelations : True/False
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(2/24/2006 12:53:54)
	Mods_2006_CM03
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_BOOLEAN:C305($1; $Reload_B)
If (Count parameters:C259=1)
	$Reload_B:=$1
Else 
	$Reload_B:=True:C214
End if 
If ($Reload_B)
	RELATE MANY:C262([Contract_Maintenance:97])
End if 

If (Records in selection:C76([Invoice_Maintenance:95])>0)
	RELATE MANY SELECTION:C340([Invoice_AssignNo_Maintenance:94]InvoiceID:1)  //get all data for each invoice
End if 

CM_SetupRelated(3)  //Reload [Contract_Project_Maintenance] records

CM_AssignmentSums

ARRAY REAL:C219(CM_InvTLF_D_aR; 0)
ARRAY REAL:C219(CM_InvTLF_C_aR; 0)
ARRAY REAL:C219(CM_InvDE_aR; 0)
ARRAY REAL:C219(CM_InvRet_aR; 0)
ARRAY LONGINT:C221(CM_InvNo_aL; 0)
ARRAY LONGINT:C221(CM_InvID_aL; 0)
SELECTION TO ARRAY:C260([Invoice_Maintenance:95]TotalLimFeeDes:8; CM_InvTLF_D_aR)
SELECTION TO ARRAY:C260([Invoice_Maintenance:95]TotalLimFeeConstr:14; CM_InvTLF_C_aR)
SELECTION TO ARRAY:C260([Invoice_Maintenance:95]DirectExpenses:15; CM_InvDE_aR)
SELECTION TO ARRAY:C260([Invoice_Maintenance:95]Retainage:16; CM_InvRet_aR)
SELECTION TO ARRAY:C260([Invoice_Maintenance:95]InvoiceNo:2; CM_InvNo_aL)
SELECTION TO ARRAY:C260([Invoice_Maintenance:95]InvoiceID:1; CM_InvID_aL)
SORT ARRAY:C229(CM_InvNo_aL; CM_InvRet_aR; CM_InvDE_aR; CM_InvTLF_C_aR; CM_InvTLF_D_aR; CM_InvID_aL)

ARRAY REAL:C219(CM_InvAssgnTLF_D_aR; 0)
ARRAY REAL:C219(CM_InvAssgnTLF_C_aR; 0)
ARRAY REAL:C219(CM_InvAssgnDE_aR; 0)
ARRAY INTEGER:C220(CM_InvAssgnANo_aI; 0)
ARRAY LONGINT:C221(CM_InvAssgnID_aL; 0)
SELECTION TO ARRAY:C260([Invoice_AssignNo_Maintenance:94]TotalLimFeeConstr:4; CM_InvAssgnTLF_C_aR)
SELECTION TO ARRAY:C260([Invoice_AssignNo_Maintenance:94]TotalLimFeeDes:3; CM_InvAssgnTLF_D_aR)
SELECTION TO ARRAY:C260([Invoice_AssignNo_Maintenance:94]DirectExpense:5; CM_InvAssgnDE_aR)
SELECTION TO ARRAY:C260([Invoice_AssignNo_Maintenance:94]AssignNo:2; CM_InvAssgnANo_aI)
SELECTION TO ARRAY:C260([Invoice_AssignNo_Maintenance:94]InvoiceID:1; CM_InvAssgnID_aL)
ARRAY LONGINT:C221(CM_InvAssgnINo_aL; Size of array:C274(CM_InvAssgnANo_aI))
C_LONGINT:C283($i; $k)
For ($i; 1; Size of array:C274(CM_InvAssgnINo_aL))
	$k:=Find in array:C230(CM_InvID_aL; CM_InvAssgnID_aL{$i})
	If ($k>0)
		CM_InvAssgnINo_aL{$i}:=CM_InvNo_aL{$k}
	End if 
	
End for 
CM_SortInvAssgnArr