
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 07/07/15, 13:09:50
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory];"ListBoxOutput".bQuery
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_07_bug  //`Fix bug where LSS arrays being cleared
	Mods_2016_02_bug  // Add delete button to inventory list box when designer is logged in and special queries done
	//Modified by: administrator (2/29/16 10:27:48)
	// Modified by: Costas Manousakis-(Designer)-(4/30/18 16:03:55)
	Mods_2018_04
	//  `set auto relations to true ; true before doing a query table
	Mods_2019_06  //Add query from pasteboard for [LSS_Inventory]LSS_StructureNumber_s
	//Modified by: Chuck Miller (6/6/19 17:30:53)
	
	// Modified by: manousakisc (5/10/2023)
	Mods_2023_LSSNew
	
	// Modified by: Costas Manousakis-(Designer)-(2023-07-03 18:10:14)
	Mods_2023_07
	//  `use Get text from Pasteboard when searching from pasteboard.
End if 
C_BOOLEAN:C305($SpecialQuery_B)
$SpecialQuery_B:=False:C215
If (Shift down:C543)
	$SpecialQuery_B:=True:C214
	C_TEXT:C284($QueryBy_txt)
	$QueryBy_txt:=" "+Char:C90(1)
	$QueryBy_txt:=$QueryBy_txt+"Find Duplicates"+Char:C90(1)
	$QueryBy_txt:=$QueryBy_txt+"Find ALL  Invalid Structure names"+Char:C90(1)
	$QueryBy_txt:=$QueryBy_txt+"Find Invalid Structure names with inspections"+Char:C90(1)
	$QueryBy_txt:=$QueryBy_txt+"Find Invalid Structure names with no inspections"+Char:C90(1)
	$QueryBy_txt:=$QueryBy_txt+"Find Structures With No Match"+Char:C90(1)
	$QueryBy_txt:=$QueryBy_txt+"Find Structures from Clipboard"+Char:C90(1)
	C_LONGINT:C283($Selection_L)
	
	$Selection_L:=Pop up menu:C542($QueryBy_txt)
	
	Case of 
		: ($Selection_L=2)
			LSS_SortDupsOnly
			
		: ($Selection_L=3)
			LSS_FindInvalidStructureNames
		: ($Selection_L=4)
			LSS_FindInvalidStructureNames(True:C214)
		: ($Selection_L=5)
			LSS_FindInvalidStructureNames(False:C215)
		: ($Selection_L=6)
			Compiler_clone
			Compiler_forSQL
			C_TEXT:C284($IPAddress_txt)
			
			$IPAddress_txt:=SQL_TestConnection
			If ($IPAddress_txt#"")
				ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
				ARRAY TEXT:C222($RemoteInspectionIDs_atxt; 0)
				C_TEXT:C284($Match_txt)
				$Match_txt:="IMPORT%"
				Compiler_FieldVariables(Table:C252(->[LSS_Inventory:165]))
				
				Begin SQL
					select
					[LSS_Inventory].[LSS_InventoryId_s]
					from
					[LSS_Inventory]
					where
					[LSS_Inventory].[LSS_InventoryId_s] like :$Match_txt
					into :v_165_001_atxt;
					
					
				End SQL
				
				ut_SQLLogout
				ALL RECORDS:C47([LSS_Inventory:165])
				CREATE SET:C116([LSS_Inventory:165]; "LocalSet")
				SET QUERY DESTINATION:C396(Into set:K19:2; "RemoteMatches")
				QUERY WITH ARRAY:C644([LSS_Inventory:165]LSS_InventoryId_s:1; v_165_001_atxt)
				DIFFERENCE:C122("LocalSet"; "RemoteMatches"; "LocalSet")
				USE SET:C118("LocalSet")
				SET WINDOW TITLE:C213("Displaying "+String:C10(Records in set:C195("LocalSet"))+" out of "+String:C10(Records in table:C83([LSS_Inventory:165]))+" records")
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				
				CLEAR SET:C117("LocalSet")
				CLEAR SET:C117("RemoteMatches")
			End if 
		: ($Selection_L=7)
			C_TEXT:C284($ClipTextCopy)
			$ClipTextCopy:=Get text from pasteboard:C524
			C_TEXT:C284($Delimeter_txt)
			$Delimeter_txt:=Char:C90(Carriage return:K15:38)
			Case of 
				: (Position:C15(Char:C90(9); $ClipTextCopy)>0)
					$Delimeter_txt:=Char:C90(Tab:K15:37)
				: (Position:C15(","; $ClipTextCopy)>0)
					$Delimeter_txt:=","
				: (Position:C15((Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)); $ClipTextCopy)>0)
					$Delimeter_txt:=(Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40))
				: (Position:C15(Char:C90(Line feed:K15:40); $ClipTextCopy)>0)
					$Delimeter_txt:=Char:C90(Line feed:K15:40)
					
			End case 
			ARRAY TEXT:C222($InventoryKeys_atxt; 0)
			ut_NewTextToArray($ClipTextCopy; ->$InventoryKeys_atxt; $Delimeter_txt)
			QUERY WITH ARRAY:C644([LSS_Inventory:165]LSS_StructureNumber_s:6; $InventoryKeys_atxt)
	End case 
	C_LONGINT:C283($Count_L)
	
	SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
	ARRAY TEXT:C222($InventoryKeys_atxt; 0)
	SELECTION TO ARRAY:C260([LSS_Inventory:165]LSS_InventoryId_s:1; $InventoryKeys_atxt)
	QUERY WITH ARRAY:C644([LSS_Inspection:164]LSS_InventoryId_s:2; $InventoryKeys_atxt)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	$SpecialQuery_B:=($Count_L=0)
	
Else 
	
	C_BOOLEAN:C305($one_b; $many_b)
	GET AUTOMATIC RELATIONS:C899($one_b; $many_b)
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	QUERY:C277(Current form table:C627->)
	SET AUTOMATIC RELATIONS:C310($one_b; $many_b)
	
End if 

OBJECT SET VISIBLE:C603(*; "bDelete@"; (Current user:C182="Designer") & ($SpecialQuery_B))

If (OK=1)
	//clear filter dropdowns
	LSS_ResetListFilters
	
	LSS_SortInventory
	COPY NAMED SELECTION:C331([LSS_Inventory:165]; "InventorySet")
	WIN_SetWindowTitle(->[LSS_Inventory:165])
End if 


//End Object Method: [LSS_Inventory].ListBoxOutput.bQuery

