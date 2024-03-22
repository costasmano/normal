// Method: Object Method: [LSS_Inventory];"ListBoxOuput".List Box
// Description
// 
//

// Parameters
// ----------------------------------------------------
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): Administrator
	// Date and time: 09/30/14, 16:20:19
	// ----------------------------------------------------
	
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/2/14 13:21:39)
	Mods_2015_08_bug  //Change the way display of structure type occurs
	//Modified by: administrator (9/1/15 14:37:52)
	// Modified by: CJMiller-(Designer)-(6/27/17 09:29:09)
	Mods_2017_06_bug
	//  `Keep track of doubleclick event so that multiple double-clicks do not get processed before the first double click is done through
	Mods_2018_03_bug  //Fix issue where if you delete an [LSS_Inventory] record a blank row was displayed and LSS_InventoryRow_L could be greater than records in selection
	// Modified by: Costas Manousakis-(Designer)-(12/13/18 16:12:16)
	Mods_2018_12_bug
	//  `restore the named selection "InventorySet" when returning 
	//  `from the opening of an inv record on Double click
	// Modified by: Costas Manousakis-(Designer)-(5/6/20 09:44:09)
	Mods_2020_05
	//  `make "Line" grow horiz and when exiting the input form also resize the "Line" obj same as the LB 
	// Modified by: manousakisc-(Designer)-(6/20/2023 12:44:26)
	Mods_2023_LSSNew
	//  `added columns Status, Yr Built, Proj # built
End if 
C_LONGINT:C283($LBCol_L; LSS_InventoryRow_L; $0)
$0:=0
Case of 
	: (Form event code:C388=On Header Click:K2:40)
		$0:=LSS_SortStructureType
		//WIN_SetWindowTitle (->[LSS_Inventory])
		
	: (Form event code:C388=On Display Detail:K2:22)
		//QUERY([LSS_refStructureTypes];[LSS_refStructureTypes]LSS_StructureTypeId_s=[LSS_Inventory]LSS_StructureTypeId_s)
		C_LONGINT:C283($Loc_L)
		$Loc_L:=Find in array:C230(LSS_STID_atxt; [LSS_Inventory:165]LSS_StructureTypeId_s:25)
		If ($Loc_L>0)
			v_171_003_txt:=LSS_STDescription_atxt{$Loc_L}
		Else 
			v_171_003_txt:=""
		End if 
	: (Form event code:C388=On Double Clicked:K2:5)
		
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			
			LISTBOX GET CELL POSITION:C971(*; "Inventory_LB"; $LBCol_L; LSS_InventoryRow_L)
			If (LSS_InventoryRow_L>0)
				GOTO SELECTED RECORD:C245([LSS_Inventory:165]; LSS_InventoryRow_L)
				CREATE SET:C116([LSS_Inventory:165]; "InventorySet2")
				
				C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
				GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
				OBJECT GET COORDINATES:C663(*; "Inventory_LB"; $ol; $ot; $or; $ob)
				LSS_ControlModification(->[LSS_Inventory:165]; "Input")
				InDoubleClick_B:=False:C215
				
				USE NAMED SELECTION:C332("InventorySet")
				
				If (LSS_InventoryRow_L>Records in selection:C76([LSS_Inventory:165]))
					LSS_InventoryRow_L:=Records in selection:C76([LSS_Inventory:165])
				End if 
				LISTBOX SELECT ROW:C912(*; "Inventory_LB"; LSS_InventoryRow_L)
				SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
				
				OBJECT GET COORDINATES:C663(*; "Inventory_LB"; $wl; $wt; $wr; $wb)
				
				OBJECT MOVE:C664(*; "Inventory_LB"; 0; 0; $or-$wr; $ob-$wb)
				OBJECT MOVE:C664(*; "Line"; 0; 0; $or-$wr; 0)
				
				If (In transaction:C397)  //we must have cancelled out of inventory input form
					CANCEL TRANSACTION:C241
				End if 
				
				
				REDRAW:C174(Inventory_LB)
				
				OBJECT SET SCROLL POSITION:C906(*; "Inventory_LB"; LSS_InventoryRow_L)
				ut_SetReadWrite("read"; ->[LSS_Inventory:165])
				//REDRAW([LSS_Inventory]LSS_StructureLocation_txt)
				//REDRAW([LSS_Inventory]LSS_StructureNumber_s)
				//REDRAW([LSS_Inventory]LSS_District_L)
				//REDRAW([LSS_Inventory]LSS_Town_s)
				//REDRAW([LSS_Inventory]LSS_Category_s)
				LSS_UpdateProjNumdropdwn
				CLEAR NAMED SELECTION:C333("InspectionSet")
				WIN_SetWindowTitle(->[LSS_Inventory:165])
			Else 
				InDoubleClick_B:=False:C215
			End if 
		End if 
		
		
	: (Form event code:C388=On Load:K2:1)
		InDoubleClick_B:=False:C215
End case 
