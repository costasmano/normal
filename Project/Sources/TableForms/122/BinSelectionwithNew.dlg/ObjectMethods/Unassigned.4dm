Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		PRJ_MoveSelectedArray(->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_UnassignedBinGroup_al; ->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al; ->PRJ_ExstSelectedBinGroup_al)
		OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Assign@"; False:C215)
		
		If (Size of array:C274(PRJ_AvailableBins_atxt)=0)
			OBJECT SET VISIBLE:C603(*; "MoveAllToUnassigned2@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "MoveAllToUnassigned2@"; True:C214)
		End if 
		If (Size of array:C274(PRJ_UnassignedBins_atxt)=0)
			
			OBJECT SET VISIBLE:C603(*; "MoveAllToSelected1@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "MoveAllToSelected1@"; True:C214)
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Assign@"; False:C215)
		
		If (PRJ_UnassignedBins_atxt<1)
			OBJECT SET VISIBLE:C603(*; "MovetoAvailable1@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "AssigntoGroup1@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "MovetoAvailable1@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "AssigntoGroup1@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "MoveAllToSelected1@"; True:C214)
		End if 
End case 
