// ----------------------------------------------------
// Object Method: PRJ_AvailableBins_atxt
// User name (OS): cjmiller
// Date and time: 03/23/06, 12:25:19
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJM_v5310  //06/20/07 Fix so that if nothing selected, no errors
	Mods_2007_CJM_v5310  //06/28/07 Fix so that if reselect nothing buttons disappear
	Mods_2008_v55  //r005 `04/28/08, 11:26:53     
	Mods_2008_v55  //r006 `05/06/08, 11:13:13     `Make sure if no new bins drop down not visible and data handled correctly
End if 

Case of 
		
	: (Form event code:C388=On Drop:K2:12)
		
		If (PRJ_UnassignedBins_atxt>0)
			PRJ_MoveSelectedArray(->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_AvailableBins_atxt; ->PRJ_AvailableBinRecordNos_al)
		End if 
		
		If (Size of array:C274(PRJ_AvailableBins_atxt)=0)
			OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "MovetoAssigned1@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "MovetoAvailable1@"; False:C215)
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		If (PRJ_AvailableBins_atxt<1)
		Else 
			PRJ_MoveSelectedArray(->PRJ_AvailableBins_atxt; ->PRJ_AvailableBinRecordNos_al; ->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al)
		End if 
		
		If (Size of array:C274(PRJ_AvailableBins_atxt)=0)
			OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "MovetoAssigned1@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "MovetoAvailable1@"; False:C215)
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		If (PRJ_AvailableBins_atxt<1)
			OBJECT SET VISIBLE:C603(*; "MovetoAssigned1@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "MovetoAssigned1@"; True:C214)
		End if 
End case 

//End Object Method: PRJ_AvailableBins_atxt