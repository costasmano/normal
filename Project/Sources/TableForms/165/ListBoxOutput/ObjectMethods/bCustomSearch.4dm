If (False:C215)
	//[LSS_Inventory];"ListBoxOutput".bCustomSearch
	// Modified by: Costas Manousakis-(Designer)-(5/7/20 10:05:29)
	Mods_2020_05
	//  `made button use alternative click instead of always showing popup menu
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		LSS_CustomSearch
		USE NAMED SELECTION:C332("InventorySet")
		WIN_SetWindowTitle(->[LSS_Inventory:165])
		
	: (Form event code:C388=On Alternative Click:K2:36)
		ARRAY TEXT:C222($MenuDiscriptor_atxt; 0)
		ARRAY TEXT:C222($MenuSelected_atxt; 0)
		APPEND TO ARRAY:C911($MenuSelected_atxt; "1")
		APPEND TO ARRAY:C911($MenuDiscriptor_atxt; "Search Inventory")
		APPEND TO ARRAY:C911($MenuSelected_atxt; "2")
		APPEND TO ARRAY:C911($MenuDiscriptor_atxt; "Search Inventory by Element Deficiency")
		C_TEXT:C284($menuref_txt; $selected_txt)
		$menuref_txt:=MENU_BuildMenuFromArrays(->$MenuDiscriptor_atxt; ->$MenuSelected_atxt; "\\")
		
		$selected_txt:=Dynamic pop up menu:C1006($menuref_txt)
		RELEASE MENU:C978($menuref_txt)
		Case of 
			: ($selected_txt="1")
				LSS_CustomSearch
				USE NAMED SELECTION:C332("InventorySet")
				WIN_SetWindowTitle(->[LSS_Inventory:165])
				
				
			: ($selected_txt="2")
				CREATE SET:C116([LSS_Inventory:165]; "InventoryStartSet")
				
				LSS_ControlDeficiencyQuery
				If (ok=1)
					LSS_Districts_as:=0
					LSS_Categories_as:=0
					LSS_StructType_atxt:=0
					LSS_Districts_as{0}:=""
					LSS_Categories_as{0}:=""
					LSS_StructType_atxt{0}:=""
					
					REDRAW:C174(LSS_Districts_as)
					
					REDRAW:C174(LSS_Categories_as)
					REDRAW:C174(LSS_StructType_atxt)
					
				End if 
				USE NAMED SELECTION:C332("InventorySet")
				C_TEXT:C284($MethodCalledOnError_txt)
				$MethodCalledOnError_txt:=Method called on error:C704
				ON ERR CALL:C155("MissingSetError")
				CLEAR SET:C117("TotalElmtsFound")
				CLEAR SET:C117("InterimSet")
				CLEAR SET:C117("FinalElementSet")
				CLEAR SET:C117("LSSInspectionSet")
				CLEAR SET:C117("LSS_Inventory")
				CLEAR SET:C117("LSS_InventorySet")
				CLEAR SET:C117("RemoveMeSet")
				
				CLEAR SET:C117("InventoryStartSet")
				
				ON ERR CALL:C155($MethodCalledOnError_txt)
				WIN_SetWindowTitle(->[LSS_Inventory:165])
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
		End case 
		
End case 
