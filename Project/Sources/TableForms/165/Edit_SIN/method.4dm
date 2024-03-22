//Method: Form Method: [LSS_Inventory];"Edit_SIN"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/02/15, 17:28:30
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09_bug
	
	Mods_2016_01_bug  // Add items that user can change in Structure number
	//Modified by: administrator (1/7/16 14:53:31)
	// Modified by: Costas Manousakis-(Designer)-(1/14/16 17:31:29)
	Mods_2016_01_bug
	//  `Addition of changing  the town/District ; Added city / town /distr ;moved obj down by 30 ;  changed form method
	
	// Modified by: Costas Manousakis-(Designer)-(9/6/16 10:26:37)
	Mods_2016_09
	//  `changed label for Inventory Number HS -HIN, SI - SIN
	// Modified by: Costas Manousakis-(Designer)-(3/27/18 15:58:33)
	Mods_2018_03_bug
	//  `fixed min and max numbers for kilo and mile points
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		START TRANSACTION:C239
		utl_SetSpellandContextMenu
		LSS_RouteDirection_as:=-1
		LSS_SIN_Label_txt:="SIN"
		LSS_SIN_2_L:=Num:C11(Substring:C12(String:C10([LSS_Inventory:165]LSS_IdentificationNumber_L:5); 2))
		v_165_006_txt:=[LSS_Inventory:165]LSS_StructureNumber_s:6
		v_165_005_L:=[LSS_Inventory:165]LSS_IdentificationNumber_L:5
		
		LSS_TownCode_s:=Substring:C12([LSS_Inventory:165]LSS_StructureNumber_s:6; 1; 3)
		LSS_Route_L:=Num:C11(Substring:C12([LSS_Inventory:165]LSS_Route_s:9; 2; 4))
		LSS_RouteDesignation_s:=Substring:C12([LSS_Inventory:165]LSS_Route_s:9; 1; 1)
		LSS_RouteSuffix_L:=0
		If (Substring:C12([LSS_Inventory:165]LSS_Route_s:9; 5; 1)="A")
			LSS_RouteSuffix_L:=1
		End if 
		v_165_007_r:=[LSS_Inventory:165]LSS_KiloPoint_r:7
		v_165_008_r:=[LSS_Inventory:165]LSS_MilePoint_r:8
		
		If (Size of array:C274(LSS_RouteDesignation_atxt)=0)
			ARRAY TEXT:C222(LSS_RouteDirection_as; 7)  //Command Replaced was o_ARRAY string length was 2
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
			
		End if 
		
		LSS_RouteDesignation_atxt:=Find in array:C230(LSS_RouteDesignation_atxt; LSS_RouteDesignation_s+"@")
		LSS_TownName_atxt:=Find in array:C230(LSS_TownName_atxt; [LSS_Inventory:165]LSS_Town_s:4)
		
		If (Records in selection:C76([LSS_Inspection:164])=0)
			OBJECT SET ENABLED:C1123(*; "StructureClass2"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(*; "StructureClass2"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
		Case of 
			: ([LSS_Inventory:165]LSS_InventoryType_s:28="HS")
				LSS_StructureClass_atxt:=2
				LSS_SIN_Label_txt:="HIN"
			: ([LSS_Inventory:165]LSS_InventoryType_s:28="LI")
				LSS_StructureClass_atxt:=3
				LSS_SIN_Label_txt:="LIN"
			: ([LSS_Inventory:165]LSS_InventoryType_s:28="SI")
				LSS_StructureClass_atxt:=4
				LSS_SIN_Label_txt:="SIN"
			: ([LSS_Inventory:165]LSS_InventoryType_s:28="IT")
				LSS_StructureClass_atxt:=5
				LSS_SIN_Label_txt:="IIN"
		End case 
		OBJECT SET ENABLED:C1123(*; "ApplyButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
	: (Form event code:C388=On Validate:K2:3)
	: (Form event code:C388=On Unload:K2:2)
		OBJECT SET ENTERABLE:C238(*; "KiloPoint"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "MilePoint"; False:C215)
End case 

//End Form Method: [LSS_Inventory]Edit_SIN