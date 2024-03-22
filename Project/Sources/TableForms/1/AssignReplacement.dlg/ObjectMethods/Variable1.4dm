// ----------------------------------------------------
// Object Method: PRJ_UnassignedBins_atxt
// User name (OS): cjmiller
// Date and time: 05/20/08, 14:51:06
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_v55  //Copied to Server on : 06/25/08, 11:58:20   `r008 `05/20/08, 14:51:07     
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/17/17 13:40:53)
End if 
Case of 
	: (NewBin_s#"")
		ALERT:C41("You may not make a selection until New bin has been assigned to a group")
	: (Form event code:C388=On Clicked:K2:4)
		OBJECT SET VISIBLE:C603(*; "MovetoExisting@"; False:C215)
		Case of 
			: (PRJ_UnassignedBins_atxt<1)
			: (PRJ_UnassignedBinGroup_al{PRJ_UnassignedBins_atxt}#0)
				ALERT:C41("You may not move a previously assigned BIN")
			Else 
				OBJECT SET VISIBLE:C603(*; "MovetoExisting@"; True:C214)
		End case 
	: (Form event code:C388=On Double Clicked:K2:5)
		
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			OBJECT SET VISIBLE:C603(*; "MovetoExisting@"; False:C215)
			Case of 
				: (PRJ_UnassignedBins_atxt<1)
				: (PRJ_UnassignedBinGroup_al{PRJ_UnassignedBins_atxt}#0)
					ALERT:C41("You may not move a previously assigned BIN")
				Else 
					PRJ_MoveSelectedArray(->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_UnassignedBinGroup_al; ->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al; ->PRJ_ExstSelectedBinGroup_al)
					
			End case 
			InDoubleClick_B:=False:C215
		End if 
		
		
	: (Form event code:C388=On Drop:K2:12)
		If (Substring:C12(PRJ_ExistSelectedBins_atxt{PRJ_ExistSelectedBins_atxt}; 1; 5)="Unass")
			PRJ_MoveSelectedArray(->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al; ->PRJ_ExstSelectedBinGroup_al; ->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_UnassignedBinGroup_al)
		Else 
			ALERT:C41("You may not unassign previously assgned BINs")
		End if 
End case 
//End Object Method: PRJ_UnassignedBins_atxt