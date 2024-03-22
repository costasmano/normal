//Method: [LSS_Inventory].ListBoxOutput.bReport
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/10/18, 12:59:52
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
	//Added ability to printed inspection reports from selected inventory items
	// Modified by: Costas Manousakis-(Designer)-(6/19/20 19:15:30)
	Mods_2020_06
	//  `Alert if there are no inventory records selected
	//  `Verify printing for multiple records
	//  `Keep the order of printing the same as in the list.
	// Modified by: Costas Manousakis-(Designer)-(2022-06-08 18:45:00)
	Mods_2022_06
	//  // enabled long click and alternate click in events
	//  // code to enable sending a quick report to excel
	//  // added help tip "Quick Report editor; click on arrow for more options."
	// Modified by: Costas Manousakis-(Designer)-(2023-11-06 17:09:50)
	Mods_2023_11
	//  `added option to build GeoJSON file from current list
End if 
//
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		QR REPORT:C197(Current form table:C627->; Char:C90(1))
		USE NAMED SELECTION:C332("InventorySet")
		
	: (Form event code:C388=On Alternative Click:K2:36) | (Form event code:C388=On Long Click:K2:37)
		
		ARRAY TEXT:C222($MenuDiscriptor_atxt; 0)
		ARRAY TEXT:C222($MenuSelected_atxt; 0)
		APPEND TO ARRAY:C911($MenuDiscriptor_atxt; "Quick Report Editor")
		APPEND TO ARRAY:C911($MenuSelected_atxt; "1")
		APPEND TO ARRAY:C911($MenuDiscriptor_atxt; "Built Reports")
		APPEND TO ARRAY:C911($MenuSelected_atxt; "2")
		APPEND TO ARRAY:C911($MenuDiscriptor_atxt; "Generate a Quick Report to Excel")
		APPEND TO ARRAY:C911($MenuSelected_atxt; "6")
		//start of Mods_2023_11
		APPEND TO ARRAY:C911($MenuDiscriptor_atxt; "Generate a GeoJSON file to use in MassDOT GIS Web app")
		APPEND TO ARRAY:C911($MenuSelected_atxt; "7")
		//end of Mods_2023_11
		APPEND TO ARRAY:C911($MenuDiscriptor_atxt; "Print Inspections\\for Newest Complete Inspection")
		APPEND TO ARRAY:C911($MenuSelected_atxt; "3")
		APPEND TO ARRAY:C911($MenuDiscriptor_atxt; "Print Inspections\\for Newest Approved Inspection")
		APPEND TO ARRAY:C911($MenuSelected_atxt; "4")
		APPEND TO ARRAY:C911($MenuDiscriptor_atxt; "Print Inspections\\for Newest Inspection")
		APPEND TO ARRAY:C911($MenuSelected_atxt; "5")
		C_TEXT:C284($menuref_txt; $selected_txt)
		$menuref_txt:=MENU_BuildMenuFromArrays(->$MenuDiscriptor_atxt; ->$MenuSelected_atxt; "\\")
		
		$selected_txt:=Dynamic pop up menu:C1006($menuref_txt)
		RELEASE MENU:C978($menuref_txt)
		//Newest Complete;Select Newest Approved;Select Newest Newest"
		
		
		Case of 
			: ($selected_txt="1")
				
				QR REPORT:C197(Current form table:C627->; Char:C90(1))
				USE NAMED SELECTION:C332("InventorySet")
			: ($selected_txt="2")
				
				LSS_LoadReportTemplates
				USE NAMED SELECTION:C332("InventorySet")
				
			: ($selected_txt="3") | ($selected_txt="4") | ($selected_txt="5")
				If (Records in set:C195("InventorySet")>0)
					
					CONFIRM:C162("Print inspection reports for "+String:C10(Records in set:C195("InventorySet"))+" structures?"; "Continue"; "Cancel")
					
					If (OK=1)
						C_TEXT:C284(v_165_006_txt)  //Structure number arrays
						v_165_006_txt:=""
						
						ARRAY LONGINT:C221($RecordNumbers_al; 0)
						ARRAY LONGINT:C221($SelectedRecordNumbers_al; 0)
						ARRAY LONGINT:C221($Selectedsort_al; 0)
						ARRAY LONGINT:C221($InspectionRecordNo_aL; 0)
						C_LONGINT:C283($loop_l; $InvRecords_L)
						
						SELECTION TO ARRAY:C260([LSS_Inventory:165]; $RecordNumbers_al)
						USE SET:C118("InventorySet")
						SELECTION TO ARRAY:C260([LSS_Inventory:165]; $SelectedRecordNumbers_al)
						ARRAY LONGINT:C221($Selectedsort_al; Size of array:C274($SelectedRecordNumbers_al))
						
						C_LONGINT:C283($loop_L)
						For ($loop_L; 1; Size of array:C274($SelectedRecordNumbers_al))
							$Selectedsort_al{$loop_L}:=Find in array:C230($RecordNumbers_al; $SelectedRecordNumbers_al{$loop_l})
						End for 
						
						SORT ARRAY:C229($Selectedsort_al; $SelectedRecordNumbers_al; >)
						
						CREATE SELECTION FROM ARRAY:C640([LSS_Inventory:165]; $SelectedRecordNumbers_al)
						$InvRecords_L:=Records in selection:C76([LSS_Inventory:165])
						For ($loop_l; 1; $InvRecords_L)
							GOTO SELECTED RECORD:C245([LSS_Inventory:165]; $loop_l)
							QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InventoryId_s:2=[LSS_Inventory:165]LSS_InventoryId_s:1)
							Case of 
								: ($selected_txt="3")  //Complete
									QUERY SELECTION:C341([LSS_Inspection:164]; [LSS_Inspection:164]LSS_Complete_b:39=True:C214)
									
								: ($selected_txt="4")  //Approved
									QUERY SELECTION:C341([LSS_Inspection:164]; [LSS_Inspection:164]LSS_Approved_L:43=BMS Approved)
							End case 
							
							ORDER BY:C49([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionDate_d:4; <)
							If (Records in selection:C76([LSS_Inspection:164])>0)
								APPEND TO ARRAY:C911($InspectionRecordNo_aL; Record number:C243([LSS_Inspection:164]))
							Else 
								If (v_165_006_txt="")
									v_165_006_txt:=v_165_006_txt+[LSS_Inventory:165]LSS_StructureNumber_s:6
								Else 
									v_165_006_txt:=v_165_006_txt+", "+[LSS_Inventory:165]LSS_StructureNumber_s:6
								End if 
							End if 
							
						End for 
						CREATE SELECTION FROM ARRAY:C640([LSS_Inspection:164]; $InspectionRecordNo_aL)
						CREATE SET:C116([LSS_Inspection:164]; "InspReviewSelect")
						If (Records in selection:C76([LSS_Inspection:164])>0)
							LSS_PrintMultipleInspections
						End if 
						CLEAR SET:C117("InspReviewSelect")
						ARRAY LONGINT:C221($RecordNumbers_al; 0)
						ARRAY LONGINT:C221($InspectionRecordNo_aL; 0)
						If (v_165_006_txt#"")
							ut_BigAlert(v_165_006_txt; "Structures with NO inspections that met criteria")
						Else 
							//ALERT("Inspections printed for all selected Structures")
						End if 
						CREATE SELECTION FROM ARRAY:C640([LSS_Inventory:165]; $RecordNumbers_al)
					End if 
					
				Else 
					ALERT:C41("You must highlight the inventory records for which you wamt the print the inspection reports!")
				End if 
				
			: ($selected_txt="6")
				QR_RunReportToExcel(Current form table:C627)
				USE NAMED SELECTION:C332("InventorySet")
				//start of Mods_2023_11
			: ($selected_txt="7")
				MAP_BuildAncGeoJSON
				//end of Mods_2023_11
				
		End case 
		
End case 
//End [LSS_Inventory].ListBoxOutput.bReport