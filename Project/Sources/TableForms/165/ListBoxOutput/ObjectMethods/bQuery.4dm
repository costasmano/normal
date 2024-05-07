
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
	// Modified by: Costas Manousakis-(Designer)-(2024-03-28 13:08:42)
	Mods_2024_04
	//  `added option to select random number of records from current list
	//  `changed button to "with popup menu separated" ; enabled on Alternate click and on long click 
	//  `don't use the Shift - modifier when clicking
	//  `from popup menu removed option to find structures with no match - only useful when there were two servers
End if 

C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
C_BOOLEAN:C305($SpecialQuery_B; $searchDone_b)
$SpecialQuery_B:=False:C215
$searchDone_b:=False:C215
Case of 
	: ($FormEvent_L=On Clicked:K2:4)
		C_BOOLEAN:C305($one_b; $many_b)
		GET AUTOMATIC RELATIONS:C899($one_b; $many_b)
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		QUERY:C277(Current form table:C627->)
		SET AUTOMATIC RELATIONS:C310($one_b; $many_b)
		$searchDone_b:=(Ok=1)
		
	: ($FormEvent_L=On Alternative Click:K2:36) | ($FormEvent_L=On Long Click:K2:37)
		$SpecialQuery_B:=True:C214
		C_TEXT:C284($QueryBy_txt)
		$QueryBy_txt:=" "+Char:C90(1)
		$QueryBy_txt:=$QueryBy_txt+"Find Duplicates"+Char:C90(1)
		$QueryBy_txt:=$QueryBy_txt+"Find ALL Invalid Structure names"+Char:C90(1)
		$QueryBy_txt:=$QueryBy_txt+"Find Invalid Structure names with inspections"+Char:C90(1)
		$QueryBy_txt:=$QueryBy_txt+"Find Invalid Structure names with no inspections"+Char:C90(1)
		//$QueryBy_txt:=$QueryBy_txt+"Find Structures With No Match"+Char(1)
		$QueryBy_txt:=$QueryBy_txt+"Find Structures from Clipboard"+Char:C90(1)
		$QueryBy_txt:=$QueryBy_txt+"Get a random selection from the list"+Char:C90(1)
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
				//: ($Selection_L=6)
				//Compiler_clone 
				//Compiler_forSQL 
				//C_TEXT($IPAddress_txt)
				
				//$IPAddress_txt:=SQL_TestConnection 
				//If ($IPAddress_txt#"")
				//ut_SQLConnect ("Designer";"caesar";$IPAddress_txt)
				//ARRAY TEXT($RemoteInspectionIDs_atxt;0)
				//C_TEXT($Match_txt)
				//$Match_txt:="IMPORT%"
				//Compiler_FieldVariables (Table(->[LSS_Inventory]))
				
				//Begin SQL
				//select
				//[LSS_Inventory].[LSS_InventoryId_s]
				//from
				//[LSS_Inventory]
				//where
				//[LSS_Inventory].[LSS_InventoryId_s] like :$Match_txt
				//into :v_165_001_atxt;
				
				
				//End SQL
				
				//ut_SQLLogout 
				//ALL RECORDS([LSS_Inventory])
				//CREATE SET([LSS_Inventory];"LocalSet")
				//SET QUERY DESTINATION(Into set;"RemoteMatches")
				//QUERY WITH ARRAY([LSS_Inventory]LSS_InventoryId_s;v_165_001_atxt)
				//DIFFERENCE("LocalSet";"RemoteMatches";"LocalSet")
				//USE SET("LocalSet")
				//SET WINDOW TITLE("Displaying "+String(Records in set("LocalSet"))+" out of "+String(Records in table([LSS_Inventory]))+" records")
				//SET QUERY DESTINATION(Into current selection)
				
				//CLEAR SET("LocalSet")
				//CLEAR SET("RemoteMatches")
				//End if 
			: ($Selection_L=6)
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
				
				//start of changes Mods_2024_LSS_1
			: ($Selection_L=7)
				C_LONGINT:C283($num)
				C_TEXT:C284($num_txt)
				$num_txt:=Request:C163("# of random records to select between 1-"+String:C10(Records in selection:C76([LSS_Inventory:165]))+" (can use % e.g. 50%)")
				$num:=Num:C11($num_txt)
				If (Position:C15("%"; $num_txt)>0)
					$num:=($num*Records in selection:C76([LSS_Inventory:165]))/100
				End if 
				If ($num>0) & ($num<Records in selection:C76([LSS_Inventory:165]))
					CreateRandomSelection(->[LSS_Inventory:165]; $num)
				Else 
					ALERT:C41("Entered number "+String:C10($num)+" must be greater than 0 and less than "+String:C10(Records in selection:C76([LSS_Inventory:165])))
				End if 
				//end of changes Mods_2024_LSS_1
				
		End case 
		
		C_LONGINT:C283($Count_L)
		
		If ($Selection_L>1)
			SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
			ARRAY TEXT:C222($InventoryKeys_atxt; 0)
			SELECTION TO ARRAY:C260([LSS_Inventory:165]LSS_InventoryId_s:1; $InventoryKeys_atxt)
			QUERY WITH ARRAY:C644([LSS_Inspection:164]LSS_InventoryId_s:2; $InventoryKeys_atxt)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			$SpecialQuery_B:=($Count_L=0)
			$searchDone_b:=True:C214
		End if 
		
End case 


OBJECT SET VISIBLE:C603(*; "bDelete@"; (Current user:C182="Designer") & ($SpecialQuery_B))
If ($searchDone_b)
	//clear filter dropdowns
	LSS_ResetListFilters
	
	LSS_SortInventory
	COPY NAMED SELECTION:C331([LSS_Inventory:165]; "InventorySet")
	WIN_SetWindowTitle(->[LSS_Inventory:165])
End if 

//End Object Method: [LSS_Inventory].ListBoxOutput.bQuery