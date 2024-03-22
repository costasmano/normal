//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/13/10, 11:10:31
	// ----------------------------------------------------
	// Method: DCM_ContractQ_OM
	// Description
	
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_12
End if 

Case of 
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($RowSel_L)
		$RowSel_L:=ITMLB_ItemQ_ar
		ITMLB_ItemQRem_ar{$RowSel_L}:=ITMLB_ItemQ_ar{$RowSel_L}-ITMLB_ItemQEnt_ar{$RowSel_L}
		OBJECT SET ENTERABLE:C238(ITMLB_ItemQ_ar; False:C215)
		[DCM_Contracts:136]ActualSpent:18:=[DCM_Contracts:136]ActualSpent:18  //modify cotract record
		DCM_ContrBidItems("CALCSUM")
		
	: (Form event code:C388=On Losing Focus:K2:8)
		OBJECT SET ENTERABLE:C238(ITMLB_ItemQ_ar; False:C215)
End case 