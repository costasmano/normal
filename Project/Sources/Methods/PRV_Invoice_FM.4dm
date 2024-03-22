//%attributes = {"invisible":true}
// Method: PRV_Invoice_FM
// Description
// 
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/14/12, 14:39:36
	// ----------------------------------------------------
	// First Release
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Load:K2:1)
		If (Is new record:C668([Invoice_Maintenance:95]))
			Inc_Sequence("InvoiceMaint"; ->[Invoice_Maintenance:95]InvoiceID:1)
			C_LONGINT:C283(PRV_LASTSEQNO_L; PRV_CURRASSIGNID_L)
			PRV_CURRASSIGNID_L:=[Contract_Assignment_Maintenance:101]AssignID:3
			Begin SQL
				select max(Invoice_Maintenance.InvoiceNo)
				from [Invoice_Maintenance]
				where Invoice_Maintenance.AssignID_L = :PRV_CURRASSIGNID_L
				into :PRV_LASTSEQNO_L
			End SQL
			[Invoice_Maintenance:95]DateReceived:4:=Current date:C33(*)
			[Invoice_Maintenance:95]InvoiceNo:2:=PRV_LASTSEQNO_L+1
			[Invoice_Maintenance:95]ContractNo:3:=[Contract_Assignment_Maintenance:101]ContractNo:1
			[Invoice_Maintenance:95]AssignID_L:20:=[Contract_Assignment_Maintenance:101]AssignID:3
			[Invoice_Maintenance:95]AssignNo:7:=[Contract_Assignment_Maintenance:101]AssignNo:2
		End if 
		PRV_InvActCostTLF_r:=[Invoice_Maintenance:95]TotalLimFeeConstr:14+[Invoice_Maintenance:95]TotalLimFeeDes:8
		
		If (PRV_LockedAssignment_b)
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "DE@Btn"; False:C215)
		End if 
		
	: ($FormEvent_L=On Data Change:K2:15)
		PRV_InvActCostTLF_r:=[Invoice_Maintenance:95]TotalLimFeeConstr:14+[Invoice_Maintenance:95]TotalLimFeeDes:8
		
	: ($FormEvent_L=On Validate:K2:3)
		
	: ($FormEvent_L=On Unload:K2:2)
		
End case 

//End PRV_Invoice_FM