If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 9/13/10, 11:10:25
	// ----------------------------------------------------
	//  Object Method: [DCM_Project];"DistrWorkOrderInput".DCM_P_ITMLB_ItemQEnt_ar
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(12/13/10 10:00:22)
	Mods_2010_12
	//  `show record modified change
End if 

Case of 
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($myRow)
		$myRow:=DCM_P_ITMLB_ItemQOEST_ar
		If (ITMLB_ItemQ_ar{$myRow}>0)
			//DCM_P_ITMLB_ItemQEnt_ar{$myRow}:=ITMLB_ItemQ_ar{$myRow}
		Else 
			
		End if 
		C_LONGINT:C283($loop_L)
		DCM_P_OEstItemSum_r:=0
		For ($loop_L; 1; Size of array:C274(ITMLB_ItemPrice_ar))
			DCM_P_OEstItemSum_r:=DCM_P_OEstItemSum_r+(ITMLB_ItemPrice_ar{$loop_L}*DCM_P_ITMLB_ItemQOEST_ar{$loop_L})
		End for 
		[DCM_Project:138]CurrCost:12:=[DCM_Project:138]CurrCost:12  //show record modified change
		
End case 