// ----------------------------------------------------
// User name (OS): MillerC
// Date and time: 06/20/07, 10:34:52
// ----------------------------------------------------
// Method: Form Method: BinSelection.dlg
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v5310  //06/20/07 Fix so that if nothing selected, no errors
	Mods_2007_CJM_v5303
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		If (Size of array:C274(PRJ_AvailableBins_atxt)=0)
			OBJECT SET VISIBLE:C603(*; "Include@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "Include@"; True:C214)
		End if 
		
End case 