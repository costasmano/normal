//%attributes = {"invisible":true}
//Method: LSS_SetUpArraysforElements
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 01/18/19, 13:37:40
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01  //add [LSS_ElementInspection] query and report
	//Modified by: Chuck Miller (1/24/19 11:42:45)
End if 
//
C_LONGINT:C283($offset_L)
ARRAY TEXT:C222(v_162_002_atxt; 0)
ARRAY LONGINT:C221(v_162_001_aL; 0)
ARRAY TEXT:C222(LSS_Headers_atxt; 0)
Case of 
	: ([LSS_Inventory:165]LSS_InventoryType_s:28="HS")
		LSS_StructureClass_txt:="Structure Class : Highway Sign"
		
		$offset_L:=0
		BLOB TO VARIABLE:C533(<>HSBlob_blb; v_162_002_atxt; $offset_L)
		BLOB TO VARIABLE:C533(<>HSBlob_blb; v_162_001_aL; $offset_L)
		BLOB TO VARIABLE:C533(<>HSBlob_blb; LSS_Headers_atxt; $offset_L)
		BLOB TO VARIABLE:C533(<>HSBlob_blb; cboInspType; $offset_L)
		
	: ([LSS_Inventory:165]LSS_InventoryType_s:28="LI")
		LSS_StructureClass_txt:="Structure Class : Lighting"
		$offset_L:=0
		BLOB TO VARIABLE:C533(<>LIBlob_blb; v_162_002_atxt; $offset_L)
		BLOB TO VARIABLE:C533(<>LIBlob_blb; v_162_001_aL; $offset_L)
		BLOB TO VARIABLE:C533(<>LIBlob_blb; LSS_Headers_atxt; $offset_L)
		BLOB TO VARIABLE:C533(<>LIBlob_blb; cboInspType; $offset_L)
		
		
	: ([LSS_Inventory:165]LSS_InventoryType_s:28="SI")
		LSS_StructureClass_txt:="Structure Class : Signal"
		$offset_L:=0
		BLOB TO VARIABLE:C533(<>SIBlob_blb; v_162_002_atxt; $offset_L)
		BLOB TO VARIABLE:C533(<>SIBlob_blb; v_162_001_aL; $offset_L)
		BLOB TO VARIABLE:C533(<>SIBlob_blb; LSS_Headers_atxt; $offset_L)
		BLOB TO VARIABLE:C533(<>SIBlob_blb; cboInspType; $offset_L)
		
		
	: ([LSS_Inventory:165]LSS_InventoryType_s:28="IT")
		LSS_StructureClass_txt:="Structure Class : Intelligent Structure"
		BLOB TO VARIABLE:C533(<>ITBlob_blb; v_162_002_atxt; $offset_L)
		BLOB TO VARIABLE:C533(<>ITBlob_blb; v_162_001_aL; $offset_L)
		BLOB TO VARIABLE:C533(<>ITBlob_blb; LSS_Headers_atxt; $offset_L)
		BLOB TO VARIABLE:C533(<>ITBlob_blb; cboInspType; $offset_L)
		
		
End case 

//End LSS_SetUpArraysforElements