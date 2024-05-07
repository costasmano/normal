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
	// Modified by: Costas Manousakis-(Designer)-(2024-04-11 13:30:39)
	Mods_2024_04
	//  `use structure arrays to find dups ; added progress indicator
End if 

ARRAY TEXT:C222($DUPS_ATXT; 0)
C_LONGINT:C283($COUNT_L; $Loop_L)

If (False:C215)
	ARRAY TEXT:C222($structures_atxt; 0)
	
	Begin SQL
		select distinct([LSS_Inventory].[LSS_StructureNumber_s])
		from [LSS_Inventory]
		into :$structures_atxt;
		
	End SQL
	SET QUERY DESTINATION:C396(Into variable:K19:4; $COUNT_L)
	
	For ($Loop_l; 1; Size of array:C274($structures_atxt))
		QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureNumber_s:6=$structures_atxt{$Loop_L})
		
		If ($COUNT_L>1)
			APPEND TO ARRAY:C911($DUPS_ATXT; $structures_atxt{$Loop_L})
		End if 
		
		
	End for 
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
Else 
	
	ARRAY TEXT:C222($allStructures_atxt; 0)
	ALL RECORDS:C47([LSS_Inventory:165])
	SELECTION TO ARRAY:C260([LSS_Inventory:165]LSS_StructureNumber_s:6; $allStructures_atxt)
	SORT ARRAY:C229($allStructures_atxt; >)
	C_LONGINT:C283($loop_L; $progress_L)
	$progress_L:=Progress New
	Progress SET TITLE($progress_L; "Searching for duplicate structure numbers")
	Progress SET PROGRESS($progress_L; -1)
	For ($loop_L; 2; Size of array:C274($allStructures_atxt))
		
		If ($allStructures_atxt{$loop_L}=$allStructures_atxt{$loop_L-1})
			APPEND TO ARRAY:C911($DUPS_ATXT; $allStructures_atxt{$Loop_L})
			
		End if 
	End for 
	
	Progress QUIT($progress_L)
	
End if 

QUERY WITH ARRAY:C644([LSS_Inventory:165]LSS_StructureNumber_s:6; $DUPS_ATXT)
ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureNumber_s:6; >)

//LSS_SortFunction 
//End LSS_SortDupsOnly