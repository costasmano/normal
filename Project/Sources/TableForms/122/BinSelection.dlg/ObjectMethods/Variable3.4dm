// ----------------------------------------------------
// Object Method: aIt8OwnerDesIncluded
// User name (OS): cjmiller
// Date and time: 04/19/05, 13:55:14
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM03
	Mods_2007_CJM_v5310  //06/20/07 Fix so that if nothing selected, no errors
	Mods_2007_CJM_v5310  //06/28/07 Fix so that if reselect nothing buttons disappear
End if 
Case of 
	: (Form event code:C388=On Drop:K2:12)
		If (PRJ_AvailableBins_atxt<1)
		Else 
			PRJ_MoveToSelected(->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al)
			
		End if 
	: (Form event code:C388=On Double Clicked:K2:5)
		If (PRJ_ExistSelectedBins_atxt<1)
		Else 
			PRJ_MoveToAvailable(->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al; PRJ_ExistSelectedBins_atxt)
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		
		MoveFromArea_s:="Exist"
		If (PRJ_ExistSelectedBins_atxt<1)
			OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "MoveFromExist@"; True:C214)
		End if 
		
		
End case 

//End Object Method: aIt8OwnerDesIncluded