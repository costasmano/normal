//%attributes = {"invisible":true}
//Method: LSS_FindInvalidStructureNames
//Description
//
If (False:C215)
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 05/14/15, 11:39:15
	//----------------------------------------------------
	Mods_2014_Lighting  // 
	//Modified by: administrator (5/14/15 11:39:16)
	// Modified by: Costas Manousakis-(Designer)-(2024-04-11 14:09:50)
	Mods_2024_04
	//  `use struct number array instead of looping thru records
	//  `add progress indicator
End if 

ALL RECORDS:C47([LSS_Inventory:165])
ARRAY TEXT:C222($StructCategories_atxt; 0)
Begin SQL
	select distinct([LSS_refStructureTypes].[LSS_Category_s])
	from
	[LSS_refStructureTypes]
	into
	:$StructCategories_atxt;
	
End SQL
APPEND TO ARRAY:C911($StructCategories_atxt; "IT")
ARRAY TEXT:C222($Strucnums_atxt; 0)
ARRAY LONGINT:C221($RecordNumbers_aL; 0)
//LONGINT ARRAY FROM SELECTION([LSS_Inventory];$RecordNumbers_aL)
SELECTION TO ARRAY:C260([LSS_Inventory:165]; $RecordNumbers_aL; \
[LSS_Inventory:165]LSS_StructureNumber_s:6; $Strucnums_atxt)
C_LONGINT:C283($Loop_L; $Loc1_L; $Loc2_L)
C_BOOLEAN:C305($Error_B)

C_LONGINT:C283($progress_L)
$progress_L:=Progress New
Progress SET TITLE($progress_L; "Searching for Invalid Structure numbers")
Progress SET PROGRESS($progress_L; -1)
For ($Loop_L; Size of array:C274($RecordNumbers_aL); 1; -1)
	//GOTO RECORD([LSS_Inventory];$RecordNumbers_aL{$Loop_L})
	If (Length:C16($Strucnums_atxt{$Loop_L})#24)
	Else 
		ARRAY TEXT:C222($StructureParts_atxt; 0)
		ut_NewTextToArray($Strucnums_atxt{$Loop_L}; ->$StructureParts_atxt; "-")
		$Error_B:=True:C214
		Case of 
			: (Size of array:C274($StructureParts_atxt)#5)
				
			: (Length:C16($StructureParts_atxt{3})#6)
				
			: (Length:C16($StructureParts_atxt{4})#3)
				
			: (Length:C16($StructureParts_atxt{5})#6)
				
			Else 
				$Error_B:=False:C215
				$Loc1_L:=Find in array:C230(LSS_TownBDEPT_atxt; $StructureParts_atxt{1})
				$Loc2_L:=Find in array:C230($StructCategories_atxt; $StructureParts_atxt{2})
				$Error_B:=($Loc2_L<1)
				If (Not:C34($Error_B))
					$Error_B:=($Loc1_L<1)
					If ($Loc1_L>0)
						$Error_B:=Not:C34((Num:C11(Substring:C12($StructureParts_atxt{5}; 1; 1))=Num:C11(LSS_TownDistrict_atxt{$Loc1_L})))
					End if 
				End if 
				
		End case 
		If (Not:C34($Error_B))
			DELETE FROM ARRAY:C228($RecordNumbers_aL; $Loop_L; 1)
		End if 
		
	End if 
	
End for 
//UNLOAD RECORD([LSS_Inventory])

If (Count parameters:C259=1)
	C_BOOLEAN:C305($1; $OnlyWithInspections_B)
	$OnlyWithInspections_B:=$1
	Progress SET TITLE($progress_L; "Searching for Invalid Structure numbers "+\
		Choose:C955($OnlyWithInspections_B; "with Inspections"; "with no Inspections"))
	
	For ($Loop_L; Size of array:C274($RecordNumbers_aL); 1; -1)
		GOTO RECORD:C242([LSS_Inventory:165]; $RecordNumbers_aL{$Loop_L})
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Loc2_L)
		QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InventoryId_s:2=[LSS_Inventory:165]LSS_InventoryId_s:1)
		If ($OnlyWithInspections_B)
			If ($Loc2_L=0)
				DELETE FROM ARRAY:C228($RecordNumbers_aL; $Loop_L; 1)
			End if 
		Else 
			If ($Loc2_L>0)
				DELETE FROM ARRAY:C228($RecordNumbers_aL; $Loop_L; 1)
			End if 
		End if 
	End for 
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
End if 

Progress QUIT($progress_L)
CREATE SELECTION FROM ARRAY:C640([LSS_Inventory:165]; $RecordNumbers_aL)

//End LSS_FindInvalidStructureNames