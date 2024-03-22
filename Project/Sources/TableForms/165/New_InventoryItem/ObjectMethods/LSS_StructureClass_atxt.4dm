
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/29/14, 16:51:12
//----------------------------------------------------
If (False:C215)
	//Object Method: [LSS_Inventory].New_InventoryItem.LSS_StructureClass_atxt
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(7/8/15 17:10:15)
	Mods_2015_07_bug
	//  `switched from using Choose to the case statement. Choose did not work compiled!!!!!
	// Modified by: Costas Manousakis-(Designer)-(9/6/16 10:26:37)
	Mods_2016_09
	//  `changed label for Inventory Number HS -HIN, SI - SIN
	Mods_2018_03_bug  //Re-adjust how and when get next number
	//Modified by: Chuck Miller (3/20/18 15:36:1
End if 

If (LSS_StructureClass_atxt>0)
	OBJECT SET VISIBLE:C603(*; "StructureType@"; True:C214)
	
	If (False:C215)
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
	OBJECT SET TITLE:C194(*; "EditIDNum"; "Edit "+LSS_SIN_Label_txt)
	
	LSS_FillStructureTypes([LSS_Inventory:165]LSS_InventoryType_s:28)
	If (Size of array:C274(v_171_003_atxt)=0)
		OBJECT SET VISIBLE:C603(*; "StructureType@"; False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*; "StructureType@"; True:C214)
		OBJECT SET ENABLED:C1123(*; "StructureType@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	End if 
	
Else 
	OBJECT SET VISIBLE:C603(*; "StructureType@"; False:C215)
	
	[LSS_Inventory:165]LSS_InventoryType_s:28:=""
	[LSS_Inventory:165]LSS_Category_s:2:=""
End if 
LSS_SIN_2_L:=0

LSS_SetInventoryNumber

//End Object Method: [LSS_Inventory].New_InventoryItem.LSS_StructureClass_atxt

