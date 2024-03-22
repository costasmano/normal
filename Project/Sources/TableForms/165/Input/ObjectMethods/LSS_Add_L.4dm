
// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 10/14/14, 11:55:32
// ----------------------------------------------------
// Method: Object Method: [LSS_Inventory].Input.LSS_Add_L
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  //Add ability to approve or reject  LSS inspections 
	//Modified by: administrator (11/10/15 16:45:30)
	Mods_2018_11  //Add LSS_EditingInspection_B = true if we can addfa dfn do so we are automatically editing the record aswell
	//This fixed issue with adding Ut record for a new inspection.
	//Modified by: Chuck Miller (11/8/18 15:34:43)
End if 
C_TEXT:C284($QueryBy_txt)
$QueryBy_txt:=""
Case of 
	: ([LSS_Inventory:165]LSS_Category_s:2="Sign") | ([LSS_Inventory:165]LSS_InventoryType_s:28="HS")
		$QueryBy_txt:="HS"
	: ([LSS_Inventory:165]LSS_Category_s:2="Light") | ([LSS_Inventory:165]LSS_InventoryType_s:28="LI")
		$QueryBy_txt:="LI"
	: ([LSS_Inventory:165]LSS_Category_s:2="Signal") | ([LSS_Inventory:165]LSS_InventoryType_s:28="SI")
		$QueryBy_txt:="SI"
		
	: ([LSS_Inventory:165]LSS_Category_s:2="ITS") | ([LSS_Inventory:165]LSS_InventoryType_s:28="IT")
		$QueryBy_txt:="IT"
		
End case 
If ($QueryBy_txt="")
	ALERT:C41("You may not add an inspection because the Structural Class has not been specified!")
Else 
	//QUERY([LSS_refInspectionType];[LSS_refInspectionType]LSS_InspectionTypeId_s=$QueryBy_txt+"@")
	$QueryBy_txt:=$QueryBy_txt+"%"
	ARRAY TEXT:C222($Description_atxt; 0)
	CLEAR VARIABLE:C89($Description_atxt)
	ARRAY TEXT:C222($Key_atxt; 0)
	CLEAR VARIABLE:C89($Key_atxt)
	Begin SQL
		select [LSS_refInspectionType].[LSS_Description_txt],
		[LSS_refInspectionType].[LSS_InspectionTypeId_s]
		from 
		[LSS_refInspectionType]
		where [LSS_refInspectionType].[LSS_InspectionTypeId_s] like :$QueryBy_txt
		into :$Description_atxt,
		:$Key_atxt;
		
	End SQL
	
	$QueryBy_txt:=" "+Char:C90(1)
	C_LONGINT:C283($Loop_L; $Selection_L)
	For ($Loop_L; 1; Size of array:C274($Description_atxt))  //build for pop up array
		$QueryBy_txt:=$QueryBy_txt+$Description_atxt{$Loop_L}+Char:C90(1)
		
	End for 
	$Selection_L:=Pop up menu:C542($QueryBy_txt)
	If ($Selection_L>1)
		START TRANSACTION:C239
		LSS_InspectionTypeID_txt:=$Key_atxt{$Selection_L-1}
		C_TEXT:C284($InputForm_txt)
		CLEAR VARIABLE:C89($InputForm_txt)
		
		//ut_LSSSetModifyInspection 
		LSS_AllowInspectionEdit_B:=True:C214  //if we allow creating then this is true
		LSS_EditingInspection_B:=True:C214
		Case of 
			: ([LSS_Inventory:165]LSS_InventoryType_s:28="HS") | ([LSS_Inventory:165]LSS_Category_s:2="Sign")
				$InputForm_txt:="Input_Sign"
			: ([LSS_Inventory:165]LSS_InventoryType_s:28="LI") | ([LSS_Inventory:165]LSS_Category_s:2="Light")
				$InputForm_txt:="Input_Light"
			: ([LSS_Inventory:165]LSS_InventoryType_s:28="SI") | ([LSS_Inventory:165]LSS_Category_s:2="Signal")
				$InputForm_txt:="Input_Signal"
			: ([LSS_Inventory:165]LSS_InventoryType_s:28="IT") | ([LSS_Inventory:165]LSS_Category_s:2="ITS")
				$InputForm_txt:="Input_ITS"
			Else 
				
		End case 
		
		If ($InputForm_txt#"")
			
			
			ut_SetReadWrite("Write"; ->[LSS_Inspection:164]; ->[LSS_ElementInspection:163]; ->[LSS_Photos:166]; ->[LSS_Accessibility:159]; ->[LSS_DMeter:161]; ->[LSS_UT:175]; ->[LSS_UtResult:176]; ->[LSS_TeamMembers:173])
			
			If ($InputForm_txt="Input_Sign")
				ut_SetReadWrite("Write"; ->[LSS_SignPanel:172]; ->[LSS_TowerDistance:174]; ->[LSS_VerticalClearance:177]; ->[LSS_TowerDistance:174]; ->[LSS_VerticalClearance:177])
			End if 
			If (Modified record:C314([LSS_Inventory:165]))
				FM_SaveInventoryInput
			End if 
			FORM SET INPUT:C55([LSS_Inspection:164]; $InputForm_txt)
			C_LONGINT:C283($Width_L; $Height_L; $Choice_L)
			FORM SET INPUT:C55([LSS_Inspection:164]; $InputForm_txt)
			FORM GET PROPERTIES:C674([LSS_Inspection:164]; $InputForm_txt; $Width_L; $Height_l)
			ut_OpenNewWindow($Width_L; $Height_l; 0; Plain window:K34:13)
			ADD RECORD:C56([LSS_Inspection:164])
			LSS_InitChangeStacks
			LSS_SelectInspectionsForInvItem
			OBJECT SET VISIBLE:C603(*; "LSS_Edit_L"; False:C215)
			OBJECT SET VISIBLE:C603(*; "LSS_Print_L"; False:C215)
			OBJECT SET VISIBLE:C603(*; "LSS_Duplicate_L"; False:C215)
			OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; False:C215)
		Else 
			ALERT:C41("There is no input for assigned for [LSS_Inventory]LSS_InventoryType_s = "+[LSS_Inventory:165]LSS_InventoryType_s:28+" or [LSS_Inventory]LSS_Category_s = "+[LSS_Inventory:165]LSS_Category_s:2)
			
		End if 
		
	End if 
	
End if 
