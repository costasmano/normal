//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/08/09, 13:37:30
	// ----------------------------------------------------
	// Method: ITMLB_ItemQEnt_ar_OM
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
End if 
Case of 
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($myRow)
		C_BOOLEAN:C305(DCM_ItemQEntered_b)
		DCM_ItemQEntered_b:=False:C215
		$myRow:=ITMLB_ItemQEnt_ar
		If (ITMLB_ItemQ_ar{$myRow}>0)
			ITMLB_ItemQEnt_ar{$myRow}:=ITMLB_ItemQ_ar{$myRow}
		Else 
			DCM_ItemQEntered_b:=True:C214
			DCM_ContrBidItems("CALCSUM")
		End if 
		
End case 