//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/12/15, 16:26:48
//----------------------------------------------------
//Method: LSS_SortDupsOnly
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (5/12/15 16:26:49)
	
End if 
ARRAY TEXT:C222($structures_atxt; 0)

Begin SQL
	select distinct([LSS_Inventory].[LSS_StructureNumber_s])
	from [LSS_Inventory]
	into :$structures_atxt;
	
End SQL
ARRAY TEXT:C222($DUPS_ATXT; 0)
C_LONGINT:C283($COUNT_L; $Loop_L)

SET QUERY DESTINATION:C396(Into variable:K19:4; $COUNT_L)

For ($Loop_l; 1; Size of array:C274($structures_atxt))
	QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureNumber_s:6=$structures_atxt{$Loop_L})
	
	If ($COUNT_L>1)
		APPEND TO ARRAY:C911($DUPS_ATXT; $structures_atxt{$Loop_L})
	End if 
	
	
	
	
End for 

SET QUERY DESTINATION:C396(Into current selection:K19:1)
QUERY WITH ARRAY:C644([LSS_Inventory:165]LSS_StructureNumber_s:6; $DUPS_ATXT)
ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureNumber_s:6; >)

//LSS_SortFunction 
//End LSS_SortDupsOnly

