//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/29/14, 13:07:10
//----------------------------------------------------
//Method: Form Method: [LSS_Inventory]New_InventoryItem
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// 
	
	//Modified by: Charles Miller (4/29/14 13:07:12)
	// Modified by: Costas Manousakis-(Designer)-(2/15/15 19:00:06)
	Mods_2015_02
	//  `fix  styles/size/ some properties of objects on form add remembering  of previous settings
	// Modified by: Costas Manousakis-(Designer)-(7/8/15 17:11:37)
	Mods_2015_07_bug
	//  `switched from using Choose to the case statement. Choose did not work compiled!!!!!
	Mods_2015_08_bug
	//  `Added button "Confirm" to verify changes in SIN. - moved code from the LSS_SIN_2_L object to the confirm button
	//  `make sure pulldowns and fields are enterable on load - to address the logic of the "Confirm" any SIN changes
	// Modified by: Costas Manousakis-(Designer)-(12/23/15 13:43:04)
	Mods_2015_12_bug
	//  `initialize LSS_RouteDesignation_s
	//  `Added Route Suffix Checkbox 
	//  `Added * to indicate required fields
	// Modified by: Costas Manousakis-(Designer)-(9/6/16 10:26:37)
	Mods_2016_09
	//  `changed label for Inventory Number HS -HIN, SI - SIN
	Mods_2017_06_bug  //Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/23/17 12:50:45)
	// Modified by: Costas Manousakis-(Designer)-(3/27/18 16:00:36)
	Mods_2018_03
	//  `fixed min and max numbers for kilo and mile points
	// Modified by: Costas Manousakis-(Designer)-(10/4/18 16:23:46)
	Mods_2018_10
	//  `added dropdown on form and code for [LSS_Inventory]LSS_Owner_s
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		LSS_DuplicateRecordError_B:=False:C215
		LSS_Error_B:=False:C215
		
		utl_SetSpellandContextMenu
		LSS_TownName_atxt:=-1
		C_LONGINT:C283(LSS_SIN_2_L)
		LSS_SIN_2_L:=0
		LSS_StructureClass_atxt:=-1
		LSS_RouteDesignation_atxt:=-1
		LSS_Route_L:=0
		LSS_RouteDesignation_s:=""
		LSS_RouteDirection_as:=-1
		v_171_003_atxt:=-1
		
		C_LONGINT:C283($l; $t; $r; $b; $Width_L; $Height_L)
		FORM GET PROPERTIES:C674([LSS_Inventory:165]; "New_InventoryItem"; $Width_L; $Height_L)
		GET WINDOW RECT:C443($l; $t; $r; $b)
		SET WINDOW RECT:C444($l; $t; $l+$Width_L+5; $t+$Height_L+20)
		
		OBJECT SET ENABLED:C1123(*; "TrapEnter_L"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"TrapEnter_L")
		OBJECT SET ENABLED:C1123(*; "bValidate"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"bValidate")
		OBJECT SET ENABLED:C1123(*; "EditIDNum@"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"EditIDNum@")
		
		START TRANSACTION:C239
		//LSS_Route_L:=0
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
		InitChangeStack(1)  //[LSS_Inventory]
		OBJECT SET ENABLED:C1123(bValidate; False:C215)  // **replaced _ o _DISABLE BUTTON(bValidate)
		If (Is new record:C668([LSS_Inventory:165]))
			C_LONGINT:C283($NextID_L)
			Inc_Sequence("LSS_InventoryId_s"; ->$NextID_L)
			[LSS_Inventory:165]LSS_InventoryId_s:1:=String:C10($NextID_L; <>KeyMask_s)
			
		End if 
		
		C_BOOLEAN:C305($FillArrays_b)
		
		$FillArrays_b:=True:C214
		If (Type:C295(LSS_RouteDirection_as)=Is undefined:K8:13)
			
		Else 
			If (Size of array:C274(LSS_RouteDirection_as)=7)
				$FillArrays_b:=False:C215
			End if 
		End if 
		
		ARRAY TEXT:C222(v_165_034_atxt; 0)
		QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="LSS_Owners")
		ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3; >)
		SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; v_165_034_atxt)
		INSERT IN ARRAY:C227(v_165_034_atxt; 1)
		v_165_034_atxt{1}:=""
		
		ARRAY TEXT:C222(LSS_RouteDirection_as; 7)  // old _ O _ARRAY STRING length 2
		LSS_RouteDirection_as{1}:=""
		LSS_RouteDirection_as{2}:="N"
		LSS_RouteDirection_as{3}:="S"
		LSS_RouteDirection_as{4}:="E"
		LSS_RouteDirection_as{5}:="W"
		LSS_RouteDirection_as{6}:="NS"
		LSS_RouteDirection_as{7}:="EW"
		ARRAY TEXT:C222(LSS_RouteDesignation_atxt; 4)
		LSS_RouteDesignation_atxt{1}:=""
		LSS_RouteDesignation_atxt{2}:="Interstate"
		LSS_RouteDesignation_atxt{3}:="MA Highway"
		LSS_RouteDesignation_atxt{4}:="US Highway"
		
		
		ARRAY TEXT:C222(LSS_StructureClass_atxt; 5)
		LSS_StructureClass_atxt{1}:=""
		LSS_StructureClass_atxt{2}:="Highway Sign"
		LSS_StructureClass_atxt{3}:="Lighting"
		LSS_StructureClass_atxt{4}:="Signal"
		LSS_StructureClass_atxt{5}:="Intelligent Structure"
		
		ARRAY TEXT:C222(v_171_003_atxt; 0)
		ARRAY TEXT:C222(v_171_001_atxt; 0)
		OBJECT SET VISIBLE:C603(*; "StructureType@"; False:C215)
		If (LSS_Cities_atxt>0)
			[LSS_Inventory:165]LSS_Town_s:4:=LSS_Cities_atxt{LSS_Cities_atxt}
			[LSS_Inventory:165]LSS_District_L:3:=Num:C11(LSS_TownDistrict_atxt{LSS_Cities_atxt})
			LSS_TownCode_s:=LSS_TownBDEPT_atxt{LSS_Cities_atxt}
		End if 
		If (LSS_RouteDesignation_atxt>1)
			LSS_RouteDesignation_s:=Substring:C12(LSS_RouteDesignation_atxt{LSS_RouteDesignation_atxt}; 1; 1)
			[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "0000")
		End if 
		
		If (LSS_RouteDirection_as>1)
			[LSS_Inventory:165]LSS_RouteDirection_s:14:=LSS_RouteDirection_as{LSS_RouteDirection_as}
		End if 
		If (LSS_TownName_atxt>1)
			[LSS_Inventory:165]LSS_Town_s:4:=LSS_TownName_atxt{LSS_TownName_atxt}
			[LSS_Inventory:165]LSS_District_L:3:=Num:C11(LSS_TownDistrict_atxt{LSS_TownName_atxt})
			LSS_TownCode_s:=LSS_TownBDEPT_atxt{LSS_TownName_atxt}
		End if 
		
		OBJECT SET ENABLED:C1123(*; "LSS_TownName_atxt"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"LSS_TownName_atxt")
		OBJECT SET ENABLED:C1123(*; "LSS_StructureClass_atxt"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"LSS_StructureClass_atxt")
		OBJECT SET ENABLED:C1123(*; "LSS_RouteDesignation_atxt"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"LSS_RouteDesignation_atxt")
		OBJECT SET ENABLED:C1123(*; "LSS_RouteDirection_as"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"LSS_RouteDirection_as")
		OBJECT SET ENTERABLE:C238(*; "LSS_Route_L"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "LSS_KiloPoint_r"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "LSS_MilePoint_r"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "LSS_Route_L@"; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_Route_L@"; <>color_editable)
		OBJECT SET RGB COLORS:C628(*; "LSS_MilePoint_r@"; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_MilePoint_r@"; <>color_editable)
		OBJECT SET RGB COLORS:C628(*; "LSS_KiloPoint_r@"; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_KiloPoint_r@"; <>color_editable)
		
		LSS_SIN_Label_txt:="SIN"
		
		If (LSS_StructureClass_atxt>1)
			OBJECT SET VISIBLE:C603(*; "StructureType@"; True:C214)
			
			If (True:C214)
				Case of 
					: (LSS_StructureClass_atxt=2)
						[LSS_Inventory:165]LSS_InventoryType_s:28:="HS"
						[LSS_Inventory:165]LSS_Category_s:2:="Sign"
						LSS_SIN_Label_txt:="HIN"
					: (LSS_StructureClass_atxt=3)
						[LSS_Inventory:165]LSS_InventoryType_s:28:="LI"
						[LSS_Inventory:165]LSS_Category_s:2:="Light"
						LSS_SIN_Label_txt:="LIN"
					: (LSS_StructureClass_atxt=4)
						[LSS_Inventory:165]LSS_InventoryType_s:28:="SI"
						[LSS_Inventory:165]LSS_Category_s:2:="Signal"
						LSS_SIN_Label_txt:="SIN"
					: (LSS_StructureClass_atxt=5)
						[LSS_Inventory:165]LSS_InventoryType_s:28:="IT"
						[LSS_Inventory:165]LSS_Category_s:2:="ITS"
						LSS_SIN_Label_txt:="IIN"
						
				End case 
			Else 
				[LSS_Inventory:165]LSS_InventoryType_s:28:=Replace string:C233(Choose:C955(LSS_StructureClass_atxt; (20*" "); ""; "HS"; "LI"; "SI"; "IT"); " "; "")
				[LSS_Inventory:165]LSS_Category_s:2:=Replace string:C233(Choose:C955(LSS_StructureClass_atxt; 20*(" "); ""; "Sign"; "Light"; "Signal"; "ITS"); " "; "")
				LSS_SIN_Label_txt:=Replace string:C233(Choose:C955(LSS_StructureClass_atxt; 20*(" "); ""; "HIN"; "LIN"; "SIN"; "IIN"); " "; "")
			End if 
			
			LSS_FillStructureTypes([LSS_Inventory:165]LSS_InventoryType_s:28)
		Else 
			OBJECT SET VISIBLE:C603(*; "StructureType@"; False:C215)
		End if 
		OBJECT SET TITLE:C194(*; "EditIDNum"; "Edit "+LSS_SIN_Label_txt)
		
	: (Form event code:C388=On Outside Call:K2:11)
		
End case 

//End Form Method: [LSS_Inventory]New_InventoryItem