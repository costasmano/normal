// ----------------------------------------------------
// Form Method: BinSelection.dlg
// User name (OS): cjmiller
// Date and time: 04/15/08, 11:29:05
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_v55  //r004 `04/15/08, 11:29:08     
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		PRJ_NewSelected_txt:=""
		PRJ_ExistSelected_txt:=""
		C_LONGINT:C283($Loop_l; $Count_l)
		USE SET:C118("IncludedBinSet")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		ARRAY TEXT:C222(GroupDD_as; 0)  //Command Replaced was o_ARRAY string length was 25
		
		OBJECT SET VISIBLE:C603(*; "BinDD@"; True:C214)
		
		DISTINCT VALUES:C339([PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6; $Groups_al)
		ARRAY TEXT:C222(GroupDD_as; Size of array:C274($Groups_al))  //Command Replaced was o_ARRAY string length was 25
		For ($Loop_l; 1; Size of array:C274($Groups_al))
			GroupDD_as{$Loop_l}:="Replacement Group # "+String:C10($Groups_al{$Loop_l})
		End for 
		GroupDD_as:=1
		If (Size of array:C274(GroupDD_as)=0)
			ARRAY TEXT:C222(GroupDD_as; 1)  //Command Replaced was o_ARRAY string length was 25
			GroupDD_as{1}:="Replacement Group #1"
			GroupDD_as:=1
		End if 
		
		
		OBJECT SET VISIBLE:C603(*; "MovetoUnnassigned1@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "MovetoAvailable1@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "AssigntoGroup1@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "MovetoUnassigned1@"; False:C215)
		
		If (Size of array:C274(PRJ_AvailableBins_atxt)=0)
			OBJECT SET VISIBLE:C603(*; "MoveAllToUnassigned1@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "MoveAllToUnassigned1@"; True:C214)
		End if 
		
		If (Size of array:C274(PRJ_UnassignedBins_atxt)=0)
			OBJECT SET VISIBLE:C603(*; "MoveAllToSelected1@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "MoveAllToSelected1@"; True:C214)
		End if 
		SORT ARRAY:C229(PRJ_AvailableBins_atxt; PRJ_AvailableBinRecordNos_al; PRJ_AvailableBinGroup_al; >)
		SORT ARRAY:C229(PRJ_UnassignedBins_atxt; PRJ_UnassignedBinRecordNos_al; PRJ_UnassignedBinGroup_al; >)
		
		SORT ARRAY:C229(PRJ_NewSelectedBins_atxt; >)
		SORT ARRAY:C229(PRJ_ExistSelectedBins_atxt; PRJ_ExstSelectedBinRecordNos_al; PRJ_ExstSelectedBinGroup_al; >)
		
	: (Form event code:C388=On Unload:K2:2)
		CLEAR SET:C117("NewBinSet")
		CLEAR SET:C117("OldBinSet")
		CLEAR SET:C117("IncludedBinSet")
End case 
//End Form Method: BinSelection.dlg