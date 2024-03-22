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
End if 

Case of 
	: (Form event code:C388=On Drop:K2:12)
		Case of 
			: (MoveFromArea_s="Exist")
				PRJ_MoveToAvailable(->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al; PRJ_ExistSelectedBins_atxt)
			: (MoveFromArea_s="New")
				PRJ_MoveToAvailable(->PRJ_NewSelectedBins_atxt; ->PRJ_NewSelectedBinRecordNos_al; PRJ_NewSelectedBins_atxt)
				
		End case 
		OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
	: (Form event code:C388=On Double Clicked:K2:5)
		If (PRJ_AvailableBins_atxt<1)
		Else 
			CONFIRM:C162("Move to"; "Existing"; "New")
			If (OK=1)
				PRJ_MoveToSelected(->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al)
			Else 
				PRJ_MoveToSelected(->PRJ_NewSelectedBins_atxt; ->PRJ_NewSelectedBinRecordNos_al)
			End if 
			
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		If (PRJ_AvailableBins_atxt<1)
			OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "MoveToExisting@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "MoveToNew@"; True:C214)
		End if 
End case 
//End Object Method: PRJ_AvailableBins_atxt