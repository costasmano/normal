//----------------------------------------------------
//User name (OS): administrator
//Date and time: 07/07/15, 13:09:50
//----------------------------------------------------
//Object Method: [LSS_Inspection].InspectionReview.bQuery
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(11/29/18 14:47:28)
	Mods_2018_11
	//  `hide the review and print buttons
	// Modified by: manousakisc-(Designer)-(4/11/2024 19:48:32)
	Mods_2024_04
	//  `added on alt click and on long click events to button. added option with pop-up menu separated
	//  ` menu to search by structure numbers in clipboard.
	
End if 

C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388

C_BOOLEAN:C305($SpecialQuery_B)
Case of 
	: ($FormEvent_L=On Load:K2:1)
		
	: ($FormEvent_L=On Data Change:K2:15)
		
	: ($FormEvent_L=On Clicked:K2:4)
		
		QUERY SELECTION:C341(Current form table:C627->)
		
		If (OK=1)
			Header1:=0
			Header2:=0
			Header3:=0
			Header4:=0
			Header5:=0
			Header6:=0
			Header7:=0
			
			//hide the review and print buttons
			OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; False:C215)
			OBJECT SET VISIBLE:C603(*; "LSS_Print_L"; False:C215)
			
			LSS_SortInspReview
			WIN_SetWindowTitle(Current form table:C627)
		End if 
		
		
	: ($FormEvent_L=On Alternative Click:K2:36) | ($FormEvent_L=On Long Click:K2:37)
		$SpecialQuery_B:=True:C214
		C_TEXT:C284($QueryBy_txt)
		$QueryBy_txt:=Char:C90(1)+" "
		$QueryBy_txt:=$QueryBy_txt+Char:C90(1)+"Inspections for Structure numbers from Clipboard"
		C_LONGINT:C283($Selection_L)
		
		$Selection_L:=Pop up menu:C542($QueryBy_txt)
		
		Case of 
			: ($Selection_L=2)
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
				ARRAY TEXT:C222($inventoryIDs_atxt; 0)
				SELECTION TO ARRAY:C260([LSS_Inventory:165]LSS_InventoryId_s:1; $inventoryIDs_atxt)
				
				If (Size of array:C274($inventoryIDs_atxt)=0)
					ALERT:C41("No Structure numbers were found in the clipboard!")
				Else 
					QUERY SELECTION WITH ARRAY:C1050([LSS_Inspection:164]LSS_InventoryId_s:2; $inventoryIDs_atxt)
					
					Header1:=0
					Header2:=0
					Header3:=0
					Header4:=0
					Header5:=0
					Header6:=0
					Header7:=0
					
					//hide the review and print buttons
					OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; False:C215)
					OBJECT SET VISIBLE:C603(*; "LSS_Print_L"; False:C215)
					
					LSS_SortInspReview
					WIN_SetWindowTitle(Current form table:C627)
				End if 
				
		End case 
		
End case 

//End Object Method: [LSS_Inventory].ListBoxOutput.bQuery