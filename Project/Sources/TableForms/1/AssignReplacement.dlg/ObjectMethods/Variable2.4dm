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
	Mods_2008_v55  //r005 `04/28/08, 11:30:16     
	Mods_2008_v55  //r006 `05/06/08, 11:13:13     `Make sure if no new bins drop down not visible and data handled correctly
	//Copied to Server on : 06/25/08, 12:04:22
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/17/17 13:40:53)
End if 

C_BOOLEAN:C305($Proceed_b)
$Proceed_b:=False:C215
If (Position:C15("Replace"; GroupDD_as{GroupDD_as})>0)
	$Proceed_b:=True:C214
End if 

Case of 
	: (Form event code:C388=On Drop:K2:12)
		If ($Proceed_b)
			ALERT:C41("No Action can be taken unless a group is selected!")
		Else 
			OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
			Case of 
				: (PRJ_UnassignedBins_atxt<1)
				: (PRJ_UnassignedBinGroup_al{PRJ_UnassignedBins_atxt}#0)
					ALERT:C41("You may not move a previously assigned BIN")
				Else 
					PRJ_MoveSelectedArray(->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_UnassignedBinGroup_al; ->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al; ->PRJ_ExstSelectedBinGroup_al)
			End case 
			
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			If ($Proceed_b)
				ALERT:C41("No action may be taken until a group is selected")
			Else 
				If (Substring:C12(PRJ_ExistSelectedBins_atxt{PRJ_ExistSelectedBins_atxt}; 1; 5)="Unass")
					PRJ_MoveSelectedArray(->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al; ->PRJ_ExstSelectedBinGroup_al; ->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_UnassignedBinGroup_al)
					OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
				Else 
					ALERT:C41("You may not move a previously assigned BIN")
				End if 
			End if 
			InDoubleClick_B:=False:C215
		End if 
		
		
	: (Not:C34($Proceed_b))
		
	: (Form event code:C388=On Clicked:K2:4)
		If (PRJ_ExistSelectedBins_atxt<1)
			OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		Else 
			If (Substring:C12(PRJ_ExistSelectedBins_atxt{PRJ_ExistSelectedBins_atxt}; 1; 5)="Unass")
				OBJECT SET VISIBLE:C603(*; "MovetoExisting@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "MovetoAssigned@"; True:C214)
			End if 
		End if 
		
End case 
//End Object Method: aIt8OwnerDesIncluded