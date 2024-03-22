// ----------------------------------------------------
// Form Method: BinSelectionNoNew.dlg
// User name (OS): cjmiller
// Date and time: 05/27/08, 12:00:41
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_CJM_v55  //r009 `05/27/08, 12:00:42     
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*; "MovetoAssigned1@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "MovetoAvailable1@"; False:C215)
		
		If (Size of array:C274(PRJ_UnassignedBins_atxt)>0)
			OBJECT SET VISIBLE:C603(*; "MovetoAvailable1@"; True:C214)
			
		End if 
		If (Size of array:C274(PRJ_AvailableBins_atxt)>0)
			OBJECT SET VISIBLE:C603(*; "MovetoAssigned1@"; True:C214)
			
		End if 
		
		
End case 
//End Form Method: BinSelectionNoNew.dlg