If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 10/02/14, 12:30:31
	// ----------------------------------------------------
	// Method: Form Method: [LSS_Inventory];"ListBoxOutput"
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(5/17/16 11:04:28)
	Mods_2016_05
	//  `re-arranged buttons ; added Review button
	// Modified by: Costas Manousakis-(Designer)-(10/4/18 17:05:23)
	Mods_2018_10
	//  `added Owner column to ListBox
	// Modified by: Costas Manousakis-(Designer)-(4/30/20 11:28:18)
	Mods_2020_04
	//  `minor adjustments in pos of listbox, buttons to center them, and allow hor. line to grow.
	// Modified by: Costas Manousakis-(Designer)-(5/12/20 10:07:46)
	Mods_2020_05
	//  `adjusted labels of buttons to split in two lines when needed, and re-spaced them.
	
	// Modified by: manousakisc (4/28/2023)
	Mods_2023_LSSNew
	// add columns for status, year built, proj num built in Listbox 
	// status column has methods for background and text color
	// add dropdown for status, project num filters
	// add code in Show all, query, show subset object methods to reset the filter dropdowns
	
End if 
Case of 
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		
	: (Form event code:C388=On Load:K2:1)
		
		C_TEXT:C284($SQL_txt)
		$SQL_txt:="Select [Town Data].[Town Name], [Town Data].[District], [Town Data].[BDEPT Prefix] "
		$SQL_txt:=$SQL_txt+"from [Town Data] "
		ARRAY TEXT:C222(LSS_TownName_atxt; 0)
		ARRAY TEXT:C222(LSS_TownDistrict_atxt; 0)
		ARRAY TEXT:C222(LSS_TownBDEPT_atxt; 0)
		
		C_LONGINT:C283($Loop_L)
		C_BOOLEAN:C305($ShowAdd_B)
		$ShowAdd_B:=False:C215
		If (LSS_ADDInventory_aB{7}) | (User in group:C338(Current user:C182; "Design Access Group"))
			$ShowAdd_B:=True:C214
		Else 
			$SQL_txt:=$SQL_txt+"Where  [Town Data].[District] in ("
			For ($Loop_L; 1; 6)
				If (LSS_ADDInventory_aB{$Loop_L})
					$ShowAdd_B:=True:C214
					$SQL_txt:=$SQL_txt+Char:C90(Quote:K15:44)+String:C10($Loop_L; "00")+Char:C90(Quote:K15:44)+" , "
				End if 
				
			End for 
			$SQL_txt:=$SQL_txt+") "
			$SQL_txt:=Replace string:C233($SQL_txt; ", )"; ")")
			
		End if 
		$SQL_txt:=$SQL_txt+"into :LSS_TownName_atxt, :LSS_TownDistrict_atxt, :LSS_TownBDEPT_atxt; "
		
		If ($ShowAdd_B)
			Begin SQL
				EXECUTE IMMEDIATE :$SQL_txt;
			End SQL
		End if 
		
		LSS_PermissionADDInventory
		If (Size of array:C274(LSS_TownName_atxt)=0)
			LSS_AllowNewInventoryItem_b:=False:C215
		End if 
		C_LONGINT:C283(LB_SortDirection4_l)
		WIN_SetWindowTitle(->[LSS_Inventory:165])
		
		If (LSS_AllowNewInventoryItem_b)
			OBJECT SET ENABLED:C1123(bAdd; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(bAdd; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
		LSS_UpdateProjNumdropdwn
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
End case 
