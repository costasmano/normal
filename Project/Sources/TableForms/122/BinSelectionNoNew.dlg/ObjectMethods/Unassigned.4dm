// ----------------------------------------------------
// Object Method: PRJ_UnassignedBins_atxt
// User name (OS): cjmiller
// Date and time: 05/27/08, 11:40:12
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_CJM_v55  //r009 `05/27/08, 11:40:13     
End if 
Case of 
	: (Form event code:C388=On Drop:K2:12)
		If (PRJ_AvailableBins_atxt>0)
			PRJ_MoveSelectedArray(->PRJ_AvailableBins_atxt; ->PRJ_AvailableBinRecordNos_al; ->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al)
		End if 
		OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		
	: (Form event code:C388=On Double Clicked:K2:5)
		C_TEXT:C284($Bin_s)  // Command Replaced was o_C_STRING length was 3
		$Bin_s:=Substring:C12(PRJ_UnassignedBins_atxt{PRJ_UnassignedBins_atxt}; 7; 3)
		
		If ($Bin_s=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
			ALERT:C41("You may not remove the primary BIN for the project!")
		Else 
			If (PRJ_UnassignedBins_atxt<1)
			Else 
				PRJ_MoveSelectedArray(->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_AvailableBins_atxt; ->PRJ_AvailableBinRecordNos_al)
			End if 
		End if 
		OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
	: (Form event code:C388=On Clicked:K2:4)
		If (PRJ_AvailableBins_atxt<1)
			OBJECT SET VISIBLE:C603(*; "MovetoAvailable@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "MovetoExisting@"; True:C214)
		End if 
End case 
//End Object Method: PRJ_UnassignedBins_atxt